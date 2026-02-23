#!/bin/bash
# Validates that plugin versions in marketplace.json match plugin.json files
# Exit code: 0 = all versions match, 1 = mismatch found

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

MARKETPLACE_JSON="$REPO_ROOT/.claude-plugin/marketplace.json"
PLUGINS_DIR="$REPO_ROOT/plugins"

if [[ ! -f "$MARKETPLACE_JSON" ]]; then
    echo "Error: marketplace.json not found at $MARKETPLACE_JSON"
    exit 1
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed."
    echo "Install with: brew install jq"
    exit 1
fi

errors=0

echo "Validating plugin version synchronization..."
echo ""

# Get all plugins from marketplace.json
plugins=$(jq -r '.plugins[] | "\(.name):\(.version)"' "$MARKETPLACE_JSON")

for entry in $plugins; do
    plugin_name="${entry%%:*}"
    marketplace_version="${entry#*:}"

    plugin_json="$PLUGINS_DIR/$plugin_name/.claude-plugin/plugin.json"

    if [[ ! -f "$plugin_json" ]]; then
        echo "  [WARN] Plugin '$plugin_name' listed in marketplace.json but no plugin.json found"
        echo "         Expected: $plugin_json"
        continue
    fi

    plugin_version=$(jq -r '.version' "$plugin_json")

    if [[ "$marketplace_version" != "$plugin_version" ]]; then
        echo "  [FAIL] $plugin_name: version mismatch"
        echo "         marketplace.json: $marketplace_version"
        echo "         plugin.json:      $plugin_version"
        ((errors++))
    else
        echo "  [OK]   $plugin_name: $marketplace_version"
    fi
done

echo ""

if [[ $errors -gt 0 ]]; then
    echo "Version validation failed: $errors mismatch(es) found"
    echo ""
    echo "Fix by updating versions in BOTH files:"
    echo "  1. .claude-plugin/marketplace.json"
    echo "  2. plugins/<name>/.claude-plugin/plugin.json"
    exit 1
fi

echo "All plugin versions are synchronized."
exit 0
