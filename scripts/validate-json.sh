#!/bin/bash
# Validates JSON files against schemas
# Exit code: 0 = all valid, 1 = validation errors

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SCHEMAS_DIR="$REPO_ROOT/schemas"
MARKETPLACE_JSON="$REPO_ROOT/.claude-plugin/marketplace.json"
PLUGINS_DIR="$REPO_ROOT/plugins"

errors=0

echo "Validating JSON files..."
echo ""

# Function to validate JSON syntax
validate_json_syntax() {
    local file="$1"
    local name="$2"

    if ! jq empty "$file" 2>/dev/null; then
        echo "  [FAIL] $name: Invalid JSON syntax"
        return 1
    fi
    return 0
}

# Function to validate marketplace.json structure
validate_marketplace() {
    local file="$1"

    echo "Checking marketplace.json structure..."

    # Required top-level fields
    local required_fields=('$schema' 'name' 'version' 'owner' 'plugins')

    for field in "${required_fields[@]}"; do
        if [[ $(jq --arg f "$field" 'has($f)' "$file") != "true" ]]; then
            echo "  [FAIL] marketplace.json: missing required field '$field'"
            return 1
        fi
    done

    # Validate owner is an object with name
    if [[ $(jq '.owner | type' "$file") != '"object"' ]]; then
        echo "  [FAIL] marketplace.json: 'owner' must be an object"
        return 1
    fi

    if [[ $(jq '.owner | has("name")' "$file") != "true" ]]; then
        echo "  [FAIL] marketplace.json: 'owner' must have 'name' field"
        return 1
    fi

    # Validate each plugin entry
    local plugin_count=$(jq '.plugins | length' "$file")
    for ((i=0; i<plugin_count; i++)); do
        local plugin_name=$(jq -r ".plugins[$i].name" "$file")

        # Required plugin fields
        local plugin_required=('name' 'description' 'version' 'author' 'source')
        for field in "${plugin_required[@]}"; do
            if [[ $(jq --argjson i "$i" --arg f "$field" '.plugins[$i] | has($f)' "$file") != "true" ]]; then
                echo "  [FAIL] marketplace.json: plugin '$plugin_name' missing '$field'"
                return 1
            fi
        done

        # Author must be object with name
        if [[ $(jq --argjson i "$i" '.plugins[$i].author | type' "$file") != '"object"' ]]; then
            echo "  [FAIL] marketplace.json: plugin '$plugin_name' author must be object, not string"
            return 1
        fi

        if [[ $(jq --argjson i "$i" '.plugins[$i].author | has("name")' "$file") != "true" ]]; then
            echo "  [FAIL] marketplace.json: plugin '$plugin_name' author must have 'name'"
            return 1
        fi
    done

    echo "  [OK]   marketplace.json: valid structure"
    return 0
}

# Function to validate plugin.json structure
validate_plugin_json() {
    local file="$1"
    local plugin_name="$2"

    # Required fields
    local required_fields=('name' 'description' 'version' 'author')

    for field in "${required_fields[@]}"; do
        if [[ $(jq --arg f "$field" 'has($f)' "$file") != "true" ]]; then
            echo "  [FAIL] $plugin_name/plugin.json: missing required field '$field'"
            return 1
        fi
    done

    # Author must be object with name
    if [[ $(jq '.author | type' "$file") != '"object"' ]]; then
        echo "  [FAIL] $plugin_name/plugin.json: 'author' must be object {\"name\": \"...\"}, not string"
        return 1
    fi

    if [[ $(jq '.author | has("name")' "$file") != "true" ]]; then
        echo "  [FAIL] $plugin_name/plugin.json: 'author' must have 'name' field"
        return 1
    fi

    # Version format check (semver-ish)
    local version=$(jq -r '.version' "$file")
    if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "  [WARN] $plugin_name/plugin.json: version '$version' doesn't follow semver (x.y.z)"
    fi

    echo "  [OK]   $plugin_name/plugin.json: valid structure"
    return 0
}

# Check jq is available
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed."
    echo "Install with: brew install jq"
    exit 1
fi

# Validate marketplace.json
if [[ -f "$MARKETPLACE_JSON" ]]; then
    if ! validate_json_syntax "$MARKETPLACE_JSON" "marketplace.json"; then
        ((errors++))
    elif ! validate_marketplace "$MARKETPLACE_JSON"; then
        ((errors++))
    fi
else
    echo "  [FAIL] marketplace.json not found"
    ((errors++))
fi

echo ""
echo "Checking plugin.json files..."

# Validate each plugin's plugin.json
for plugin_dir in "$PLUGINS_DIR"/*/; do
    plugin_name=$(basename "$plugin_dir")
    plugin_json="$plugin_dir.claude-plugin/plugin.json"

    if [[ -f "$plugin_json" ]]; then
        if ! validate_json_syntax "$plugin_json" "$plugin_name/plugin.json"; then
            ((errors++))
        elif ! validate_plugin_json "$plugin_json" "$plugin_name"; then
            ((errors++))
        fi
    else
        echo "  [WARN] $plugin_name: no plugin.json found"
    fi
done

echo ""

if [[ $errors -gt 0 ]]; then
    echo "JSON validation failed: $errors error(s) found"
    exit 1
fi

echo "All JSON files are valid."
exit 0
