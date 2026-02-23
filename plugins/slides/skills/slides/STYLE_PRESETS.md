# AgentAI Style Presets

8 curated visual styles built on the AgentAI brand system. Each preset is production-ready and designed for specific contexts. **Abstract shapes only — no illustrations.**

---

## 1. Executive Green (Default)

**Vibe:** Professional, clean, confident, trustworthy
**Best for:** Board meetings, investor updates, partner presentations

**Layout:** White background, green accents, clean typography. Logo top-left, page number bottom-right.

**Typography:**
- Display: `Plus Jakarta Sans` (700/800) or `Montserrat` (700/800)
- Body: `Nunito` (400/500) or `Montserrat` (300/500)

> **Montserrat alternative:** Battle-tested in the worklist deck (Feb 2026). Montserrat 800 for headings + 300-500 for body produces a confident, geometric feel that pairs well with green gradients. Use when the deck needs a bolder, more assertive voice.

**Colors:**
```css
:root {
  --bg-primary: #FAFAF9;
  --bg-card: #FFFFFF;
  --bg-accent: #ECFDF5;
  --text-primary: #1C1917;
  --text-secondary: #57534E;
  --accent-1: #25A55F;
  --accent-2: #1A1A8C;
  --border: #E7E5E4;
}
```

**Title Slide:**
```css
.slide--title {
  background: linear-gradient(135deg, #114A37 0%, #25A55F 50%, #1C8750 100%);
  color: #FFFFFF;
}
```

**Signature Elements:**
- Subtle green left border on cards (`border-left: 4px solid var(--accent-1)`)
- Warm stone background (`#FAFAF9`) instead of pure white
- Metric cards with green icon circles
- Clean horizontal rules between sections

---

## 2. Midnight Authority

**Vibe:** Sophisticated, data-rich, executive, premium
**Best for:** Technical deep dives, strategy reviews, C-suite presentations

**Layout:** Dark background with light text. Cards float on dark surface. Green glowing accents.

**Typography:**
- Display: `Syne` (700/800)
- Body: `Nunito` (300/400)

**Colors:**
```css
:root {
  --bg-primary: #0C0A09;
  --bg-card: rgba(255, 255, 255, 0.05);
  --bg-card-hover: rgba(255, 255, 255, 0.08);
  --text-primary: #FAFAF9;
  --text-secondary: #A8A29E;
  --accent-1: #25A55F;
  --accent-2: #34D38A;
  --accent-glow: rgba(37, 165, 95, 0.15);
  --border: rgba(255, 255, 255, 0.1);
}
```

**Title Slide:**
```css
.slide--title {
  background: radial-gradient(ellipse at 30% 50%, rgba(37, 165, 95, 0.15) 0%, #0C0A09 70%);
}
```

**Signature Elements:**
- Glassmorphism cards (`backdrop-filter: blur(10px)`)
- Green glow behind key metrics
- Thin green accent lines
- Subtle grid pattern overlay
- Logo in white variant

---

## 3. Bold Signal

**Vibe:** Confident, bold, modern, high-impact
**Best for:** Keynotes, investor pitches, high-stakes meetings

**Layout:** Dark gradient background with bold colored accent cards. Number system for slides.

**Typography:**
- Display: `Archivo Black` (900)
- Body: `Space Grotesk` (400/500)

**Colors:**
```css
:root {
  --bg-primary: #1C1917;
  --bg-gradient: linear-gradient(135deg, #1C1917 0%, #292524 50%, #1C1917 100%);
  --card-bg: #25A55F;
  --card-alt: #D4622A;
  --text-primary: #FAFAF9;
  --text-on-card: #FFFFFF;
  --text-muted: #A8A29E;
}
```

**Title Slide:**
```css
.slide--title {
  background: var(--bg-gradient);
}
.title-heading {
  font-size: clamp(3rem, 8vw, 7rem);
  font-weight: 900;
  line-height: 0.95;
}
```

**Signature Elements:**
- Bold colored card as focal point (green or orange)
- Large section numbers (01, 02, 03) in top-left
- Navigation breadcrumbs with opacity states
- High contrast: dark bg + bright accent cards
- Oversized metric values

---

## 4. Warm Editorial

**Vibe:** Narrative, warm, thoughtful, storytelling
**Best for:** Case studies, thought leadership, client proposals

**Layout:** Cream/warm background, editorial serif headings, generous whitespace.

**Typography:**
- Display: `Fraunces` (700/900) — distinctive serif
- Body: `Work Sans` (400/500)

**Colors:**
```css
:root {
  --bg-primary: #FAF9F7;
  --bg-accent: #FDF3ED;
  --text-primary: #1C1917;
  --text-secondary: #57534E;
  --accent-1: #D4622A;
  --accent-2: #25A55F;
  --accent-warm: #EDA072;
  --border: #E7E5E4;
}
```

**Title Slide:**
```css
.slide--title {
  background: linear-gradient(135deg, #8C3E1B 0%, #D4622A 50%, #EDA072 100%);
  color: #FFFFFF;
}
```

**Signature Elements:**
- Abstract geometric decorations (circle outlines, dots, lines)
- Pull quotes with large opening quotation marks
- Orange accent for callouts and highlights
- Green for positive metrics/success stories
- Generous line-height for readability
- Drop cap on narrative paragraphs

---

## 5. Data Studio

**Vibe:** Dashboard-like, metric-focused, analytical, precise
**Best for:** Quarterly reviews, performance reports, analytics presentations

**Layout:** Light background with structured grid. Dense but organized. Chart-heavy.

**Typography:**
- Display: `Plus Jakarta Sans` (700/800)
- Body: `Plus Jakarta Sans` (400/500)
- Data: `JetBrains Mono` (500)

**Colors:**
```css
:root {
  --bg-primary: #F5F5F4;
  --bg-card: #FFFFFF;
  --text-primary: #1C1917;
  --text-secondary: #57534E;
  --chart-1: #25A55F;
  --chart-2: #1A1A8C;
  --chart-3: #D4622A;
  --chart-4: #4242D0;
  --chart-5: #34D38A;
  --trend-up: #25A55F;
  --trend-down: #EF4444;
  --border: #D6D3D1;
}
```

**Title Slide:**
```css
.slide--title {
  background: #1C1917;
  color: #FAFAF9;
}
.title-heading::after {
  content: '';
  display: block;
  width: 80px;
  height: 4px;
  background: var(--chart-1);
  margin-top: 1rem;
}
```

**Signature Elements:**
- Monospace font for all numbers and data
- KPI cards with trend arrows and delta badges
- CSS-only bar charts, progress bars, donut indicators
- Tight grid spacing, data-dense layouts
- Subtle borders between metric sections
- Color-coded trends (green up, red down)

---

## 6. Fresh Modern

**Vibe:** Light, friendly, approachable, energetic
**Best for:** Team updates, onboarding, internal presentations, training

**Layout:** White background with pastel accent blocks. Rounded corners, playful spacing.

**Typography:**
- Display: `Outfit` (700/800)
- Body: `Outfit` (400/500)

**Colors:**
```css
:root {
  --bg-primary: #FFFFFF;
  --bg-accent-green: #ECFDF5;
  --bg-accent-navy: #EDEDFD;
  --bg-accent-orange: #FDF3ED;
  --text-primary: #1C1917;
  --text-secondary: #57534E;
  --accent-1: #25A55F;
  --accent-2: #4242D0;
  --accent-3: #D4622A;
  --border: #E7E5E4;
}
```

**Title Slide:**
```css
.slide--title {
  background: #ECFDF5;
  color: #1C1917;
}
.title-heading {
  color: #25A55F;
}
```

**Signature Elements:**
- Rounded cards with pastel backgrounds (`border-radius: 16px`)
- Pill badges for tags and categories
- Emoji or simple SVG icons (not Lucide)
- Alternating pastel section backgrounds
- Playful but professional spacing
- Green/navy/orange accent rotation

---

## 7. Gradient Flow

**Vibe:** Elegant, smooth, premium, aspirational
**Best for:** Product launches, marketing decks, partnership proposals

**Layout:** Flowing gradients as section backgrounds. Cards with subtle backdrop blur. Smooth transitions.

**Typography:**
- Display: `Manrope` (700/800)
- Body: `Manrope` (400/500)

**Colors:**
```css
:root {
  --bg-primary: #0C0A09;
  --gradient-primary: linear-gradient(135deg, #114A37, #25A55F, #34D38A);
  --gradient-accent: linear-gradient(135deg, #1A1A8C, #4242D0, #9090F0);
  --gradient-warm: linear-gradient(135deg, #8C3E1B, #D4622A, #EDA072);
  --text-primary: #FAFAF9;
  --text-secondary: #D6D3D1;
  --bg-card: rgba(255, 255, 255, 0.06);
  --border: rgba(255, 255, 255, 0.1);
}
```

**Title Slide:**
```css
.slide--title {
  background: linear-gradient(135deg, #062117 0%, #114A37 30%, #25A55F 60%, #34D38A 100%);
}
```

**Signature Elements:**
- Multi-stop gradients that shift per section (green -> navy -> orange)
- Frosted glass cards (`backdrop-filter: blur(20px)`)
- Soft abstract gradient orbs as decorations
- Smooth scroll transitions between slides
- White text on all slides (dark mode throughout)
- Gradient text for key headings: `-webkit-background-clip: text`

---

## 8. Neon Confidence

**Vibe:** Futuristic, bold, tech-forward, energetic
**Best for:** Tech demos, innovation pitches, product showcases, hackathon presentations

**Layout:** Deep dark background with neon green accents. Grid patterns, tech aesthetic.

**Typography:**
- Display: `Syne` (700/800)
- Mono: `JetBrains Mono` (400/700)

**Colors:**
```css
:root {
  --bg-primary: #050505;
  --bg-grid: rgba(37, 165, 95, 0.03);
  --text-primary: #FAFAF9;
  --text-secondary: #78716C;
  --neon-green: #34D38A;
  --neon-glow: rgba(52, 211, 138, 0.3);
  --accent-orange: #D4622A;
  --border: rgba(52, 211, 138, 0.2);
}
```

**Title Slide:**
```css
.slide--title {
  background: #050505;
  background-image:
    radial-gradient(circle at 20% 50%, rgba(52, 211, 138, 0.08) 0%, transparent 50%),
    radial-gradient(circle at 80% 50%, rgba(212, 98, 42, 0.06) 0%, transparent 50%);
}
.title-heading {
  text-shadow: 0 0 40px rgba(52, 211, 138, 0.3);
}
```

**Signature Elements:**
- CSS grid pattern background (`background-image: linear-gradient(...)`)
- Neon glow on key elements (`box-shadow: 0 0 20px var(--neon-glow)`)
- Terminal-style code blocks for technical content
- Scan line animation overlay (subtle)
- Monospace for all data and labels
- Green/orange dual-accent system

---

## Font Pairing Quick Reference

| Preset | Display Font | Body Font | Source |
|--------|-------------|-----------|--------|
| Executive Green | Plus Jakarta Sans 800 (or Montserrat 800) | Nunito 400 (or Montserrat 400) | Google |
| Midnight Authority | Syne 800 | Nunito 300 | Google |
| Bold Signal | Archivo Black 900 | Space Grotesk 400 | Google |
| Warm Editorial | Fraunces 900 | Work Sans 400 | Google |
| Data Studio | Plus Jakarta Sans 700 | Plus Jakarta Sans 400 | Google |
| Fresh Modern | Outfit 800 | Outfit 400 | Google |
| Gradient Flow | Manrope 800 | Manrope 400 | Google |
| Neon Confidence | Syne 800 | JetBrains Mono 400 | Google/JetBrains |

---

## DO NOT USE (Generic AI Patterns)

**Fonts:** Inter as display, Roboto, Arial, system fonts for headings

**Colors:** Generic indigo (#6366f1), purple gradients, colors not in AgentAI palette

**Layouts:** Everything centered identically, generic hero sections, identical card grids with no hierarchy

**Decorations:** Realistic illustrations, gratuitous glassmorphism without purpose, generic stock-photo backgrounds

---

## Audience-Based Preset Selection Guide

| Audience | Primary Pick | Alternative |
|----------|-------------|-------------|
| **Investors** | Executive Green | Bold Signal |
| **Board of Directors** | Executive Green | Data Studio |
| **Prospects / Clients** | Warm Editorial | Gradient Flow |
| **Technical Team** | Midnight Authority | Neon Confidence |
| **Internal / All-hands** | Fresh Modern | Executive Green |
| **Product Launch** | Gradient Flow | Bold Signal |
| **Quarterly Review** | Data Studio | Executive Green |
| **Case Study** | Warm Editorial | Fresh Modern |
| **Hackathon / Demo** | Neon Confidence | Bold Signal |
