---
name: daily-briefing
description: Aggregate calendar, email, and news into an actionable daily summary
---

# Daily Briefing

Produce a structured morning briefing by pulling data from calendar, email, and optional news sources. This skill depends on the `workspace-mcp` plugin for Google Calendar and Gmail MCP servers.

## Inputs

- **time_range**: one of `today` (default), `tomorrow`, or `week`

## Procedure

### Step 1: Resolve Date Range

Determine the concrete date range based on the input:

- `today` — from midnight to 11:59 PM today
- `tomorrow` — from midnight to 11:59 PM tomorrow
- `week` — from Monday 00:00 to Friday 23:59 of the current work week

Use the user's local timezone. If unknown, ask once and remember for the session.

### Step 2: Check Calendar

Use the Google Calendar MCP (provided by `workspace-mcp`) to fetch events for the date range.

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
> Calendar data unavailable. Make sure the `workspace-mcp` plugin is installed and your Google Workspace credentials are configured.

Then continue with the remaining steps.

### Step 3: Scan Email

Use the Gmail MCP (provided by `workspace-mcp`) to scan the inbox.

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

### Step 4: News and Updates (Optional)

This section is optional and should only appear if relevant context is available.

Potential sources (depending on user's setup):
- **Portfolio company news** — for VC/investment teams, search for mentions of portfolio companies
- **Industry news** — if the user has specified topics of interest
- **Team updates** — Slack digest, PR activity, or other integrations

Keep this section brief: **3-5 bullet points maximum**. Each bullet should be one sentence with a source link if available.

If no news sources are configured, skip this section entirely (do not show an empty heading).

### Step 5: Compile Action Items

Review everything gathered in Steps 2-4 and extract actionable items.

Categorize by priority:

1. **Urgent** — time-sensitive items due today (meeting prep, deadlines, reply-needed emails)
2. **Important** — items that matter but are not due today (follow-ups, reviews, decisions)
3. **Follow-up** — low-priority items to track (FYI emails, optional meetings, reading)

Each action item must be:
- **Specific** — "Reply to Sarah's email about Q1 budget" not "Check email"
- **Linked to source** — reference which calendar event or email it came from
- **Estimated effort** — quick (< 5 min), medium (15-30 min), or deep (1+ hour)

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

### News & Updates
- [bullet point summaries, 3-5 max]
[This section omitted if no sources configured]

### Action Items
**Urgent**
1. [action] — [source] — [effort estimate]

**Important**
2. [action] — [source] — [effort estimate]

**Follow-up**
3. [action] — [source] — [effort estimate]
```

## Error Handling

- If both Calendar and Email MCPs are unavailable, do not produce an empty briefing. Instead, explain the setup requirements and link to the `workspace-mcp` plugin documentation.
- If one source fails, produce a partial briefing with a note about the missing section.
- Never fabricate events, emails, or news. If data is unavailable, say so.

## Notes

- This is v1.0 — Michael Gorodetsky will refine the workflow with additional data sources and customization options.
- Future enhancements planned: Slack integration, CRM pipeline summary, custom briefing templates, recurring schedule (auto-trigger at 8 AM).
