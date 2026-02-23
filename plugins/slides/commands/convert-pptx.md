---
description: Convert a PowerPoint (.pptx) file to a branded AgentAI HTML presentation
allowed-tools: Bash, Read, Write, Glob
---

# /convert-pptx

Convert a PowerPoint file into a branded AgentAI HTML presentation.

## Usage

```
/convert-pptx path/to/presentation.pptx
```

## Workflow

### 1. Extract Content

Use Python to extract text and images from the PPTX:

```bash
python3 -c "
from pptx import Presentation
import json, sys, os

prs = Presentation(sys.argv[1])
slides = []
img_dir = 'pptx_images'
os.makedirs(img_dir, exist_ok=True)

for i, slide in enumerate(prs.slides):
    data = {'number': i + 1, 'texts': [], 'images': [], 'notes': ''}
    for shape in slide.shapes:
        if shape.has_text_frame:
            for para in shape.text_frame.paragraphs:
                text = para.text.strip()
                if text:
                    level = para.level
                    data['texts'].append({'text': text, 'level': level})
        if shape.shape_type == 13:
            ext = shape.image.content_type.split('/')[-1]
            fname = f'{img_dir}/slide{i+1}_img{len(data[\"images\"])+1}.{ext}'
            with open(fname, 'wb') as f:
                f.write(shape.image.blob)
            data['images'].append(fname)
    if slide.has_notes_slide:
        data['notes'] = slide.notes_slide.notes_text_frame.text.strip()
    slides.append(data)

print(json.dumps(slides, indent=2))
" "$1"
```

If `python-pptx` is not installed:
```bash
pip3 install python-pptx
```

### 2. Show Extracted Content

Display the extracted content to the user for review:

```
Extracted from your PowerPoint:

Slide 1: [Title text]
  - [Bullet 1]
  - [Bullet 2]
  Images: slide1_img1.png

Slide 2: [Section heading]
  - [Content]
  ...

Does this look correct? Any slides to skip or modify?
```

### 3. Choose Style

Ask which style preset to apply (or show 3 previews using the `/new-presentation` workflow).

Default: **Executive Green** for professional presentations.

### 4. Generate HTML

Using the `slides` skill:

1. Map each PowerPoint slide to the appropriate HTML slide pattern
2. Apply the AgentAI brand system
3. Embed extracted images as base64 or reference local files
4. Add navigation, animations, and responsive scaling
5. Save as `agentai-[original-name]-[YYYY-MM-DD].html`

### 5. Clean Up

Offer to remove the temporary `pptx_images/` directory after the HTML is generated.

## Notes

- Images are extracted to a local `pptx_images/` folder
- For fully portable output, images can be base64-encoded inline (increases file size)
- Speaker notes from the PowerPoint are preserved as HTML comments
- Complex PowerPoint animations are simplified to CSS scroll-triggered animations
- Tables are converted to HTML tables with AgentAI styling
- Charts are recreated as CSS-only equivalents where possible
