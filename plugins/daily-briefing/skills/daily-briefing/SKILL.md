---
name: daily-briefing
description: Morning briefing with calendar, email, Google Chat, action items, and draft responses
---

# Daily Briefing

Produce a structured morning briefing by pulling data from Google Calendar, Gmail, and Google Chat via the `workspace-mcp` plugin. Optionally draft email responses in the user's communication style.

**Author:** Michael Gorodetsky

## Inputs

- **time_range**: one of `today` (default), `tomorrow`, or `week`

## Prerequisites

- A Google Workspace MCP server must be installed and configured (see the setup guide in `plugins/daily-briefing/skills/daily-briefing-setup/`)
- Required Google APIs enabled: Gmail API, Google Calendar API, Google Chat API
- Required OAuth scopes:
  - `https://www.googleapis.com/auth/gmail.readonly`
  - `https://www.googleapis.com/auth/gmail.compose`
  - `https://www.googleapis.com/auth/calendar.readonly`
  - `https://www.googleapis.com/auth/chat.spaces.readonly`
  - `https://www.googleapis.com/auth/chat.messages.readonly`

## Procedure

### Step 1: Resolve Date Range

Determine the concrete date range based on the input:

- `today` — from midnight to 11:59 PM today
- `tomorrow` — from midnight to 11:59 PM tomorrow
- `week` — from Monday 00:00 to Friday 23:59 of the current work week

Use the user's local timezone. If unknown, ask once and remember for the session.

### Step 2: Check Calendar

Use the Google Calendar MCP to fetch events for the date range.

For each event, capture:
- **Time** (start - end, in local time)
- **Title**
- **Attendees** (list names; highlight external participants)
- **Location or video link** (Zoom, Meet, etc.)
- **Description snippet** (first 2-3 lines, if present — useful for prep context)

After collecting events:
- **Flag scheduling conflicts** — overlapping events get a warning marker
- **Flag back-to-back meetings** — events with less than 5 minutes gap
- **Note focus blocks** — gaps of 60+ minutes with no meetings

If the MCP server is unavailable, print a clear message:
> Calendar data unavailable. Make sure the `workspace-mcp` plugin is installed and your Google Workspace credentials are configured. See the workspace-setup skill for help.

Then continue with the remaining steps.

### Step 3: Scan Email

Use the Gmail MCP to scan the inbox.

Query strategy:
- Fetch unread emails from the last 24 hours (or since last briefing)
- For `week` range, extend to unread emails from the past 7 days

Prioritize and surface:
1. **Starred or flagged** messages — always include
2. **Emails from meeting attendees** — cross-reference with today's calendar to surface context
3. **Emails needing a reply** — look for direct questions, requests, or action items addressed to the user
4. **Thread summaries** — for threads with 3+ messages, summarize the thread instead of listing each email

For each surfaced email, show:
- **From** (name, not raw email)
- **Subject**
- **One-line summary** of what it says or asks
- **Suggested action** (reply, review, FYI)

Limit output to the top 10 most relevant emails. If there are more, note the count: "...and 14 more unread emails."

If the MCP server is unavailable, print a clear message and continue.

### Step 4: Scan Google Chat

Use the Google Chat MCP to check recent messages across spaces and DMs.

Query strategy:
- Fetch messages from the last 24 hours (or since last briefing)
- For `week` range, extend to the past 7 days

Prioritize and surface:
1. **Direct messages** — always include
2. **@mentions** in spaces — messages where the user was tagged
3. **Active threads** the user participated in — new replies since last seen
4. **Space highlights** — high-activity threads in spaces the user belongs to

For each surfaced message, show:
- **Space/DM** name
- **From** (name)
- **One-line summary**
- **Suggested action** (reply, acknowledge, FYI)

Limit to top 5 most relevant. If there are more, note the count.

If Google Chat API is not enabled or the MCP server doesn't support it, skip this section silently (do not show an empty heading or error — Chat is optional).

### Step 5: Compile Action Items

Review everything gathered in Steps 2-4 and extract actionable items.

Categorize by priority:

1. **Urgent** — time-sensitive items due today (meeting prep, deadlines, reply-needed emails/chats)
2. **Important** — items that matter but are not due today (follow-ups, reviews, decisions)
3. **FYI** — low-priority items to be aware of (informational emails, optional meetings)

Each action item must be:
- **Specific** — "Reply to Sarah's email about Q1 budget" not "Check email"
- **Linked to source** — reference which calendar event, email, or chat message it came from
- **Estimated effort** — quick (< 5 min), medium (15-30 min), or deep (1+ hour)

### Step 6: Draft Responses (Optional)

For emails and chat messages categorized as "reply" in the suggested actions, offer to draft responses.

**Style profile:** If a file exists at `~/.google-workspace-mcp/style_profile.md`, read it and match the user's communication patterns when drafting. The style profile contains:
- Greeting patterns (e.g., "Hi [FirstName],")
- Common phrases and tone
- Things to avoid
- Signature format

If no style profile exists, use a professional but approachable tone and ask the user if they'd like to create one for future briefings.

**Drafting rules:**
- Draft responses as Gmail drafts (using `gmail.compose` scope), do NOT send directly
- Present each draft for user review before saving
- Keep drafts concise — match the length and tone of the original message

## Output Format

Present the briefing in this structure:

```
## Morning Briefing — [Day, Month Date, Year]

### Calendar
[time] **Meeting title** — attendees (location/link)
  - Prep: [any relevant context from email or description]

[Conflicts and scheduling notes if any]
[Focus blocks if any]

### Email Highlights
- **[From]**: [Subject] — [one-line summary] → [suggested action]
- ...
[+ N more unread if applicable]

### Chat Highlights
- **[Space/DM]** — [From]: [summary] → [suggested action]
- ...
[This section omitted if Chat is not configured]

### Action Items
**Urgent**
1. [action] — [source] — [effort estimate]

**Important**
2. [action] — [source] — [effort estimate]

**FYI**
3. [item] — [source]

### Draft Responses
[Offered for any items with "reply" action — user confirms before saving]
```

## Error Handling

- If Calendar, Email, and Chat MCPs are all unavailable, do not produce an empty briefing. Instead, explain the setup requirements and link to the `workspace-mcp` plugin documentation.
- If one source fails, produce a partial briefing with a note about the missing section.
- Never fabricate events, emails, or chat messages. If data is unavailable, say so.
