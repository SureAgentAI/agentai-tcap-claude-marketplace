# AgentAI Marketplace

Public Claude Code plugin marketplace for AgentAI clients.

## Structure

```
agentai-marketplace/
├── .claude-plugin/marketplace.json   # Plugin catalog (THE source of truth)
├── schemas/                          # JSON schemas for validation
├── plugins/                          # One directory per plugin
│   ├── <name>/.claude-plugin/plugin.json
│   ├── <name>/commands/*.md
│   ├── <name>/skills/*/SKILL.md
│   ├── <name>/agents/*.md
│   └── <name>/.mcp.json             # (optional) MCP server configs
├── scripts/                          # Validation scripts
└── .githooks/                        # Pre-commit validation
```

## Rules

- **Version sync required**: Version in `plugins/<name>/.claude-plugin/plugin.json` MUST match the entry in `.claude-plugin/marketplace.json`. Without a bump, users don't receive updates.
- **Run validation before committing**: `./scripts/validate-json.sh && ./scripts/validate-versions.sh`
- **Pre-commit hooks**: Enable with `git config core.hooksPath .githooks`
- **No secrets**: Never commit API keys, credentials, or `.env` files
- **Plugin naming**: lowercase with hyphens (`daily-briefing`, `workspace-mcp`)
- **Author format**: Always `{"name": "AgentAI"}` (object, not string)

## Adding a Plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json`
2. Add commands to `plugins/<name>/commands/*.md`
3. Add skills to `plugins/<name>/skills/*/SKILL.md`
4. Add entry to `.claude-plugin/marketplace.json`
5. Ensure versions match
6. Run validation scripts
7. Commit

## Validation

```bash
./scripts/validate-json.sh      # JSON structure
./scripts/validate-versions.sh  # Version sync
```
