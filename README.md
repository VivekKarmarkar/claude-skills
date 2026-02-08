# Claude Code OS for VivekKmk

My personalized operating system for Claude Code — skills, plugins, and hooks that extend what Claude can do. Auto-synced whenever anything is added or edited.

## Skills (19)

| Skill | Description |
|-------|-------------|
| `cooldown` | End-of-session cooldown that generates all project artifacts in sequence —… |
| `makesong` | Make Song: Generate & Download Music with Suno |
| `makevideo` | Make Video: Screen Record, Edit & Produce |
| `manimce-best-practices` | Trigger when: (1) User mentions "manim" or "Manim Community" or "ManimCE", (2)… |
| `manim-composer` | Trigger when: (1) User wants to create an educational/explainer video, (2) User… |
| `manimgl-best-practices` | Trigger when: (1) User mentions "manimgl" or "ManimGL" or "3b1b manim", (2)… |
| `medium` | Medium Article Writer |
| `pdf` | Create, merge, split, fill, and manipulate PDF files |
| `pptx` | Use this skill any time a .pptx file is involved in any way — as input, output,… |
| `prism` | Write and compile LaTeX in OpenAI's Prism editor via browser automation |
| `projectstatus` | Generate a project status report. Use when the user wants a status update,… |
| `remember` | Commit important information to the persistent memory graph. Use when the user… |
| `remotion-best-practices` | Best practices for Remotion - Video creation in React |
| `review` | Spaced Repetition Review: `/review` |
| `roadmap` | Create a project roadmap document. Use when the user wants to plan milestones,… |
| `summary` | Summarize the current chat session into a well-structured markdown file. Use… |
| `swarm` | Spin up autonomous agent teams with bypassed permissions |
| `tweet` | Tweet: Draft and Post on X |
| `warmup` | Start-of-session warmup that reads all existing project artifacts —… |

## Plugins (13)

| Plugin | Description |
|--------|-------------|
| `claude-md-management` | Tools to maintain and improve CLAUDE.md files - audit quality, capture session… |
| `code-review` | Automated code review for pull requests using multiple specialized agents with… |
| `code-simplifier` | Agent that simplifies and refines code for clarity, consistency, and… |
| `commit-commands` | Streamline your git workflow with simple commands for committing, pushing, and… |
| `explanatory-output-style` | Adds educational insights about implementation choices and codebase patterns… |
| `feature-dev` | Comprehensive feature development workflow with specialized agents for codebase… |
| `frontend-design` | Frontend design skill for UI/UX implementation |
| `hookify` | Easily create hooks to prevent unwanted behaviors by analyzing conversation… |
| `learning-output-style` | Interactive learning mode that requests meaningful code contributions at… |
| `playground` | Creates interactive HTML playgrounds — self-contained single-file explorers… |
| `pr-review-toolkit` | Comprehensive PR review agents specializing in comments, tests, error handling,… |
| `ralph-loop` | Continuous self-referential AI loops for interactive iterative development,… |
| `typescript-lsp` | typescript-lsp |

## Hooks (5)

| Hook | Description |
|------|-------------|
| `backup-skills.sh` | Hook: Backup skills and plugins after any file write to ~/.claude/skills/ or… |
| `error-search.sh` | Classify errors as regular coding vs Claude Code specific and suggest targeted… |
| `generate-readme.sh` | Generates README.md for the claude-skills repo from current skills and plugins |
| `sync-mcp.sh` | Export MCP server configs (with secrets redacted) to the repo |
| `sync-plugins.sh` | Hook: Sync INSTALLED plugins (not entire marketplace) to GitHub repo |

## MCP Servers (3)

| Server | Command | Description |
|--------|---------|-------------|
| `claude-in-chrome` | `chrome-extension` | Browser automation via Chrome extension (screenshots, clicks, navigation, forms) |
| `memory` | `npx` | Persistent knowledge graph across conversations |
| `voicemode` | `uvx` | Voice conversation with STT/TTS via ElevenLabs + Kokoro + OpenAI |

## Auto-Backup

Hooks watch for changes to `~/.claude/skills/`, `~/.claude/plugins/`, `~/.claude/hooks/`, and MCP configs. On any change:

1. Syncs to a local backup at `~/skills-backup/`
2. Regenerates this README
3. Commits and pushes to this repo
