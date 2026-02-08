# Git Commit — Commit and Push

Stage, commit, and push changes to the remote in one step.

## Arguments

`<commit message>` — Optional. If not provided, auto-generate a message from the changes.

Examples:
- `/gitcommit` — auto-generates commit message
- `/gitcommit add login page` — uses "add login page" as the message

## Workflow

### Step 1: Pre-flight Checks

1. Confirm the current directory is a git repo. If not, stop and suggest `/gitinit`.
2. Check for a remote (`git remote -v`). If no remote, stop and tell the user to set one up.
3. Run `git status`. If there are no changes (staged or unstaged), tell the user and stop.

### Step 2: Review Changes

1. Run `git diff` and `git diff --cached` to see all changes.
2. Run `git status` to see untracked files.
3. Show the user a brief summary:
   ```
   Changes to commit:
     Modified: 3 files
     New:      1 file
     Deleted:  0 files
   ```

### Step 3: Generate or Use Commit Message

**If the user provided a message:** use it as-is.

**If no message provided:**
1. Look at the diff and staged changes.
2. Write a concise commit message (1-2 sentences) that describes what changed and why.
3. Show it to the user for approval before committing.

### Step 4: Stage, Commit, Push

1. Stage all changes: `git add -A`
   - But first check for `.env` files, credentials, or secrets in the untracked files. If found, warn the user and do NOT stage them. Add them to `.gitignore` instead.
2. Commit: `git commit -m "<message>"`
3. Push: `git push`
   - If no upstream is set, use `git push -u origin <current-branch>`
4. Confirm:
   ```
   Committed and pushed to <branch>.
   ```

## Rules

- **Never commit secrets.** Check for `.env`, API keys, credentials, tokens in untracked files before staging. If found, add to `.gitignore` and warn.
- **Never force push.** Use regular `git push` only.
- **Show the commit message before committing** if it was auto-generated. Don't commit without the user seeing the message.
- **Keep it simple.** No branching, no PRs, no rebasing. Just commit and push.
