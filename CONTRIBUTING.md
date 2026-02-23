# Contributing to AgentAI Marketplace

> **This guide is for plugin authors** adding new commands, skills, or agents to the public marketplace.

---

## Need Help Making Changes?

Not comfortable with git or JSON? You can still contribute:

1. **Write your command/skill as plain text** - describe what it should do
2. **Ask Claude for help** - open a Claude Code session in this repo and say: "Help me turn this into a plugin command"
3. **Share with a technical teammate** - they can handle the git/version parts

The most valuable part is the content itself. Claude can scaffold the plugin structure, write the JSON, and bump versions for you.

---

## Adding New Content

### New Command

1. Create `plugins/<plugin>/commands/<name>.md`
2. Add YAML frontmatter:
   ```yaml
   ---
   description: What this command does
   ---
   ```
3. Write the command content
4. **Bump the plugin version** (see below)
5. Commit and push

### New Skill

1. Create `plugins/<plugin>/skills/<name>/SKILL.md`
2. Add YAML frontmatter:
   ```yaml
   ---
   name: skill-name
   description: What this skill does
   ---
   ```
3. Write the skill content
4. **Bump the plugin version**
5. Commit and push

### New Agent

1. Create `plugins/<plugin>/agents/<name>.md`
2. Define the agent's role and capabilities
3. **Bump the plugin version**
4. Commit and push

---

## Version Bumping (Required)

**Every change requires a version bump** or users won't receive updates.

### Where to Bump

Update version in TWO files:

1. `plugins/<plugin>/.claude-plugin/plugin.json`
2. `.claude-plugin/marketplace.json` (find the matching plugin entry)

### How to Version

| Change | Bump | Example |
|--------|------|---------|
| Typo fix, small edit | Patch | `1.0.1` -> `1.0.2` |
| New command/skill | Minor | `1.0.2` -> `1.1.0` |
| Breaking change | Major | `1.1.0` -> `2.0.0` |

**When in doubt, bump patch.**

---

## Commit and Push

```bash
git add -A
git commit -m "Add /new-command to daily-briefing plugin"
git push
```

---

## Pre-commit Validation (Recommended)

Enable automatic validation before each commit:

```bash
git config core.hooksPath .githooks
```

This runs:
1. **JSON validation** - Checks marketplace.json and all plugin.json files
2. **Version sync** - Ensures versions match between marketplace.json and plugin.json

### Manual Validation

Run validations manually anytime:

```bash
./scripts/validate-json.sh      # Check JSON structure
./scripts/validate-versions.sh  # Check version synchronization
```

---

## Testing Your Changes

After pushing, verify your changes work by installing the marketplace in a Claude Code session:

```
/plugin marketplace add https://github.com/SureAgentAI/agentai-marketplace
/plugin update <plugin>@agentai-marketplace
```

Then confirm your changes appear (new command shows up, skill is available, etc).

---

## Plugin Guidelines

### Naming

- Commands: lowercase with hyphens (`/daily-briefing`, `/create-slides`)
- Skills: lowercase with hyphens (`planner`, `workspace-mcp`)
- Plugins: lowercase with hyphens (`daily-briefing`, `workspace-mcp`)

### Descriptions

Write clear, concise descriptions that tell users what they get:
- Good: `"Daily briefing: /daily-briefing command for morning standup summaries"`
- Bad: `"Various useful commands"`

### Author Format

Always use the object format for author in plugin.json:

```json
{
  "author": {"name": "AgentAI"}
}
```

### No Secrets

Never commit API keys, credentials, or `.env` files. Use `.env.example` to document required environment variables.

---

## Questions?

Open an issue on the repository or ask in a Claude Code session within this repo.
