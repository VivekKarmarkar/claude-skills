#!/bin/bash
# Classify errors as regular coding vs Claude Code specific and suggest targeted searches

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // ""')
EXIT_CODE=$(echo "$INPUT" | jq -r '.tool_result.exit_code // 0')
STDERR=$(echo "$INPUT" | jq -r '.tool_result.stderr // ""')
STDOUT=$(echo "$INPUT" | jq -r '.tool_result.stdout // ""')

# Only trigger on Bash errors
[ "$TOOL" = "Bash" ] || exit 0
[ "$EXIT_CODE" != "0" ] || exit 0

OUTPUT="$STDERR $STDOUT"

# Claude Code specific keywords
CC_PATTERNS="mcp|MCP|hook|hooks|skill|SKILL\.md|plugin|\.claude/|claude\.json|PostToolUse|PreToolUse|UserPromptSubmit"
CC_PATTERNS="$CC_PATTERNS|tool_use|tool_result|context.window|token.limit|permission.denied.*claude"
CC_PATTERNS="$CC_PATTERNS|subagent|TaskCreate|TaskUpdate|SendMessage|TeamCreate"
CC_PATTERNS="$CC_PATTERNS|claude-code|npx.*claude|mcp.server|stdio.*server"
CC_PATTERNS="$CC_PATTERNS|\.claude/settings|\.claude/plugins|\.claude/skills|\.claude/hooks"

if echo "$OUTPUT" | grep -qiE "$CC_PATTERNS"; then
  # Extract a concise error snippet for searching (first 150 chars of relevant line)
  ERROR_SNIPPET=$(echo "$OUTPUT" | grep -iE "$CC_PATTERNS" | head -1 | cut -c1-150)

  cat << EOF
[Claude Code Error Detected]

This looks like a Claude Code-specific issue, not a regular coding error.

Error snippet: $ERROR_SNIPPET

Search these sources for solutions (in priority order):
1. Official docs: docs.anthropic.com/en/docs/claude-code/troubleshooting
2. GitHub issues: github.com/anthropics/claude-code/issues (search with gh cli)
3. Reddit: r/ClaudeCode and r/ClaudeAI
4. Twitter: @bcherny @trq212 @nsthorat for Claude Code tips
5. Community wiki: claudelog.com

Use WebSearch with the error snippet + "Claude Code" to find solutions.
EOF
fi

exit 0
