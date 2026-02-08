# Synthesize PDF — Merge Multiple PDFs into One Coherent Document

Take multiple PDF files, analyze all their content, and synthesize a new PDF that tells a coherent, chronological story — pulling the best sections verbatim from each source and creating bridge text where needed.

## Arguments

`<file paths and/or context>` — The PDF files to synthesize, plus optional guidance.

Examples:
- `/synthesizepdf ~/papers/Chen2024_CRISPR.pdf ~/papers/Liu2023_Delivery.pdf ~/papers/Wang2025_InVivo.pdf`
- `/synthesizepdf ~/reports/q1-financials.pdf ~/reports/q2-financials.pdf into an annual summary`
- `/synthesizepdf ~/notes/lecture1.pdf ~/notes/lecture2.pdf ~/notes/lecture3.pdf into a study guide`

If no arguments, ask the user for the file paths and the purpose of the synthesized document.

---

## Phase 1: Ingest All PDFs

### Step 1: Validate Files

1. Confirm each file exists and is a valid .pdf
2. If any file is missing, stop and report which ones

### Step 2: Read Every Document

Use the `/pdf` skill to read each file. For every PDF, extract:

- **Page count**
- **Source file** name
- **Title** (from metadata or first page heading)
- **Table of contents / sections** if present
- **Section headings** and their hierarchy
- **Key content** per section — main arguments, data, findings
- **Figures / tables** — note their locations and what they show
- **Page ranges** for each section

### Step 3: Build the Master Index

Create a complete inventory:

```
Master Content Index
═══════════════════════════════════════════
Source: Chen2024_CRISPR.pdf (22 pages)
  [C-p1-3]   Abstract & Introduction         — background, research question
  [C-p4-8]   Methods                          — CRISPR delivery approach
  [C-p9-14]  Results                          — efficacy data, figures 1-4
  [C-p15-18] Discussion                       — implications, limitations
  [C-p19-22] References                       — bibliography

Source: Liu2023_Delivery.pdf (18 pages)
  [L-p1-2]   Abstract & Introduction         — delivery mechanisms overview
  [L-p3-7]   Lipid Nanoparticles              — LNP methods and results
  [L-p8-12]  Viral Vectors                    — AAV methods and results
  ...

Total: N pages across M files
═══════════════════════════════════════════
```

---

## Phase 2: Analyze and Plan the Synthesis

### Step 1: Understand the Goal

Ask the user (if not already clear from arguments):

1. **Purpose** — What is this synthesized document for? (literature review, study guide, combined report, executive summary, grant proposal background)
2. **Audience** — Who will read it?
3. **Length target** — Roughly how long should the output be? (concise summary vs comprehensive merge)
4. **Emphasis** — Any sections or topics to prioritize? Any to exclude?
5. **Output format** — Pure text PDF, or preserve original formatting where possible?

### Step 2: Identify Structure and Themes

Analyze all content across all PDFs and identify:

- **Common themes** — topics that appear across multiple documents
- **Chronological progression** — how ideas, data, or events evolve across sources
- **Complementary content** — sections from different PDFs that cover different angles of the same topic
- **Redundancies** — sections that overlap substantially (pick the best version)
- **Gaps** — places where a transition, summary, or context paragraph is needed
- **Contradictions** — claims or data that conflict between sources (flag these)

### Step 3: Design the Document Structure

Create a proposed outline for the synthesized PDF:

```
Proposed Structure
═══════════════════════════════════════════

1. Title Page                               [NEW — bridge content]
2. Executive Summary / Abstract             [NEW — bridge content]
3. Table of Contents                        [NEW — auto-generated]
4. Introduction & Background
   4.1 Context                              [L-p1-2] from Liu2023
   4.2 Research Question                    [C-p1-3] from Chen2024
   4.3 Scope of This Document               [NEW — bridge paragraph]
5. Methods Overview
   5.1 Delivery Approaches                  [L-p3-4] from Liu2023
   5.2 CRISPR Protocol                      [C-p4-8] from Chen2024
   5.3 Connecting the Approaches            [NEW — bridge paragraph]
6. Results
   6.1 LNP Efficacy                         [L-p8-10] from Liu2023
   6.2 In Vivo Results                      [C-p9-14] from Chen2024
   6.3 Comparative Analysis                 [NEW — bridge section]
7. Discussion                               [NEW — synthesized from all sources]
8. Conclusions & Future Directions          [NEW — bridge content]
9. Combined References                      [MERGED — all sources]

Pages from sources: ~N (verbatim)
New bridge content:  ~N pages
Estimated total:     ~N pages
═══════════════════════════════════════════
```

Present this to the user for approval. Wait for confirmation before building.

---

## Phase 3: Build the Synthesized Document

### Step 1: Extract Source Content

For each section marked as coming from a source PDF:
- Use the `/pdf` skill to extract those specific pages/sections
- Preserve content **verbatim** — same text, same data, same figures referenced
- Note figure/table references that may need renumbering

### Step 2: Create Bridge Content

For each section marked as `[NEW — bridge content]`, write text that:

- **Connects** the preceding section to the next one
- **Provides context** — why this transition matters
- **Summarizes** when bridging between large sections
- **Synthesizes** when comparing findings from multiple sources
- **Cites the sources** — every claim references which source PDF it comes from

Types of bridge content:

- **Title page** — new title for the synthesized document, date, author
- **Executive summary / Abstract** — 1-page overview synthesizing the key points from all sources
- **Transition paragraphs** — "Having established X in the previous section, we now turn to Y..."
- **Comparative analysis sections** — side-by-side discussion of findings from different sources
- **Synthesized discussion** — weave together the implications from all source documents
- **Combined conclusions** — unified takeaways drawing on all sources
- **Merged reference list** — deduplicated, consistently formatted bibliography from all sources

### Step 3: Assemble the Final Document

Use the `/pdf` skill to create the synthesized PDF:

1. Create a new document with proper structure
2. Insert source content in the planned order (verbatim)
3. Insert bridge content at planned positions
4. Add page numbers, headers/footers
5. Generate table of contents from section headings
6. Renumber figures and tables sequentially if needed
7. Ensure cross-references are correct

Save as: `<output-directory>/synthesized-<descriptive-slug>.pdf`

---

## Phase 4: Quality Check

Review the assembled document:

1. **Read through sequentially** — does the narrative flow?
2. **Check transitions** — does each section logically lead to the next?
3. **Check for redundancy** — are there paragraphs saying the same thing twice?
4. **Check citations** — is every claim properly attributed to its source?
5. **Check data consistency** — are numbers, dates, and claims consistent across pulled sections?
6. **Check references** — is the combined bibliography complete and deduplicated?
7. **Check figures/tables** — are they referenced correctly after renumbering?

If issues are found, fix them and note what changed.

---

## Phase 5: Create Companion Materials (Optional)

If the synthesized document is long (10+ pages), offer to create:

### Summary One-Pager
A single-page executive summary PDF with:
- Key findings (3-5 bullets)
- Key data points
- Main conclusion
- Source list

Save as: `<output-directory>/synthesized-<slug>-summary.pdf`

### Companion Presentation
Offer: "Want me to create a presentation from this? (`/pptx`)"

---

## Final Report

```
Synthesis Complete
═══════════════════════════════════════════
Source documents:    N files
Source pages read:   N total
Content preserved:  N pages (verbatim from sources)
Bridge content:     N pages/sections (newly written)
Final document:     N pages

Output:  <path>/synthesized-<slug>.pdf

Source Breakdown:
  Chen2024_CRISPR.pdf    — N sections used (of M)
  Liu2023_Delivery.pdf   — N sections used (of M)
  Wang2025_InVivo.pdf    — N sections used (of M)

Flagged Issues:
  - <any data inconsistencies or contradictions found>
═══════════════════════════════════════════
```

---

## Rules

1. **Source content is sacred.** Pull it verbatim. Do not edit the text of sections taken from source PDFs unless the user explicitly requests changes.
2. **Present the plan first.** Always show the proposed structure with sources and get approval before assembling.
3. **Bridge content should be seamless.** It should read as natural parts of the document, not obvious filler. Match the tone and style of the source material.
4. **Cite everything.** Bridge content must reference which source document claims come from. Use a consistent citation format (e.g., "(Chen, 2024)" or "[1]").
5. **Flag contradictions.** If source A says one thing and source B says another, don't silently pick one. Note the discrepancy in the text.
6. **Respect copyright.** The verbatim sections are for the user's personal use. The synthesized document should not be published without proper attribution.
7. **Chronology by default.** Unless the user specifies a different ordering, arrange content chronologically or by logical progression.
8. **Less is more.** A tight, focused synthesis beats a bloated merge. Cut redundancies aggressively.
9. **Always offer the summary one-pager** for documents over 10 pages.
