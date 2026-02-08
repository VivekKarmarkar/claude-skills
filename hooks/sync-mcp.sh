#!/bin/bash
# Export MCP server configs (with secrets redacted) to the repo

REPO_DIR="$HOME/claude-skills"
CLAUDE_JSON="$HOME/.claude.json"

[ -f "$CLAUDE_JSON" ] || exit 0
[ -d "$REPO_DIR/.git" ] || exit 0

python3 -c "
import json, os

# Load existing repo file to preserve manual entries (e.g. claude-in-chrome)
repo_file = '$REPO_DIR/mcp-servers.json'
existing = {}
if os.path.exists(repo_file):
    with open(repo_file) as f:
        existing = json.load(f)

# Load current MCP config from claude.json
with open('$CLAUDE_JSON') as f:
    data = json.load(f)
servers = data.get('mcpServers', {})

# Redact secrets
for name, cfg in servers.items():
    env = cfg.get('env', {})
    for k, v in env.items():
        if any(s in v.lower() for s in ['sk_', 'api_', 'key_', 'secret_', 'token_']) or any(s in k.lower() for s in ['api_key', 'secret', 'token', 'password']):
            env[k] = 'REDACTED'

# Merge: config servers + manual entries (manual entries preserved if not in config)
for name, cfg in existing.items():
    if name not in servers and cfg.get('type') != 'stdio':
        servers[name] = cfg

with open(repo_file, 'w') as f:
    json.dump(servers, f, indent=2)
    f.write('\n')
"
