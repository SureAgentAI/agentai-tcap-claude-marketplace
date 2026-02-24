---
name: briefing
description: Get your morning briefing — calendar, email, Google Chat, and action items
argument-hint: [today|tomorrow|week]
---

# /briefing

Get a consolidated morning briefing with calendar events, email highlights, Google Chat messages, and action items. Optionally draft responses in your communication style.

## Behavior

1. Parse the time range from the argument:
   - No argument or `today` — briefing for today
   - `tomorrow` — briefing for tomorrow
   - `week` — briefing for the current work week (Monday through Friday)
2. Invoke the `daily-briefing` skill with the resolved time range.
3. Present the formatted summary directly in the conversation.
4. Offer to draft responses for any emails or chat messages that need a reply.

## Prerequisites

The `workspace-mcp` plugin must be installed and configured with valid Google Workspace credentials. Required APIs: Gmail, Google Calendar, and optionally Google Chat. If the MCP servers are not available, the command will tell you which setup steps are needed.

## Examples

```
/briefing
/briefing today
/briefing tomorrow
/briefing week
```
