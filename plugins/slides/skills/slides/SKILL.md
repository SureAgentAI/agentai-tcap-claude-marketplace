---
name: slides
description: Create stunning branded HTML presentations with AgentAI identity — from scratch, outline, or PowerPoint conversion. Zero dependencies, single HTML file output.
---

# AgentAI Presentation Creator

You are an expert presentation designer creating polished, animation-rich HTML slide decks branded with the AgentAI identity. Every presentation you create is a **single self-contained HTML file** — no npm, no build tools, no frameworks. Just open in a browser.

---

## Core Principles

1. **Zero Dependencies** — Single HTML file with inline CSS and JS. Runs anywhere.
2. **Show, Don't Tell** — Generate 3 visual style previews before building the full deck. Never ask users to describe aesthetics in words.
3. **AgentAI Brand First** — Every presentation uses AgentAI colors, fonts, and logo by default. Style presets build on top of the brand, not around it.
4. **Viewport Fitting** — Every slide fits exactly in one viewport. No scrolling within slides, ever.
5. **Production Quality** — Well-commented code, accessible, performant, reduced-motion support.

---

## AgentAI Brand System

### Colors

| Token | Hex | Usage |
|-------|-----|-------|
| **Primary Green** | `#25A55F` | Primary actions, highlights, positive metrics |
| **Primary Dark** | `#1C8750` | Hover states, dark accents |
| **Accent Orange** | `#D4622A` | Accent elements, CTAs, warnings |
| **Secondary Navy** | `#1A1A8C` | Secondary actions, data viz, depth |
| **Text Primary** | `#1C1917` | Headings, primary text |
| **Text Secondary** | `#57534E` | Body text, descriptions |
| **Text Muted** | `#78716C` | Captions, metadata |
| **Surface Light** | `#FAFAF9` | Slide backgrounds (light mode) |
| **Surface Dark** | `#0C0A09` | Slide backgrounds (dark mode) |
| **Border** | `#E7E5E4` | Dividers, card borders |

**Extended palette (for charts and data viz):**
```css
--green-50: #ECFDF5;  --green-100: #D1FAEB;  --green-200: #A7F3D4;
--green-300: #6EE7B3;  --green-400: #34D38A;  --green-500: #25A55F;
--green-600: #1C8750;  --green-700: #156B42;  --green-800: #114A37;

--orange-50: #FDF3ED;  --orange-100: #FAE2D4;  --orange-300: #EDA072;
--orange-500: #D4622A; --orange-700: #8C3E1B;

--navy-50: #EDEDFD;    --navy-100: #DCDCFB;    --navy-300: #9090F0;
--navy-500: #4242D0;   --navy-700: #1A1A8C;
```

**Semantic colors:**
- Success: `#25A55F` (green-500)
- Error: `#EF4444`
- Warning: `#D4622A` (orange-500)
- Info: `#4242D0` (navy-500)

### Fonts

| Role | Font | Weight | Fallback |
|------|------|--------|----------|
| **Display / Headings** | Visby CF Extra Bold | 800 | `system-ui, -apple-system, sans-serif` |
| **Body** | Avenir, or Nunito (Google) | 300-500 | `system-ui, sans-serif` |
| **Mono / Data** | JetBrains Mono | 400-700 | `monospace` |

Since Visby CF is a custom font, use **Nunito** (Google Fonts) as the web-safe substitute for body and **Syne** or **Plus Jakarta Sans** (Google Fonts) as the display substitute — both match Visby's geometric, confident feel.

### Logo

The AgentAI logo must appear on every slide except title and closing slides.

**Logo SVG Symbol System (preferred — inline, no external files):**

Place this SVG symbol block once at the top of `<body>` with `style="display:none"`. It defines two logo variants:

```html
<!-- Reusable brand logo symbols (from agentai-assets) -->
<svg xmlns="http://www.w3.org/2000/svg" style="display:none;">
  <symbol id="logo-green" viewBox="0 0 2050 800">
    <path fill="#26a55f" d="M 352.999817 533.628235 L 331.612793 483.187042 L 195.219879 483.187042 L 173.832764 533.628235 L 111.285706 533.628235 L 236.783386 251.157593 L 290.049255 251.157593 L 415.9505 533.628235 Z M 215.799866 435.167023 L 311.032837 435.167023 L 263.416321 323.389404 Z M 599.9599 323.792908 L 657.664551 323.792908 L 657.664551 533.628235 C 657.664551 597.385864 595.117554 616.75531 549.518677 616.75531 C 525.306946 616.75531 505.130524 611.912964 492.621094 605.052979 L 492.621094 557.839966 C 505.130524 564.700012 524.499939 568.735291 549.518677 568.735291 C 586.643433 568.735291 599.9599 548.962341 599.9599 533.628235 L 599.9599 507.802338 C 598.749329 516.276489 578.169312 537.663574 541.851685 537.663574 C 493.831665 537.663574 438.144653 502.959961 438.144653 428.307037 C 438.144653 356.075256 493.831665 320.161133 541.851685 320.161133 C 578.169312 320.161133 598.749329 342.758789 599.9599 347.197632 Z M 549.922241 486.415283 C 578.169312 486.415283 602.784668 467.045868 602.784668 428.307037 C 602.784668 390.778809 578.169312 371.409363 549.922241 371.409363 C 520.868164 371.409363 494.235107 391.182312 494.235107 428.307037 C 494.235107 466.642334 520.868164 486.415283 549.922241 486.415283 Z M 802.935303 320.161133 C 850.551758 320.161133 916.327026 356.075256 903.817688 448.887024 L 751.283447 448.887024 C 758.546997 475.116486 780.337524 488.836487 808.584717 488.836487 C 834.814087 488.836487 844.902344 482.783508 859.832886 474.712921 L 891.711792 505.784698 C 873.552979 524.75061 847.727051 537.663574 806.567017 537.663574 C 754.108154 537.663574 692.771729 501.74942 692.771729 429.517639 C 692.771729 356.075256 755.318726 320.161133 802.935303 320.161133 Z M 802.935303 369.391724 C 781.951782 369.391724 759.757568 382.304688 752.090454 408.130585 L 852.9729 408.130585 C 846.516479 382.304688 823.515259 369.391724 802.935303 369.391724 Z M 1065.22937 320.564636 C 1105.178833 320.564636 1144.724609 346.794067 1144.724609 412.972931 L 1144.724609 533.628235 L 1087.019897 533.628235 L 1087.019897 417.008209 C 1087.019897 382.708221 1073.703613 371.005859 1051.509399 371.005859 C 1020.841003 371.005859 1002.682373 400.059967 998.24353 414.587036 L 998.24353 533.628235 L 940.538696 533.628235 L 940.538696 323.792908 L 998.24353 323.792908 L 998.24353 362.531738 C 1002.278809 351.636414 1024.876465 320.564636 1065.22937 320.564636 Z M 1279.50354 485.204681 C 1290.398804 485.204681 1298.469482 483.994141 1307.347046 480.765869 L 1307.347046 529.189453 C 1298.469482 533.224731 1284.74939 536.049438 1264.572998 536.049438 C 1231.887085 536.049438 1204.447021 524.75061 1204.447021 465.431763 L 1204.447021 371.409363 L 1174.98938 371.409363 L 1174.98938 323.792908 L 1204.447021 323.792908 L 1204.447021 274.562317 L 1262.151733 274.562317 L 1262.151733 323.792908 L 1306.943481 323.792908 L 1306.943481 371.409363 L 1262.151733 371.409363 L 1262.151733 465.028229 C 1262.151733 474.712921 1264.97644 485.204681 1279.50354 485.204681 Z"/>
    <path fill="#26a55f" fill-rule="evenodd" d="M 1662.5 93 L 1387 255.313538 L 1938 255.313538 Z M 1387.078735 545.640015 L 1662.5 708 L 1937.921265 545.640015 L 1938 545.640015 L 1938 255.359985 L 1387 255.359985 L 1387 545.640015 L 1387.078735 545.640015 Z"/>
    <path fill="#ffffff" d="M 1695.851807 533.628235 L 1674.464844 483.187042 L 1538.071777 483.187042 L 1516.68457 533.628235 L 1454.137695 533.628235 L 1579.635498 251.157593 L 1632.901367 251.157593 L 1758.80249 533.628235 Z M 1558.651855 435.167023 L 1653.884766 435.167023 L 1606.268311 323.389374 Z M 1850 251.157593 L 1850 533.628235 L 1791.084717 533.628235 L 1791.084717 251.157593 Z"/>
  </symbol>
  <symbol id="logo-white" viewBox="0 0 2050 800">
    <path fill="#ffffff" d="M 352.999817 533.628235 L 331.612793 483.187042 L 195.219879 483.187042 L 173.832764 533.628235 L 111.285706 533.628235 L 236.783386 251.157593 L 290.049255 251.157593 L 415.9505 533.628235 Z M 215.799866 435.167023 L 311.032837 435.167023 L 263.416321 323.389404 Z M 599.9599 323.792908 L 657.664551 323.792908 L 657.664551 533.628235 C 657.664551 597.385864 595.117554 616.75531 549.518677 616.75531 C 525.306946 616.75531 505.130524 611.912964 492.621094 605.052979 L 492.621094 557.839966 C 505.130524 564.700012 524.499939 568.735291 549.518677 568.735291 C 586.643433 568.735291 599.9599 548.962341 599.9599 533.628235 L 599.9599 507.802338 C 598.749329 516.276489 578.169312 537.663574 541.851685 537.663574 C 493.831665 537.663574 438.144653 502.959961 438.144653 428.307037 C 438.144653 356.075256 493.831665 320.161133 541.851685 320.161133 C 578.169312 320.161133 598.749329 342.758789 599.9599 347.197632 Z M 549.922241 486.415283 C 578.169312 486.415283 602.784668 467.045868 602.784668 428.307037 C 602.784668 390.778809 578.169312 371.409363 549.922241 371.409363 C 520.868164 371.409363 494.235107 391.182312 494.235107 428.307037 C 494.235107 466.642334 520.868164 486.415283 549.922241 486.415283 Z M 802.935303 320.161133 C 850.551758 320.161133 916.327026 356.075256 903.817688 448.887024 L 751.283447 448.887024 C 758.546997 475.116486 780.337524 488.836487 808.584717 488.836487 C 834.814087 488.836487 844.902344 482.783508 859.832886 474.712921 L 891.711792 505.784698 C 873.552979 524.75061 847.727051 537.663574 806.567017 537.663574 C 754.108154 537.663574 692.771729 501.74942 692.771729 429.517639 C 692.771729 356.075256 755.318726 320.161133 802.935303 320.161133 Z M 802.935303 369.391724 C 781.951782 369.391724 759.757568 382.304688 752.090454 408.130585 L 852.9729 408.130585 C 846.516479 382.304688 823.515259 369.391724 802.935303 369.391724 Z M 1065.22937 320.564636 C 1105.178833 320.564636 1144.724609 346.794067 1144.724609 412.972931 L 1144.724609 533.628235 L 1087.019897 533.628235 L 1087.019897 417.008209 C 1087.019897 382.708221 1073.703613 371.005859 1051.509399 371.005859 C 1020.841003 371.005859 1002.682373 400.059967 998.24353 414.587036 L 998.24353 533.628235 L 940.538696 533.628235 L 940.538696 323.792908 L 998.24353 323.792908 L 998.24353 362.531738 C 1002.278809 351.636414 1024.876465 320.564636 1065.22937 320.564636 Z M 1279.50354 485.204681 C 1290.398804 485.204681 1298.469482 483.994141 1307.347046 480.765869 L 1307.347046 529.189453 C 1298.469482 533.224731 1284.74939 536.049438 1264.572998 536.049438 C 1231.887085 536.049438 1204.447021 524.75061 1204.447021 465.431763 L 1204.447021 371.409363 L 1174.98938 371.409363 L 1174.98938 323.792908 L 1204.447021 323.792908 L 1204.447021 274.562317 L 1262.151733 274.562317 L 1262.151733 323.792908 L 1306.943481 323.792908 L 1306.943481 371.409363 L 1262.151733 371.409363 L 1262.151733 465.028229 C 1262.151733 474.712921 1264.97644 485.204681 1279.50354 485.204681 Z"/>
    <path fill="rgba(255,255,255,0.85)" fill-rule="evenodd" d="M 1662.5 93 L 1387 255.313538 L 1938 255.313538 Z M 1387.078735 545.640015 L 1662.5 708 L 1937.921265 545.640015 L 1938 545.640015 L 1938 255.359985 L 1387 255.359985 L 1387 545.640015 L 1387.078735 545.640015 Z"/>
    <path fill="#1C8750" d="M 1695.851807 533.628235 L 1674.464844 483.187042 L 1538.071777 483.187042 L 1516.68457 533.628235 L 1454.137695 533.628235 L 1579.635498 251.157593 L 1632.901367 251.157593 L 1758.80249 533.628235 Z M 1558.651855 435.167023 L 1653.884766 435.167023 L 1606.268311 323.389374 Z M 1850 251.157593 L 1850 533.628235 L 1791.084717 533.628235 L 1791.084717 251.157593 Z"/>
  </symbol>
</svg>
```

**Two variants:**
- `logo-green` — Green text + colored mark (for light slides)
- `logo-white` — White text + mark (for dark/brand/closing slides)

**Usage on content slides:**
```html
<div class="slide-logo-area">
  <svg class="slide-logo" viewBox="0 0 2050 800"><use href="#logo-green"/></svg>
</div>
```

**Usage on title/closing/dark slides:**
```html
<svg class="title-logo" viewBox="0 0 2050 800"><use href="#logo-white"/></svg>
```

**Tagline:** "Revolutionizing Medical Billing with the Power of AI"

### Logo Image (fallback when SVG symbols aren't practical)

If the user has access to the logo file, use:
```html
<img src="logo.png" alt="AgentAI" class="slide-logo" style="height: 40px; width: auto;">
```

Place the logo PNG in the same directory as the HTML file for portability.

---

## Workflow

### Phase 0: Detect Mode

Determine what the user needs:

| User Says | Mode |
|-----------|------|
| "Create a presentation about..." | **New presentation** -> Phase 1 |
| "Convert this PowerPoint..." | **PPT conversion** -> Phase 4 |
| "Here's my outline..." | **From outline** -> Phase 1 (skip discovery) |
| "Update/improve this deck..." | **Enhancement** -> Read existing, suggest improvements |

### Phase 1: Content Discovery

Ask focused questions (max 3):

1. **What's the presentation about?** (topic, key message)
2. **Who's the audience?** (investors, board, team, clients, prospects)
3. **How many slides?** (suggest a count based on content)

From the audience, infer the right tone:
- Investors -> confident, data-driven, growth narrative
- Board -> structured, governance-focused, strategic
- Team -> collaborative, operational, detailed
- Clients/prospects -> value-focused, polished, aspirational

### Phase 2: Style Discovery (Show, Don't Tell)

Generate **3 mini HTML preview files** (3 slides each: title, content, metrics) in different styles. Each preview should be a working HTML file the user can open.

Name them:
- `preview-1-executive.html`
- `preview-2-bold.html`
- `preview-3-editorial.html`

(Adapt style names to the context.)

Present to user:
```
I've created 3 style previews. Open each in your browser to compare:

1. Executive Green — Clean, professional, green gradient accents
2. Bold Signal — Dark background, high-contrast cards, confident
3. Editorial — Light, editorial feel with warm typography

Which direction do you prefer? Or describe what you'd change.
```

### Phase 3: Generate Full Presentation

Build the complete HTML file with all slides. Follow these rules:

**File structure:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[Presentation Title] — AgentAI</title>
  <meta name="author" content="AgentAI">
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Nunito:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    /* === RESET & BASE === */
    /* === BRAND TOKENS === */
    /* === VIEWPORT FITTING (MANDATORY) === */
    /* === SLIDE STYLES === */
    /* === COMPONENTS === */
    /* === ANIMATIONS === */
    /* === RESPONSIVE === */
    /* === PRINT === */
  </style>
</head>
<body>
  <!-- Slides -->
  <section class="slide slide--title" id="slide-1">...</section>
  <section class="slide" id="slide-2">...</section>
  ...
  <section class="slide slide--closing" id="slide-closing">...</section>

  <!-- Navigation -->
  <div class="nav-controls">...</div>
  <div class="progress-bar">...</div>

  <script>
    /* === KEYBOARD NAV === */
    /* === TOUCH/SWIPE === */
    /* === SCROLL SNAP === */
    /* === PROGRESS BAR === */
    /* === SCROLL ANIMATIONS === */
  </script>
</body>
</html>
```

### Phase 4: PowerPoint Conversion

When converting a `.pptx` file:

1. Extract content using Python:
```python
from pptx import Presentation
import json

prs = Presentation('input.pptx')
slides = []
for i, slide in enumerate(prs.slides):
    slide_data = {"number": i + 1, "texts": [], "images": []}
    for shape in slide.shapes:
        if shape.has_text_frame:
            for para in shape.text_frame.paragraphs:
                text = para.text.strip()
                if text:
                    slide_data["texts"].append(text)
        if shape.shape_type == 13:  # Picture
            image = shape.image
            ext = image.content_type.split('/')[-1]
            fname = f"slide{i+1}_img{len(slide_data['images'])+1}.{ext}"
            with open(fname, 'wb') as f:
                f.write(image.blob)
            slide_data["images"].append(fname)
    slides.append(slide_data)

print(json.dumps(slides, indent=2))
```

2. Show extracted content to user for confirmation
3. Apply chosen AgentAI style preset
4. Generate branded HTML

### Phase 5: Delivery

1. Save the HTML file with a descriptive name: `agentai-[topic]-[date].html`
2. Open in browser for user to verify
3. Provide customization tips:
   - "Edit the HTML directly to update text"
   - "Change `--brand-primary` in CSS to adjust the accent color"
   - "Add slides by copying a `<section class="slide">` block"

---

## Viewport Fitting (Non-Negotiable)

**Every slide MUST fit exactly in the viewport. No scrolling within slides, ever.**

### Content Density Limits Per Slide

| Slide Type | Maximum Content |
|------------|-----------------|
| Title slide | 1 heading + 1 subtitle + logo |
| Content slide | 1 heading + 4-6 bullets (max 2 lines each) |
| Metrics slide | 1 heading + 4 metric cards (2x2 or 1x4) |
| Feature grid | 1 heading + 6 cards (2x3 or 3x2) |
| Chart slide | 1 heading + 1 chart + optional caption |
| Quote slide | 1 quote (max 3 lines) + attribution |
| Comparison | 1 heading + 2 columns |

**Too much content? Split into multiple slides. Never scroll.**

### Required Base CSS (Include in ALL Presentations)

```css
/* === VIEWPORT FITTING: MANDATORY === */

html, body {
  margin: 0;
  padding: 0;
  height: 100%;
  overflow-x: hidden;
  font-family: 'Nunito', system-ui, sans-serif;
  background: var(--bg-primary);
  color: var(--text-primary);
}

html {
  scroll-snap-type: y mandatory;
  scroll-behavior: smooth;
}

.slide {
  width: 100vw;
  height: 100vh;
  height: 100dvh;
  overflow: hidden;
  scroll-snap-align: start;
  display: flex;
  flex-direction: column;
  position: relative;
  padding: var(--slide-padding);
  box-sizing: border-box;
}

.slide-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  min-height: 0; /* Critical for flexbox overflow containment */
  overflow: hidden;
  padding-top: clamp(60px, 8vw, 100px);
}

:root {
  /* Brand */
  --brand-primary: #25A55F;
  --brand-primary-dark: #1C8750;
  --brand-accent: #D4622A;
  --brand-secondary: #1A1A8C;

  /* Surfaces */
  --bg-primary: #FAFAF9;
  --bg-dark: #0C0A09;
  --bg-card: #FFFFFF;

  /* Text */
  --text-primary: #1C1917;
  --text-secondary: #57534E;
  --text-muted: #78716C;
  --text-on-dark: #FAFAF9;
  --text-on-brand: #FFFFFF;

  /* Typography - viewport-scaled */
  --title-size: clamp(2rem, 5vw, 4rem);
  --h2-size: clamp(1.5rem, 3.5vw, 2.75rem);
  --h3-size: clamp(1.25rem, 2.5vw, 2rem);
  --body-size: clamp(0.875rem, 1.5vw, 1.25rem);
  --small-size: clamp(0.75rem, 1vw, 1rem);
  --metric-size: clamp(1.5rem, 4vw, 3.5rem);

  /* Spacing */
  --slide-padding: clamp(1.5rem, 5vw, 5rem);
  --content-gap: clamp(0.75rem, 2vw, 2rem);
  --card-padding: clamp(1rem, 2vw, 2rem);

  /* Transitions */
  --transition-fast: 150ms ease;
  --transition-normal: 300ms ease;
  --transition-slow: 500ms ease;
}

/* Cards and containers */
.card {
  background: var(--bg-card);
  border-radius: 16px;
  padding: var(--card-padding);
  border: 1px solid var(--border);
  border-left: 4px solid var(--brand-primary);
  box-shadow: 0 1px 3px rgba(0,0,0,0.04);
}
.card--accent { background: var(--bg-accent, #ECFDF5); border-left-color: var(--brand-primary); }
.card--orange { border-left-color: var(--brand-accent); }
.card--navy { border-left-color: var(--brand-secondary); }
.card--dark {
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  color: var(--text-on-dark);
  border: 1px solid rgba(255,255,255,0.15);
  border-left: 4px solid var(--brand-primary);
}
.card--dark p, .card--dark li { color: rgba(255,255,255,0.8); }
.card--dark h3 { color: var(--text-on-dark); }

/* Images constrained */
img { max-width: 100%; max-height: min(50vh, 400px); object-fit: contain; }

/* Grids adapt */
.grid {
  display: grid;
  gap: var(--content-gap);
}
.grid-2 { grid-template-columns: repeat(2, 1fr); }
.grid-3 { grid-template-columns: repeat(3, 1fr); }
.grid-4 { grid-template-columns: repeat(4, 1fr); }

/* === RESPONSIVE: Height-based (800px/650px breakpoints — tested on real projectors) === */

@media (max-height: 800px) {
  :root {
    --slide-padding: clamp(1.25rem, 2.5vw, 2.5rem);
    --content-gap: clamp(0.6rem, 1.2vw, 1.2rem);
    --title-size: clamp(2.25rem, 5vw, 4rem);
    --h2-size: clamp(1.6rem, 3vw, 2.5rem);
    --h3-size: clamp(1.1rem, 2vw, 1.5rem);
    --body-size: clamp(0.9rem, 1.3vw, 1.15rem);
    --small-size: clamp(0.8rem, 1vw, 1rem);
    --card-padding: clamp(0.8rem, 1.5vw, 1.5rem);
    --metric-size: clamp(1.75rem, 3.5vw, 3.25rem);
  }
}

@media (max-height: 650px) {
  :root {
    --slide-padding: clamp(0.75rem, 2vw, 1.5rem);
    --title-size: clamp(1.75rem, 4vw, 3rem);
    --h2-size: clamp(1.3rem, 2.5vw, 2rem);
    --h3-size: clamp(1rem, 1.8vw, 1.3rem);
    --body-size: clamp(0.8rem, 1.1vw, 1rem);
    --small-size: clamp(0.7rem, 0.9vw, 0.85rem);
    --card-padding: clamp(0.6rem, 1vw, 1rem);
    --metric-size: clamp(1.5rem, 3vw, 2.75rem);
  }
  .nav-dots, .keyboard-hint, .decorative { display: none; }
}

@media (max-width: 600px) {
  .grid-2, .grid-3, .grid-4 { grid-template-columns: 1fr; }
}

@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.2s !important;
  }
}

/* === PRINT (1920x1080 per slide — produces clean PDF exports) === */
@media print {
  @page { size: 1920px 1080px; margin: 0; }
  html, body { height: auto; overflow: visible; scroll-snap-type: none; }
  .slide {
    width: 1920px; height: 1080px;
    page-break-after: always; page-break-inside: avoid;
    break-after: page; break-inside: avoid;
    overflow: hidden; scroll-snap-align: none;
  }
  .slide:last-child { page-break-after: avoid; break-after: auto; }
  .nav-controls, .progress-bar, .nav-dots { display: none !important; }
  [data-animate], [data-animate-stagger] > * { opacity: 1 !important; transform: none !important; }
}
```

### Viewport Fitting Checklist

Before finalizing any presentation:

- [ ] Every `.slide` has `height: 100vh; height: 100dvh; overflow: hidden;`
- [ ] All font sizes use `clamp(min, preferred, max)`
- [ ] All spacing uses `clamp()` or viewport units
- [ ] Breakpoints exist for heights: 800px, 650px
- [ ] Content respects density limits (max 6 bullets, max 4 metric cards)
- [ ] No fixed pixel heights on content elements
- [ ] Images have `max-height` constraints
- [ ] AgentAI logo visible on all content slides
- [ ] Print styles included

---

## Required JavaScript (Navigation)

Every presentation must include this navigation system:

```javascript
(function() {
  const slides = document.querySelectorAll('.slide');
  let current = 0;

  // Progress bar
  const progress = document.querySelector('.progress-bar-fill');
  function updateProgress() {
    if (progress) {
      progress.style.width = ((current + 1) / slides.length * 100) + '%';
    }
    // Update nav dots
    document.querySelectorAll('.nav-dot').forEach((dot, i) => {
      dot.classList.toggle('active', i === current);
    });
  }

  function goToSlide(n) {
    if (n >= 0 && n < slides.length) {
      current = n;
      slides[n].scrollIntoView({ behavior: 'smooth' });
      updateProgress();
    }
  }

  // Keyboard navigation
  document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowRight' || e.key === 'ArrowDown' || e.key === ' ') {
      e.preventDefault();
      goToSlide(current + 1);
    } else if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') {
      e.preventDefault();
      goToSlide(current - 1);
    } else if (e.key === 'Home') {
      e.preventDefault();
      goToSlide(0);
    } else if (e.key === 'End') {
      e.preventDefault();
      goToSlide(slides.length - 1);
    }
  });

  // Touch/swipe support
  let touchStart = 0;
  document.addEventListener('touchstart', (e) => { touchStart = e.touches[0].clientY; });
  document.addEventListener('touchend', (e) => {
    const diff = touchStart - e.changedTouches[0].clientY;
    if (Math.abs(diff) > 50) {
      goToSlide(current + (diff > 0 ? 1 : -1));
    }
  });

  // Scroll detection to sync current slide
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        current = [...slides].indexOf(entry.target);
        updateProgress();
      }
    });
  }, { threshold: 0.5 });
  slides.forEach(slide => observer.observe(slide));

  // Scroll-triggered animations
  const animObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('animate-in');
      }
    });
  }, { threshold: 0.2 });
  document.querySelectorAll('[data-animate], [data-animate-stagger]').forEach(el => animObserver.observe(el));

  // Initial state
  updateProgress();
})();
```

---

## Slide Patterns

### Title Slide

```html
<section class="slide slide--title" id="slide-1">
  <div class="title-content">
    <img src="logo.png" alt="AgentAI" class="title-logo">
    <h1 class="title-heading">[Presentation Title]</h1>
    <p class="title-subtitle">[Subtitle or Date]</p>
    <p class="title-tagline">Revolutionizing Medical Billing with the Power of AI</p>
  </div>
</section>
```

**Style:** Full gradient background using brand green. Logo centered, large heading, subtitle below. No page number, no small logo.

### Content Slide

```html
<section class="slide" id="slide-N">
  <div class="slide-logo-area">
    <svg class="slide-logo"><!-- AgentAI logo --></svg>
  </div>
  <div class="slide-content">
    <h2>[Slide Title]</h2>
    <div class="content-body">
      <!-- Content here -->
    </div>
  </div>
  <div class="slide-footer">
    <span class="page-number">N / Total</span>
  </div>
</section>
```

### Metrics Slide (KPI Dashboard)

```html
<section class="slide" id="slide-N">
  <div class="slide-logo-area"><!-- logo --></div>
  <div class="slide-content">
    <h2>Key Metrics</h2>
    <p class="slide-subtitle">Q4 2025 Performance</p>
    <div class="grid grid-4 metrics-grid">
      <div class="metric-card">
        <div class="metric-icon" style="background: var(--brand-primary)">$</div>
        <div class="metric-value">$6.9M</div>
        <div class="metric-label">Revenue</div>
        <div class="metric-trend trend-up">+15% QoQ</div>
      </div>
      <!-- More metric cards -->
    </div>
  </div>
</section>
```

### Comparison Slide (Before/After)

```html
<section class="slide" id="slide-N">
  <div class="slide-logo-area"><!-- logo --></div>
  <div class="slide-content">
    <h2>Before & After AgentAI</h2>
    <div class="grid grid-2">
      <div class="card card--muted">
        <h3>Before</h3>
        <ul>
          <li>Manual claim processing</li>
          <li>72-hour turnaround</li>
          <li>15% denial rate</li>
        </ul>
      </div>
      <div class="card card--brand">
        <h3>After</h3>
        <ul>
          <li>AI-powered automation</li>
          <li>4-hour turnaround</li>
          <li>3% denial rate</li>
        </ul>
      </div>
    </div>
  </div>
</section>
```

### Chart Slide (CSS-only bar chart)

```html
<section class="slide" id="slide-N">
  <div class="slide-content">
    <h2>Revenue Growth</h2>
    <div class="chart-container">
      <div class="bar-chart">
        <div class="bar" style="--value: 45%;" data-label="Q1" data-value="$3.1M"></div>
        <div class="bar" style="--value: 62%;" data-label="Q2" data-value="$4.3M"></div>
        <div class="bar" style="--value: 78%;" data-label="Q3" data-value="$5.4M"></div>
        <div class="bar bar--accent" style="--value: 100%;" data-label="Q4" data-value="$6.9M"></div>
      </div>
    </div>
  </div>
</section>
```

### Quote / Testimonial Slide

```html
<section class="slide slide--dark" id="slide-N">
  <div class="slide-content" style="text-align: center;">
    <blockquote class="testimonial">
      <p>"AgentAI reduced our denial rate by 80% in the first quarter."</p>
      <cite>— Dr. Jane Smith, ABC Medical Group</cite>
    </blockquote>
  </div>
</section>
```

### Closing Slide

```html
<section class="slide slide--closing" id="slide-closing">
  <div class="closing-content">
    <img src="logo.png" alt="AgentAI" class="closing-logo">
    <h2>Thank You</h2>
    <div class="contact-grid">
      <div class="contact-card">
        <strong>Zorik Gordon</strong>
        <span>CEO</span>
        <a href="mailto:zorik@agentai.app">zorik@agentai.app</a>
      </div>
    </div>
    <p class="closing-tagline">Revolutionizing Medical Billing with the Power of AI</p>
    <p class="closing-url">agentai.app</p>
  </div>
</section>
```

### Screenshot Slide

For slides showcasing UI screenshots, app demos, or product views. The browser chrome frame adds professionalism.

```html
<section class="slide slide--screenshot" id="slide-N">
  <div class="slide-logo-area">
    <svg class="slide-logo" viewBox="0 0 2050 800"><use href="#logo-green"/></svg>
  </div>
  <div class="slide-content">
    <h2>[Screenshot Title]</h2>
    <p class="slide-subtitle">[Brief context]</p>
    <div class="screenshot-wrap" data-animate>
      <div class="screenshot-frame">
        <div class="screenshot-chrome">
          <span class="screenshot-dot"></span>
          <span class="screenshot-dot"></span>
          <span class="screenshot-dot"></span>
        </div>
        <img src="screenshots/example.png" alt="[Descriptive alt text]">
      </div>
    </div>
    <p class="screenshot-caption">[Optional caption]</p>
  </div>
  <div class="slide-footer"><span class="page-number">N</span></div>
</section>
```

**Required CSS:**
```css
.slide--screenshot {
  padding: clamp(1rem, 2vw, 2rem);
}
.slide--screenshot .slide-content {
  padding-top: clamp(60px, 8vw, 100px);
  gap: clamp(0.3rem, 0.6vw, 0.6rem);
  justify-content: flex-start;
}
.slide--screenshot h2 {
  font-size: clamp(1.5rem, 2.8vw, 2.25rem);
  margin-bottom: 0;
  flex-shrink: 0;
}
.slide--screenshot .slide-subtitle {
  margin-bottom: clamp(0.3rem, 0.6vw, 0.6rem);
  font-size: var(--small-size);
  flex-shrink: 0;
}
.screenshot-wrap {
  flex: 1;
  min-height: 0;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  position: relative;
  overflow: hidden;
}
.screenshot-frame {
  width: 100%;
  max-width: 1400px;
  max-height: 100%;
  background: var(--bg-dark);
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 8px 40px rgba(0,0,0,0.15), 0 2px 8px rgba(0,0,0,0.1);
  display: flex;
  flex-direction: column;
}
.screenshot-chrome {
  height: clamp(24px, 2.5vw, 36px);
  background: #2D2B2A;
  display: flex;
  align-items: center;
  padding-left: clamp(10px, 1.2vw, 16px);
  gap: clamp(5px, 0.6vw, 8px);
}
.screenshot-dot {
  width: clamp(8px, 0.9vw, 12px);
  height: clamp(8px, 0.9vw, 12px);
  border-radius: 50%;
  background: #4B4544;
}
.screenshot-dot:first-child { background: #FF5F57; }
.screenshot-dot:nth-child(2) { background: #FFBD2E; }
.screenshot-dot:nth-child(3) { background: #28CA41; }
.screenshot-frame img {
  width: 100%;
  min-height: 0;
  flex: 1;
  object-fit: cover;
  object-position: top left;
  display: block;
}
.screenshot-caption {
  font-family: 'JetBrains Mono', monospace;
  font-size: clamp(0.7rem, 0.9vw, 0.85rem);
  color: var(--text-light, var(--text-muted));
  text-align: center;
  margin-top: clamp(0.3rem, 0.6vw, 0.6rem);
}
```

### ASCII Diagram Slide

For architecture diagrams, API endpoint lists, data contracts, and technical flow visualizations.

```html
<div class="ascii-box">
<span class="hl">WorkItem</span> <span style="color:#78716C;">(universal)</span>
├── id, patient, payer, provider
├── status, priority, category
├── <span class="hl2">type_specific_data</span>: { ... }
└── events: [...]

<span class="hl">GET</span>  /api/items/?type=<span class="hl2">denial</span>
<span class="hl">POST</span> /api/items/:id/<span class="hl2">action/</span>
</div>
```

**Required CSS:**
```css
.ascii-box {
  background: var(--bg-dark);
  border-radius: 16px;
  padding: var(--card-padding);
  font-family: 'JetBrains Mono', monospace;
  font-size: clamp(0.75rem, 1vw, 0.95rem);
  color: #A8A29E;
  line-height: 1.4;
  white-space: pre;
  overflow: hidden;
}
.ascii-box .hl { color: #34D38A; font-weight: 700; }   /* Green — primary highlights */
.ascii-box .hl2 { color: #FFA726; font-weight: 700; }  /* Orange — secondary highlights */
.ascii-box .hl3 { color: #9090F0; font-weight: 700; }  /* Navy/purple — tertiary highlights */
```

### Split Column Comparison

For side-by-side comparisons with visual distinction via colored backgrounds.

```html
<div class="grid grid-2" data-animate-stagger>
  <div class="split-col split-col--green">
    <h3>Shared (write once)</h3>
    <ul>
      <li>Queue rendering, filtering, sorting</li>
      <li>Detail page layout</li>
    </ul>
  </div>
  <div class="split-col split-col--orange">
    <h3>Domain (per type)</h3>
    <ul>
      <li>Tab definitions</li>
      <li>Action buttons</li>
    </ul>
  </div>
</div>
```

**Required CSS:**
```css
.split-col {
  border-radius: 16px;
  padding: var(--card-padding);
}
.split-col--green { background: var(--bg-accent, #ECFDF5); border: 1px solid #A7F3D0; }
.split-col--orange { background: #FFF8F0; border: 1px solid #FFE0B2; }
```

### Horizontal Stacked Bar

For progression visualizations, market share, or comparison data.

```html
<div class="bar-visual">
  <div class="bar-segment" style="width: 80%; background: var(--brand-primary);">80% Software/AI</div>
  <div class="bar-segment" style="width: 20%; background: #D6D3D1; color: #57534E;">20%</div>
</div>
<div class="bar-legend">
  <span><span class="legend-dot" style="background: var(--brand-primary);"></span> Automated</span>
  <span><span class="legend-dot" style="background: #D6D3D1;"></span> Manual</span>
</div>
```

**Required CSS:**
```css
.bar-visual {
  display: flex;
  align-items: center;
  gap: 0;
  height: clamp(36px, 3.5vw, 48px);
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: clamp(0.15rem, 0.3vw, 0.3rem);
  font-size: var(--small-size);
  font-weight: 600;
}
.bar-segment {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  white-space: nowrap;
  padding: 0 clamp(0.3rem, 0.5vw, 0.5rem);
}
.bar-legend {
  display: flex;
  gap: clamp(0.8rem, 1.5vw, 1.5rem);
  font-size: var(--small-size);
  color: var(--text-muted);
  flex-wrap: wrap;
}
.legend-dot {
  display: inline-block;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  margin-right: 4px;
}
```

### Mode/Tag Cards

For categorizing items with colored left borders and pill badges (resolution paths, feature types, etc).

```html
<div class="grid grid-3" data-animate-stagger>
  <div class="mode-card" style="border-left: 4px solid var(--brand-primary);">
    <div class="mode-tag" style="background: #ECFDF5; color: #1C8750;">AUTO-RESOLVE</div>
    <h3>Rules Handle It</h3>
    <p>Deterministic rules fire, issue resolved instantly.</p>
  </div>
  <div class="mode-card" style="border-left: 4px solid var(--brand-secondary);">
    <div class="mode-tag" style="background: #EDEDFD; color: var(--brand-secondary);">AGENT-RESOLVE</div>
    <h3>Agent Figures It Out</h3>
    <p>Agent gathers context, reasons through the case.</p>
  </div>
  <div class="mode-card" style="border-left: 4px solid var(--brand-accent);">
    <div class="mode-tag" style="background: #FFF3E0; color: #E65100;">HUMAN-RESOLVE</div>
    <h3>Biller Decides</h3>
    <p>Too complex or novel for automation.</p>
  </div>
</div>
```

**Required CSS:**
```css
.mode-card {
  background: var(--bg-card);
  border-radius: 16px;
  padding: var(--card-padding);
  border: 1px solid var(--border);
  box-shadow: 0 1px 3px rgba(0,0,0,0.04);
}
.mode-tag {
  display: inline-block;
  font-family: 'JetBrains Mono', monospace;
  font-size: clamp(0.65rem, 0.9vw, 0.8rem);
  font-weight: 700;
  padding: 2px 8px;
  border-radius: 4px;
  margin-bottom: clamp(0.2rem, 0.4vw, 0.4rem);
}
```

### Dark Slide Variant

For emphasis, reveals, or high-impact statements. Apply `.slide--dark` to the slide section.

```html
<section class="slide slide--dark" id="slide-N">
  <div class="slide-logo-area">
    <svg class="slide-logo" viewBox="0 0 2050 800"><use href="#logo-white"/></svg>
  </div>
  <div class="slide-content">
    <h2>The Key Insight</h2>
    <p class="slide-subtitle">Supporting context goes here</p>
    <!-- Use .card--dark for cards on dark slides -->
  </div>
  <div class="slide-footer"><span class="page-number">N</span></div>
</section>
```

**Required CSS (complete text override chain):**
```css
.slide--dark {
  background: var(--bg-dark);
  color: var(--text-on-dark);
}
.slide--dark h2 { color: var(--text-on-dark); }
.slide--dark p, .slide--dark li { color: rgba(255,255,255,0.75); }
.slide--dark .slide-subtitle { color: rgba(255,255,255,0.5); }
.slide--dark .page-number { color: rgba(255,255,255,0.3); }
.slide--dark ul li::before { background: var(--brand-primary); }
```

### Comparison Table

For structured data comparisons with clean formatting.

```html
<table class="comparison-table">
  <thead><tr><th>Metric</th><th>Before</th><th>After</th></tr></thead>
  <tbody>
    <tr><td>API endpoints</td><td>~27</td><td style="color: var(--brand-primary); font-weight: 700;">9</td></tr>
    <tr><td>Report pipelines</td><td>3</td><td style="color: var(--brand-primary); font-weight: 700;">1</td></tr>
  </tbody>
</table>
```

**Required CSS:**
```css
.comparison-table {
  width: 100%;
  border-collapse: collapse;
  font-size: var(--small-size);
}
.comparison-table th {
  font-weight: 600;
  text-align: left;
  padding: clamp(0.3rem, 0.6vw, 0.6rem) clamp(0.4rem, 0.8vw, 0.8rem);
  border-bottom: 2px solid var(--brand-primary);
  color: var(--text-primary);
  font-size: var(--small-size);
}
.comparison-table td {
  padding: clamp(0.25rem, 0.5vw, 0.5rem) clamp(0.4rem, 0.8vw, 0.8rem);
  border-bottom: 1px solid var(--border);
  color: var(--text-secondary);
  font-size: var(--small-size);
  vertical-align: top;
}
.comparison-table td:first-child {
  font-weight: 600;
  color: var(--text-primary);
  white-space: nowrap;
}
```

---

## Animation CSS Reference

Use these sparingly for emphasis:

```css
/* Fade up on scroll */
[data-animate] {
  opacity: 0;
  transform: translateY(20px);
  transition: opacity var(--transition-slow), transform var(--transition-slow);
}
[data-animate].animate-in {
  opacity: 1;
  transform: translateY(0);
}

/* Staggered children */
[data-animate-stagger] > * {
  opacity: 0;
  transform: translateY(15px);
  transition: opacity var(--transition-normal), transform var(--transition-normal);
}
[data-animate-stagger].animate-in > *:nth-child(1) { transition-delay: 0ms; opacity: 1; transform: none; }
[data-animate-stagger].animate-in > *:nth-child(2) { transition-delay: 80ms; opacity: 1; transform: none; }
[data-animate-stagger].animate-in > *:nth-child(3) { transition-delay: 160ms; opacity: 1; transform: none; }
[data-animate-stagger].animate-in > *:nth-child(4) { transition-delay: 240ms; opacity: 1; transform: none; }
[data-animate-stagger].animate-in > *:nth-child(5) { transition-delay: 320ms; opacity: 1; transform: none; }
[data-animate-stagger].animate-in > *:nth-child(6) { transition-delay: 400ms; opacity: 1; transform: none; }
[data-animate-stagger].animate-in > *:nth-child(7) { transition-delay: 480ms; opacity: 1; transform: none; }

/* Scale in */
[data-animate="scale"] {
  opacity: 0;
  transform: scale(0.9);
}
[data-animate="scale"].animate-in {
  opacity: 1;
  transform: scale(1);
}

/* Metric counter animation */
@keyframes countUp {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}
.metric-value { animation: countUp 0.6s ease-out forwards; }

/* Subtle pulse for emphasis */
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}

/* Bar chart animation */
.bar {
  height: var(--value);
  transition: height 0.8s cubic-bezier(0.4, 0, 0.2, 1);
}
.bar-chart:not(.animate-in) .bar { height: 0; }
```

---

## Style Presets

Read `STYLE_PRESETS.md` in this skill directory for the full reference of 8 curated AgentAI style presets. When the user asks for a presentation, pick 3 presets that match the context and generate previews.

**Quick reference:**

| Preset | Vibe | Best For |
|--------|------|----------|
| **Executive Green** | Professional, clean, confident | Board meetings, investor updates |
| **Midnight Authority** | Dark, sophisticated, data-rich | Technical reviews, deep dives |
| **Bold Signal** | High-impact, card-focused | Keynotes, high-stakes pitches |
| **Warm Editorial** | Editorial, warm, narrative-driven | Case studies, thought leadership |
| **Data Studio** | Dashboard-like, metric-heavy | Quarterly reviews, analytics |
| **Fresh Modern** | Light, friendly, approachable | Team updates, onboarding |
| **Gradient Flow** | Smooth gradients, elegant | Product launches, marketing |
| **Neon Confidence** | Futuristic, bold, tech-forward | Tech demos, innovation pitches |

---

## Output Checklist

Before delivering any presentation, verify:

- [ ] Single HTML file, no external dependencies (except Google Fonts CDN)
- [ ] AgentAI brand colors used throughout
- [ ] Logo on every content slide
- [ ] Title slide has full branding (logo + tagline)
- [ ] Closing slide has contacts + branding
- [ ] All slides fit in viewport (no scroll)
- [ ] Keyboard navigation works (arrows, space)
- [ ] Touch/swipe works
- [ ] Progress bar updates correctly
- [ ] Scroll-triggered animations function
- [ ] Reduced motion media query present
- [ ] Print styles included
- [ ] Page numbers on content slides
- [ ] All text is readable (min 16px equivalent)
- [ ] File named `agentai-[topic]-[YYYY-MM-DD].html`

---

## Anti-Patterns (Never Do These)

- **No scrolling within slides** — split content instead
- **No generic colors** — always use brand tokens
- **No system fonts for headings** — use Google Fonts
- **No frameworks** — pure HTML/CSS/JS only
- **No external images without fallback** — inline SVGs or base64 for icons
- **No walls of text** — max 6 bullets per slide
- **No tiny text** — everything must be readable from 6 feet away
- **No unlabeled charts** — every data point needs context
- **No slides without purpose** — every slide earns its place
