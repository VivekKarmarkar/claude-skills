# Synthesize PPT — Merge Multiple Decks into One Coherent Presentation

Take multiple PowerPoint files, analyze all their slides, and synthesize a new presentation that tells a coherent, chronological story — pulling the best slides verbatim from each source and creating bridge slides where needed. Then polish with Napkin AI.

## Arguments

`<file paths and/or context>` — The PPTX files to synthesize, plus optional guidance.

Examples:
- `/synthesizeppt ~/decks/q1-review.pptx ~/decks/q2-review.pptx ~/decks/q3-review.pptx`
- `/synthesizeppt ~/research/market-analysis.pptx ~/research/competitor-deep-dive.pptx for an investor pitch`
- `/synthesizeppt ~/lectures/week1.pptx ~/lectures/week2.pptx ~/lectures/week3.pptx into a midterm review`

If no arguments, ask the user for the file paths and the purpose of the synthesized deck.

---

## Phase 1: Ingest All Decks

### Step 1: Validate Files

1. Confirm each file exists and is a valid .pptx
2. If any file is missing, stop and report which ones

### Step 2: Read Every Slide

Use the `/pptx` skill to read each file. For every slide in every deck, extract:

- **Slide number** (within its source deck)
- **Source file** name
- **Title / heading** text
- **Body content** — bullets, paragraphs, data
- **Slide type** — title slide, content slide, section divider, chart/data, image-heavy, blank
- **Key topics** covered
- **Speaker notes** if present

### Step 3: Build the Master Index

Create a complete inventory:

```
Master Slide Index
═══════════════════════════════════════════
Source: q1-review.pptx (15 slides)
  [Q1-01] Title: "Q1 2025 Review"              — title slide
  [Q1-02] Title: "Revenue Summary"              — data/chart
  [Q1-03] Title: "Product Launches"             — content
  ...

Source: q2-review.pptx (18 slides)
  [Q2-01] Title: "Q2 2025 Review"              — title slide
  [Q2-02] Title: "Revenue Summary"              — data/chart
  ...

Total: N slides across M files
═══════════════════════════════════════════
```

---

## Phase 2: Analyze and Plan the Synthesis

### Step 1: Understand the Goal

Ask the user (if not already clear from arguments):

1. **Purpose** — What is this synthesized deck for? (executive review, investor pitch, course summary, project retrospective)
2. **Audience** — Who will see it?
3. **Time constraint** — Target number of slides or presentation length?
4. **Emphasis** — Any topics that should be front and center? Any to de-emphasize?

### Step 2: Identify Themes and Chronology

Analyze all slides across all decks and identify:

- **Common themes** — topics that appear across multiple decks
- **Chronological progression** — how topics evolve across the decks
- **Redundancies** — slides that cover the same content (pick the best version)
- **Gaps** — places where a transition or context slide is needed
- **Contradictions** — data or claims that conflict between decks (flag these)

### Step 3: Design the Narrative Arc

Create a proposed outline for the synthesized deck:

```
Proposed Structure
═══════════════════════════════════════════

1. Title Slide                              [NEW — bridge slide]
2. Overview / Agenda                        [NEW — bridge slide]
3. Background / Context                     [Q1-02] from q1-review.pptx
4. Initial Findings                         [Q1-05] from q1-review.pptx
5. Methodology Evolution                    [NEW — bridge slide]
6. Updated Analysis                         [Q2-03] from q2-review.pptx
7. Comparative Results                      [Q2-07] from q2-review.pptx
8. Key Turning Point                        [NEW — bridge slide]
9. Final Results                            [Q3-04] from q3-review.pptx
10. Conclusions                             [Q3-12] from q3-review.pptx
11. Next Steps                              [NEW — bridge slide]

Slides from sources: N (verbatim)
New bridge slides:   N
Total:               N slides
═══════════════════════════════════════════
```

Present this to the user for approval. Wait for confirmation before building.

---

## Phase 3: Build the Synthesized Deck

### Step 1: Extract Source Slides

For each slide marked as coming from a source deck:
- Use the `/pptx` skill to extract that specific slide
- Preserve it **verbatim** — same layout, same formatting, same content
- Do not modify source slides unless the user explicitly asks

### Step 2: Create Bridge Slides

For each slide marked as `[NEW — bridge slide]`, create content that:

- **Connects** the preceding slide to the next one
- **Provides context** — why are we transitioning? What changed?
- **Summarizes** if bridging between large sections
- **Uses consistent styling** — match the visual style of the source decks (fonts, colors, layout patterns)

Types of bridge slides:

- **Title slide** — new title for the synthesized deck, date, presenter name
- **Agenda / Overview** — roadmap of what the deck covers
- **Section dividers** — "Part 2: Updated Analysis" with brief context
- **Transition slides** — "Between Q1 and Q2, three things changed..."
- **Summary slides** — recap key points before moving to next section
- **Comparison slides** — side-by-side when showing evolution across time
- **Conclusion / Next steps** — wrap up the narrative

### Step 3: Assemble the Final Deck

Use the `/pptx` skill to:
1. Create a new .pptx file
2. Insert source slides in the planned order (verbatim)
3. Insert bridge slides at their planned positions
4. Ensure slide numbering is correct and continuous
5. Add consistent slide numbers / footers if the source decks had them

Save as: `<output-directory>/synthesized-<descriptive-slug>.pptx`

---

## Phase 4: Quality Check

Before polishing, review the assembled deck:

1. **Read through the entire deck** sequentially — does the narrative flow?
2. **Check transitions** — does each slide logically lead to the next?
3. **Check for redundancy** — are there slides saying the same thing twice?
4. **Check styling consistency** — do bridge slides match the source deck aesthetic?
5. **Check data consistency** — are numbers/dates/claims consistent across pulled slides?

If issues are found, fix them and show the user what changed.

---

## Phase 5: Polish with Napkin AI

Run `/napkinpolishppt` on the final synthesized deck:

1. The napkinpolishppt skill will analyze all slides
2. It will identify visual candidates (especially bridge slides, which are text-heavy by nature)
3. Generate Napkin AI visuals for those slides
4. Save visuals alongside the deck

Bridge slides are prime candidates for Napkin since they're freshly written text. Source slides are less likely to need Napkin treatment since they're already designed.

---

## Final Report

```
Synthesis Complete
═══════════════════════════════════════════
Source decks:        N files
Source slides read:  N total
Slides selected:    N (verbatim from sources)
Bridge slides:      N (newly created)
Final deck:         N slides

Output:  <path>/synthesized-<slug>.pptx
Visuals: <path>/napkin-visuals/ (N images)

Source Breakdown:
  q1-review.pptx     — N slides used (of M)
  q2-review.pptx     — N slides used (of M)
  q3-review.pptx     — N slides used (of M)

Flagged Issues:
  - <any data inconsistencies or contradictions found>
═══════════════════════════════════════════
```

---

## Rules

1. **Source slides are sacred.** Pull them verbatim. Do not edit content, formatting, or layout of slides from the original decks unless the user explicitly requests changes.
2. **Present the plan first.** Always show the proposed outline with slide sources and get approval before assembling.
3. **Bridge slides should be invisible.** They should feel like natural parts of the presentation, not obvious "glue" slides. Match the source deck styling.
4. **Flag contradictions.** If deck A says "revenue was $10M" and deck B says "revenue was $12M", don't silently pick one. Flag it for the user.
5. **Respect chronology.** Unless the user specifies a different ordering, arrange content chronologically based on when the source decks were created or what time period they cover.
6. **Less is more.** When in doubt, cut slides rather than include redundant ones. A tight 20-slide deck beats a bloated 50-slide deck.
7. **Always run napkinpolishppt.** The polish step is part of this skill, not optional.
8. **Save alongside sources.** Default output directory is the same directory as the source files, or ask the user if sources are in different directories.
