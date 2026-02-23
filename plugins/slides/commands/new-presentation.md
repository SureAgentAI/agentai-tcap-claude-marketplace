---
description: Start creating a new AgentAI-branded HTML presentation with guided workflow
allowed-tools: Bash, Read, Write, Glob, Grep, WebFetch
---

# /new-presentation

Create a new AgentAI-branded HTML presentation. This command guides you through the full process.

## Workflow

### 1. Gather Context

Ask the user (max 3 questions):

1. **What's this presentation about?** — Topic, key message, occasion
2. **Who's the audience?** — Investors, board, team, clients, prospects
3. **Do you have an outline or content?** — Bullets, notes, or "help me structure it"

### 2. Generate Style Previews

Create 3 mini HTML preview files (3 slides each) using different style presets from the `slides` skill. Pick presets based on the audience:

| Audience | Preview Presets |
|----------|----------------|
| Investors | Executive Green, Bold Signal, Gradient Flow |
| Board | Executive Green, Data Studio, Midnight Authority |
| Clients | Warm Editorial, Executive Green, Gradient Flow |
| Team | Fresh Modern, Executive Green, Data Studio |
| Technical | Midnight Authority, Neon Confidence, Data Studio |

Save previews in the current directory:
- `preview-1-[style].html`
- `preview-2-[style].html`
- `preview-3-[style].html`

Tell the user to open them in their browser and pick a direction.

### 3. Build the Full Deck

Once the user picks a style:

1. Use the `slides` skill to generate the complete presentation
2. Apply the chosen style preset
3. Populate with the user's content
4. Save as `agentai-[topic]-[YYYY-MM-DD].html`

### 4. Deliver

- Open the file in the browser if possible
- Provide the file path
- Offer to iterate on specific slides

## Quick Mode

If the user provides both topic and outline upfront, skip the discovery phase and go straight to style previews.

Example:
```
/new-presentation
Topic: Q2 2026 investor update
Audience: investors
Outline:
- Revenue growth
- Market expansion
- Product updates
- Team scaling
- Financial ask
```
