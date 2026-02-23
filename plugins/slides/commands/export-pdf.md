---
description: Export an HTML slide presentation to a pixel-perfect PDF
allowed-tools: Read, Bash, Glob
---

# /export-pdf

Export an AgentAI HTML slide presentation to a pixel-perfect PDF.

## Usage

```
/export-pdf path/to/presentation.html
/export-pdf path/to/presentation.html output.pdf
/export-pdf path/to/presentation.html --scale=1 --quality=85
```

## How It Works

This uses a **screenshot-per-slide** approach — not print CSS. Each slide is isolated (all others hidden), positioned as `position: fixed` filling the viewport, then screenshotted at the exact viewport dimensions. Screenshots are assembled into a PDF via pdf-lib.

This completely avoids the classic problems with HTML-to-PDF:
- No `100vh` collapse (viewport is real, not print mode)
- No print CSS needed (renders in `screen` media)
- No resolution or viewport changes between slides
- What you see in the browser is exactly what's in the PDF

## Steps

1. **Parse arguments** from `$ARGUMENTS`:
   - First positional arg = input HTML file (required)
   - Second positional arg = output PDF path (optional, defaults to same name as input with `.pdf`)
   - Flags: `--width`, `--height`, `--scale`, `--quality`, `--selector`, `--pause`

2. **Check dependencies** — puppeteer and pdf-lib must be available:

```bash
# Check if puppeteer is available, install to /tmp if not
cd /tmp && (node -e "require('puppeteer')" 2>/dev/null || npm install puppeteer pdf-lib 2>&1 | tail -3)
```

3. **Run the export script:**

```bash
# Find the export-pdf.mjs script relative to this plugin
SCRIPT_DIR="$(dirname "$(find "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" -path "*/plugins/slides/scripts/export-pdf.mjs" 2>/dev/null | head -1)")"
node "$SCRIPT_DIR/export-pdf.mjs" <input> [output] [flags]
```

4. **Open the PDF** for visual verification:

```bash
open "<output.pdf>"
```

5. **Report** the file path, size, and page count.

## Default Settings

| Option | Default | Description |
|--------|---------|-------------|
| `--width` | 1920 | Viewport width in pixels |
| `--height` | 1080 | Viewport height in pixels |
| `--scale` | 2 | Device scale factor (2 = retina quality) |
| `--quality` | 95 | JPEG compression quality (1-100) |
| `--selector` | `section.slide` | CSS selector to find slides |
| `--pause` | 500 | Ms to wait per slide for rendering |

## Size Guide

| Scale | Quality | ~Size per slide | Best for |
|-------|---------|-----------------|----------|
| 1x | 85 | ~100 KB | Email attachments, quick sharing |
| 2x | 95 | ~450 KB | Default — sharp text, reasonable size |
| 2x | 100 | ~800 KB | Maximum quality, large file |

## Examples

```bash
# Default retina export (recommended)
/export-pdf agentai-worklist-2026-02-18.html

# Lightweight for email
/export-pdf deck.html deck-light.pdf --scale=1 --quality=85

# Maximum quality
/export-pdf deck.html deck-hq.pdf --scale=2 --quality=100
```
