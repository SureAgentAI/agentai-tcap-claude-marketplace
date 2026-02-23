---
description: Audit an HTML presentation for quality, brand compliance, and viewport fitting
allowed-tools: Read, Grep, Glob, Bash
---

# /slide-check

Audit an AgentAI HTML presentation for quality, brand compliance, and viewport fitting.

## Usage

```
/slide-check path/to/presentation.html
```

## Audit Categories

### 1. Brand Compliance

- [ ] AgentAI logo present on content slides
- [ ] Title slide has full branding (logo + tagline)
- [ ] Closing slide has contacts and branding
- [ ] Colors match AgentAI palette (check for non-brand hex values)
- [ ] Fonts loaded from Google Fonts (not system defaults)
- [ ] No competing brand colors or logos

### 2. Viewport Fitting

- [ ] Every `.slide` has `height: 100vh` and `overflow: hidden`
- [ ] `.slide-content` has `min-height: 0` (flexbox overflow fix)
- [ ] All font sizes use `clamp()` (no fixed px/rem for text)
- [ ] Height breakpoints exist (800px, 650px)
- [ ] Content density within limits (max 6 bullets, 4 metrics per slide)
- [ ] No horizontal overflow
- [ ] Images have `max-height` constraints

### 3. Navigation

- [ ] Keyboard navigation works (arrows, space, home, end)
- [ ] Touch/swipe support present
- [ ] Progress bar updates correctly
- [ ] Page numbers visible on content slides
- [ ] Nav dots functional (if included)

### 4. Accessibility

- [ ] All text meets minimum size (16px equivalent)
- [ ] Color contrast ratios adequate (4.5:1 for body text)
- [ ] `prefers-reduced-motion` media query present
- [ ] Print stylesheet included
- [ ] `lang` attribute on `<html>`
- [ ] Meaningful heading hierarchy (h1 -> h2 -> h3)

### 5. Content Quality

- [ ] No empty slides
- [ ] No duplicate slides
- [ ] Logical flow (title -> content -> closing)
- [ ] Consistent heading capitalization
- [ ] No orphaned bullet points (1-2 items alone)
- [ ] Metrics have proper formatting (commas, units)

### 6. Advanced Patterns

- [ ] Screenshot slides use browser chrome frame (`.screenshot-frame` with 3 dots)
- [ ] ASCII diagrams use `.ascii-box` with proper `.hl` / `.hl2` / `.hl3` classes
- [ ] Dark slides have complete text override chain (h2, p, li, .slide-subtitle, .page-number)
- [ ] Print styles use 1920x1080 page size (`@page { size: 1920px 1080px; }`)
- [ ] Card variants use correct classes (`.card--accent`, `.card--orange`, `.card--navy`, `.card--dark`)
- [ ] Stagger animations use 80ms delays (not 100ms)
- [ ] JS animation observer targets both `[data-animate]` and `[data-animate-stagger]`

## Output Format

```
SLIDE CHECK: [filename]
Date: [timestamp]

════════════════════════════════════════

SUMMARY
  Slides: 12
  Issues: 4 (1 error, 3 warnings)
  Brand score: 92/100
  Viewport: PASS

════════════════════════════════════════

ERRORS (must fix)

[ERROR] Slide 5
  └─ Content exceeds viewport: 8 bullet points
  └─ Fix: Split into two slides

════════════════════════════════════════

WARNINGS (should fix)

[WARN] Slide 3
  └─ Non-brand color found: #374151
  └─ Suggestion: Use var(--text-secondary) instead

[WARN] Slide 8
  └─ Missing alt text on image
  └─ Fix: Add descriptive alt attribute

[WARN] Global
  └─ Missing @media (max-height: 500px) breakpoint
  └─ Fix: Add extreme short-screen breakpoint

════════════════════════════════════════

PASSES

✓ Brand compliance: Logo, colors, fonts correct
✓ Navigation: Keyboard + touch working
✓ Accessibility: Reduced motion, print styles
✓ Content flow: Logical structure

════════════════════════════════════════

RECOMMENDATIONS

1. Add viewport height breakpoint for 500px
2. Replace hardcoded gray with CSS variable
3. Split slide 5 into "Financial Metrics" and "Operational Metrics"
```
