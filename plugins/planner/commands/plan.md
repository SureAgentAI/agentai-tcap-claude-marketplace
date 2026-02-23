---
name: plan
description: Start a structured planning session — brainstorm, evaluate approaches, produce an actionable plan
argument-hint: [topic]
---

# /plan

Start a structured planning session.

## Behavior

1. If the user provided a topic (e.g. `/plan Q1 fundraising strategy`), use it as the starting point.
2. If no topic was provided, ask: **"What would you like to plan?"**
3. Once you have a topic, invoke the `planning` skill to guide the full session.

## Output

The session produces a structured plan document saved to `docs/plans/` as a markdown file. The filename should be a kebab-case slug of the topic with today's date, e.g. `docs/plans/2026-02-22-q1-fundraising-strategy.md`.

## Examples

```
/plan Q1 fundraising strategy
/plan annual team offsite
/plan product launch timeline
/plan hiring plan for engineering
/plan
```
