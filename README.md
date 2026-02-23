# AgentAI Marketplace

**Turnkey Claude Code plugins for teams — install once, use everywhere.**

A curated plugin marketplace for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Each plugin adds specialized capabilities to your Claude terminal — portfolio intelligence, presentation creation, daily briefings, and more. Designed for investment teams but useful for any professional workflow.

---

## Quick Install

### Method 1 — Ask Claude

Open Claude Code and type:

> Install the AgentAI marketplace from https://github.com/SureAgentAI/agentai-marketplace

Claude will handle the rest.

### Method 2 — CLI Commands

```
/plugin marketplace add SureAgentAI/agentai-marketplace
/plugin install slides@agentai
```

### Method 3 — Manual Configuration

Add the following to your `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "agentai": {
      "source": {
        "source": "github",
        "repo": "SureAgentAI/agentai-marketplace"
      }
    }
  },
  "enabledPlugins": {
    "hotlist@agentai": true,
    "slides@agentai": true,
    "planner@agentai": true,
    "daily-briefing@agentai": true,
    "workspace-mcp@agentai": true
  }
}
```

You can enable all five plugins or just the ones you need.

---

## Plugin Catalog

| Plugin | What You Get | Commands |
|--------|-------------|----------|
| **hotlist** | Portfolio company intelligence dashboard — enrichment, ranking, CSV export | `/hotlist`, `/hotlist enrich`, `/hotlist export` |
| **slides** | Branded HTML presentations from scratch, outline, or PowerPoint | `/new-presentation`, `/slide-check`, `/convert-pptx`, `/export-pdf` |
| **planner** | Structured planning — brainstorm ideas, evaluate approaches, produce plans | `/plan [topic]` |
| **daily-briefing** | Morning summary — calendar, email highlights, action items | `/briefing [today/tomorrow/week]` |
| **workspace-mcp** | Google & Outlook integration — auto-loads Gmail, Calendar, Drive MCP servers | *(auto-loads on enable)* |

---

## Plugin Setup

Most plugins work immediately after install. A few require one-time setup.

<details>
<summary><strong>hotlist</strong> — Portfolio Intelligence Dashboard</summary>

### Requirements

- Access to **hotlist.agentai.biz** (protected by Cloudflare Access)
- Your email address must be whitelisted — contact your admin if you see an access denied page

### How It Works

The hotlist plugin connects to the hosted dashboard at `hotlist.agentai.biz` to pull portfolio company data. When you run `/hotlist enrich`, Claude augments company records with public data sources. Use `/hotlist export` to generate CSV files for further analysis.

### Quick Start

```
/hotlist              # View the current portfolio hot list
/hotlist enrich       # Enrich companies with latest data
/hotlist export       # Export to CSV
```

</details>

<details>
<summary><strong>slides</strong> — Presentation Builder</summary>

### Requirements

None. Works immediately.

### How It Works

Creates branded HTML presentations that render in any browser. You can start from scratch, provide an outline, or convert an existing PowerPoint file.

### Quick Start

```
/new-presentation     # Create a presentation from scratch or outline
/convert-pptx         # Convert a PowerPoint file to branded HTML
/slide-check          # Review and refine an existing presentation
/export-pdf           # Export the presentation to PDF
```

</details>

<details>
<summary><strong>planner</strong> — Structured Planning</summary>

### Requirements

None. Works immediately.

### How It Works

Guides you through a structured planning workflow: brainstorm options, evaluate tradeoffs, then produce an actionable plan with clear next steps.

### Quick Start

```
/plan quarterly portfolio review
/plan due diligence checklist for Series B
/plan team offsite agenda
```

</details>

<details>
<summary><strong>daily-briefing</strong> — Morning Briefing</summary>

### Requirements

- **workspace-mcp** plugin must be installed and configured first (see below)

### How It Works

Aggregates your calendar, email, and priorities into a concise daily summary. Highlights meetings, action items, and anything that needs attention.

### Quick Start

```
/briefing             # Today's briefing
/briefing tomorrow    # Preview tomorrow
/briefing week        # Weekly overview
```

</details>

<details>
<summary><strong>workspace-mcp</strong> — Google & Outlook Integration</summary>

### Requirements

- Google Cloud project with OAuth credentials (for Gmail, Calendar, Drive access)
- Follow the workspace-setup skill guide included with the plugin

### How It Works

When enabled, this plugin auto-loads MCP servers for Gmail, Google Calendar, and Google Drive. Other plugins like **daily-briefing** depend on it for email and calendar access.

### Quick Start

After enabling the plugin, Claude will walk you through credential setup on first use. Once configured, Gmail, Calendar, and Drive are available in every Claude Code session automatically.

</details>

---

## Security

- **Cloudflare Access** protects deployed apps (e.g., `hotlist.agentai.biz`) with email-based one-time passwords
- **Whitelisted domains only** — access is restricted to authorized email domains (`@transformcap.com`, `@agentai.app`)
- **No secrets in this repo** — all API keys and credentials are provided by you through environment variables or local configuration
- **Plugin permissions** are controlled through your own `settings.json` — you choose which plugins to enable

---

## Staying Updated

Update the marketplace and all installed plugins:

```
/plugin marketplace update agentai
/plugin update slides@agentai
```

Or simply ask Claude:

> Update my AgentAI plugins

---

## Installing Individual Plugins

You do not need to install everything. Pick what you need:

```
/plugin install planner@agentai
```

To see what is available:

```
/plugin list agentai
```

Or ask Claude:

> What plugins are available from AgentAI?

---

## Support

For access issues, plugin questions, or feature requests, contact your AgentAI administrator or open an issue in this repository.
