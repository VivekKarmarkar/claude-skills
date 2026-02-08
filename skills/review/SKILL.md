# Spaced Repetition Review — `/review`

A flashcard system for retaining things you learn while coding. Uses the SM-2 algorithm for intelligent scheduling and the Memory MCP for persistent storage.

## Arguments

- `/review` — Quiz on cards due today (SM-2 scheduled)
- `/review add <topic>` — Create a new flashcard
- `/review stats` — Show card statistics and upcoming schedule

---

## Memory MCP Schema

Each card is a Memory MCP entity:
- **Name:** `SRC_<PascalCaseSlug>` (e.g., `SRC_PythonGIL`, `SRC_ReactUseEffect`)
- **Type:** `review_card`
- **Observations** (one key-value string per observation):
  - `question: <the question>`
  - `answer: <the answer>`
  - `ease_factor: 2.5`
  - `interval: 0`
  - `repetitions: 0`
  - `next_review: <YYYY-MM-DD>`
  - `created: <YYYY-MM-DD>`
  - `last_reviewed: never`
  - `tags: <comma-separated>`
  - `source: manual` or `source: auto`
- **Relations:** optionally `SRC_X → belongs_to_topic → Topic_Y`

### Updating Observations

The Memory MCP has no update API. To change a field:
1. `mcp__memory__delete_observations` — remove the old observation
2. `mcp__memory__add_observations` — add the new value

Always update these fields after a review: `ease_factor`, `interval`, `repetitions`, `next_review`, `last_reviewed`.

---

## Mode: `/review` (Quiz Due Cards)

### Step 1 — Find Due Cards

1. Use `mcp__memory__search_nodes` with query `"review_card"` to find all cards.
2. For each entity returned, read its observations to extract `next_review`.
3. Get today's date via Bash: `date +%Y-%m-%d`
4. Filter to cards where `next_review <= today`. Also include cards where `last_reviewed: never` (new cards).
5. If no cards are due, tell the user and show when the next card is due.

### Step 2 — Present Cards

For each due card (cap at **20 per session**):

1. Show the question:
   ```
   Card 1/N — [tags]
   Q: <question>
   ```
2. Wait for the user to think and respond (or say "show answer").
3. Reveal the answer:
   ```
   A: <answer>
   ```
4. Ask for a rating using natural language OR numbers:
   ```
   How'd you do? (1) Forgot  (2) Hard  (3) Good  (4) Easy
   ```
5. Accept natural language too: "nailed it" → 4, "struggled" → 2, "no idea" → 1, "got it" → 3.

### Step 3 — Run SM-2 and Update

After receiving the rating, compute the new scheduling values using the SM-2 algorithm below, then update the card's observations.

Show the result:
```
Interval: <old>d → <new>d | Next: <date> | Ease: <ease_factor>
```

### Step 4 — Session Summary

After all due cards (or after 20), show:
```
Session Complete
─────────────────
Cards reviewed: N
  Forgot (1): X
  Hard (2):   X
  Good (3):   X
  Easy (4):   X

Next reviews:
  Tomorrow:    N cards
  This week:   N cards
  Later:       N cards
```

If more than 20 cards were due, ask: "There are N more cards due. Continue?"

---

## Mode: `/review add <topic>`

### Step 1 — Generate Q&A

1. Take the `<topic>` argument and any relevant conversation context.
2. Generate a concise question-answer pair. The question should test understanding, not just recall.
3. Show the draft to the user:
   ```
   New Flashcard
   ─────────────
   Q: <question>
   A: <answer>
   Tags: <suggested tags>
   ```
4. Ask: "Save this card, edit it, or cancel?"

### Step 2 — Check for Duplicates

Before saving, use `mcp__memory__search_nodes` with the topic to check for existing `SRC_` entities that cover the same concept. If a close match exists, warn the user and ask whether to proceed.

### Step 3 — Save to Memory MCP

1. Compute the slug: PascalCase of the topic with spaces/special chars removed (e.g., "Python GIL" → `SRC_PythonGIL`).
2. Get today's date via Bash: `date +%Y-%m-%d`
3. Compute tomorrow's date via Bash: `date -d "+1 day" +%Y-%m-%d`
4. Create the entity:

```
mcp__memory__create_entities:
  name: SRC_<Slug>
  entityType: review_card
  observations:
    - "question: <question>"
    - "answer: <answer>"
    - "ease_factor: 2.5"
    - "interval: 0"
    - "repetitions: 0"
    - "next_review: <tomorrow>"
    - "created: <today>"
    - "last_reviewed: never"
    - "tags: <comma-separated>"
    - "source: manual"
```

5. Confirm to the user: "Card saved! It will appear in tomorrow's review."

---

## Mode: `/review stats`

1. Fetch all `review_card` entities via `mcp__memory__search_nodes` with query `"review_card"`.
2. Get today's date.
3. Compute and display:

```
Flashcard Stats
═══════════════════════════════════
Total cards:    N
Due today:      N
Overdue:        N

Maturity Buckets
  New (0 reviews):        N
  Learning (1-3):         N
  Established (4-10):     N
  Mature (10+):           N

Upcoming Schedule
  Tomorrow:    N
  This week:   N
  This month:  N
  Later:       N

Easiest card:  <name> (ease: X.XX)
Hardest card:  <name> (ease: X.XX)
═══════════════════════════════════
```

---

## SM-2 Algorithm Reference

Claude: follow this algorithm exactly when computing new review schedules.

### Inputs
- `q` = user rating (1-4, mapped to SM-2 scale below)
- `EF` = current ease factor (minimum 1.3)
- `n` = current repetitions count
- `I` = current interval in days

### Rating Mapping (our 1-4 → SM-2's 0-5)
| Our Rating | Meaning | SM-2 q |
|------------|---------|--------|
| 1          | Forgot  | 1      |
| 2          | Hard    | 3      |
| 3          | Good    | 4      |
| 4          | Easy    | 5      |

### Algorithm Steps

**If rating = 1 (Forgot):**
- `n = 0` (reset repetitions)
- `I = 1` (review again tomorrow)
- EF unchanged

**If rating >= 2 (Hard/Good/Easy):**
1. Map to SM-2 q value using table above
2. Update ease factor:
   ```
   EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
   ```
   Clamp EF' to minimum 1.3
3. Update repetitions: `n = n + 1`
4. Compute new interval:
   - If `n = 1`: `I = 1`
   - If `n = 2`: `I = 6`
   - If `n >= 3`: `I = round(I * EF')`

### Date Computation

Use Bash to compute the next review date:
```bash
date -d "+<I> days" +%Y-%m-%d
```

### Update the Card

Delete and re-add these observations on the card entity:
- `ease_factor: <EF'>`
- `interval: <I>`
- `repetitions: <n>`
- `next_review: <computed date>`
- `last_reviewed: <today>`

---

## Auto-Suggest Guideline

This is NOT a trigger. It is a behavioral guideline for Claude across all sessions:

After helping the user learn or debug something **non-obvious** (e.g., a tricky API behavior, a surprising gotcha, a useful pattern), consider suggesting:

> "Want me to save that as a flashcard? (`/review add <brief topic>`)"

Rules:
- Max **1 suggestion per session**
- Never suggest during an active `/review` session
- Only suggest for genuinely useful, non-obvious learnings
- If the user declines, don't suggest again that session

---

## Error Handling

- If Memory MCP is unavailable, tell the user: "Memory MCP isn't responding. Cards can't be loaded right now."
- If a card has missing/malformed observations, skip it and warn: "Skipped card <name> — missing data."
- If date computation fails, fall back to showing the interval in days and ask the user to note the date.
