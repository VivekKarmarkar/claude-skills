#!/bin/bash
# Hook: Detect new/changed plugins and sync to GitHub repo
# Triggered by Stop event — runs at end of every turn, checks for diffs

REPO_DIR="$HOME/claude-skills"
PLUGINS_SRC="$HOME/.claude/plugins/marketplaces/claude-plugins-official/plugins"
BACKUP_DIR="$HOME/skills-backup"

# Skip if repo or source doesn't exist
[ -d "$REPO_DIR/.git" ] || exit 0
[ -d "$PLUGINS_SRC" ] || exit 0

# Quick diff: compare plugin directory listings
current=$(ls "$PLUGINS_SRC" 2>/dev/null | sort)
backed_up=$(ls "$REPO_DIR/plugins" 2>/dev/null | sort)

if [ "$current" = "$backed_up" ]; then
  # No new plugins — skip the expensive rsync
  exit 0
fi

# New plugin detected — sync everything
# 1. Local backup
mkdir -p "$BACKUP_DIR/plugins"
rsync -a --delete "$PLUGINS_SRC/" "$BACKUP_DIR/plugins/"

# 2. Sync to git repo
mkdir -p "$REPO_DIR/plugins"
rsync -a --delete "$PLUGINS_SRC/" "$REPO_DIR/plugins/"

# 3. Also sync skills (in case both changed)
rsync -a --no-links --delete "$HOME/.claude/skills/" "$REPO_DIR/skills/"
for link in "$HOME/.claude/skills/"*/; do
  name=$(basename "$link")
  if [ -L "$HOME/.claude/skills/$name" ]; then
    cp -rL "$HOME/.claude/skills/$name" "$REPO_DIR/skills/$name" 2>/dev/null
  fi
done

# 4. Regenerate README
"$HOME/.claude/hooks/generate-readme.sh"

# 5. Commit and push
cd "$REPO_DIR"
git add -A
if ! git diff --cached --quiet; then
  # List the new plugins in the commit message
  new_plugins=$(diff <(echo "$backed_up") <(echo "$current") | grep '^>' | sed 's/^> //' | tr '\n' ', ' | sed 's/,$//')
  git commit -m "Auto-backup: new plugin(s) installed — $new_plugins"
  git push origin main 2>/dev/null
fi

# Log
echo "$(date '+%Y-%m-%d %H:%M:%S') - Synced new plugins: $new_plugins" >> "$BACKUP_DIR/backup.log"

exit 0
