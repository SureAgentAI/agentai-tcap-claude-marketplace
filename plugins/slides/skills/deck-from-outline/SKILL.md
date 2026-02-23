---
name: deck-from-outline
description: Generate a complete branded HTML presentation from a bullet-point outline. Paste your outline, get a polished deck.
---

# Deck from Outline

Generate a complete AgentAI-branded HTML presentation from a structured outline. No design skills needed — just provide bullet points and get a polished deck.

## Usage

The user provides a bullet-point outline. You generate a complete single-file HTML presentation.

## Workflow

### Step 1: Parse the Outline

Extract structure from the user's outline:

| Outline Pattern | Slide Type |
|-----------------|------------|
| `# Main Title` | Title slide |
| `## Section Name` | Content slide heading |
| `- Bullet point` | Body content |
| `Revenue: $X (+Y%)` | Metric card |
| `Step 1, Step 2...` | Process/timeline slide |
| `Before: X / After: Y` | Comparison slide |
| `"Quote text" — Author` | Quote/testimonial slide |
| `Thank you / Questions?` | Closing slide |

### Step 2: Pick a Style

Based on the audience (ask if unclear):

| Audience | Default Preset |
|----------|---------------|
| Investors | Executive Green |
| Board | Executive Green |
| Clients | Warm Editorial |
| Team | Fresh Modern |
| Technical | Midnight Authority |

If the user doesn't specify, use **Executive Green** — it works for everything.

### Step 3: Generate Slides

Map each section to the right slide pattern. Rules:

1. **Title slide** is always first — full gradient, logo, tagline
2. **Closing slide** is always last — contacts, branding, URL
3. **Metrics go in cards** — detect numbers with units ($, %, K, M) and create metric cards
4. **Max 4-6 bullets per slide** — split if the section has more
5. **One message per slide** — if a section covers two topics, make two slides
6. **Add an agenda slide** after the title if there are 5+ content sections

### Step 4: Assemble the HTML

Use the `slides` skill for the HTML structure, CSS, and JavaScript. Apply the chosen style preset.

### Step 5: Deliver

1. Save as `agentai-[topic]-[YYYY-MM-DD].html`
2. Open in browser for user to verify
3. Suggest refinements

## Content Mapping Reference

### Numbers -> Metric Cards

When the outline contains metrics:
```
- Revenue: $8.2M (+18% QoQ)
- Gross margin: 72%
- Clinics: 145
- Claims/month: 52K
```

Generate a 4-column metric card grid:
```html
<div class="grid grid-4 metrics-grid" data-animate-stagger>
  <div class="metric-card">
    <div class="metric-icon">$</div>
    <div class="metric-value">$8.2M</div>
    <div class="metric-label">Revenue</div>
    <div class="metric-trend trend-up">+18% QoQ</div>
  </div>
  <!-- ... more cards -->
</div>
```

### Process Steps -> Timeline

When the outline has sequential steps:
```
- Step 1: Claim intake
- Step 2: AI validation
- Step 3: Payer submission
- Step 4: Payment posting
```

Generate a horizontal timeline or vertical step list.

### Comparisons -> Split Layout

When the outline has before/after or vs. content:
```
Before: Manual, 72h turnaround, 15% denials
After: Automated, 4h turnaround, 3% denials
```

Generate a two-column comparison card layout.

### Bullet Lists -> Feature Cards

When the outline has feature descriptions:
```
- AI-powered coding and validation
- Automated claim scrubbing
- Real-time eligibility checks
```

Generate feature cards with icons in a grid.

## Example

**Input:**
```markdown
# Q2 2026 Board Meeting

## Agenda
- Financial review
- Operations update
- Technology roadmap
- Strategic initiatives

## Financial Highlights
- Revenue: $8.2M (+18% QoQ)
- Gross margin: 72%
- Cash: $4.1M
- Monthly burn: $320K

## Operations
- Team size: 85 employees (+12)
- Clinics: 145 active
- Claims: 52K/month processed
- SLA compliance: 99.2%

## Technology
- V2 platform 80% complete
- 3 new AI models in production
- Mobile app beta with 200 users

## Strategy
- Close 2 acquisitions by Q3
- Expand to 5 new states
- Launch enterprise pricing tier

## Thank You
- Zorik Gordon, CEO, zorik@agentai.app
```

**Output:** A complete HTML file with:
1. Title slide (gradient, "Q2 2026 Board Meeting", logo, tagline)
2. Agenda slide (4 items with icons)
3. Financial Highlights (4 metric cards with trends)
4. Operations (4 metric cards)
5. Technology (3 feature cards in a grid)
6. Strategy (3 strategy cards on gradient section)
7. Closing slide (contacts, branding)

## Tips for Users

- **Include specific numbers** — metrics with units automatically become visual cards
- **Use `##` for sections** — each `##` becomes a slide
- **Keep bullets short** — 5-10 words per bullet is ideal
- **Mark the audience** — "For: investors" helps pick the right style
- **Specify contacts** — include names/emails for the closing slide
