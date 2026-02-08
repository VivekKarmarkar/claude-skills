# Synthesize — Smart Router for Merging Multiple Files

Detect file types, then delegate to the right specialized skill — or handle generic synthesis inline.

## Arguments

`<file paths and/or context>` — The files to synthesize, plus optional guidance.

Examples:
- `/synthesize ~/decks/q1.pptx ~/decks/q2.pptx ~/decks/q3.pptx`
- `/synthesize ~/papers/chen2024.pdf ~/papers/liu2023.pdf into a literature review`
- `/synthesize ~/notes/week1.md ~/notes/week2.md ~/data/results.csv into a report`
- `/synthesize ~/mix/slides.pptx ~/mix/paper.pdf ~/mix/notes.md`

If no arguments, ask the user for the file paths and purpose.

---

## Step 1: Detect File Types

Parse all file paths from the arguments. For each file:

1. Confirm it exists
2. Classify by extension:
   - `.pptx` → **presentation**
   - `.pdf` → **document**
   - `.md` → **markdown**
   - `.txt` → **text**
   - `.csv` / `.tsv` → **data**
   - `.json` → **data**
   - `.docx` → **document**
   - Other → **unknown**

Build a summary:

```
File Detection
═══════════════════════════════════════════
Files provided:  N

  ~/decks/q1.pptx          → presentation
  ~/decks/q2.pptx          → presentation
  ~/notes/summary.md       → markdown

Types found:  presentation (2), markdown (1)
═══════════════════════════════════════════
```

---

## Step 2: Route Based on Types

### Case A: All .pptx files

Delegate entirely:

> "All files are PowerPoint presentations. Routing to `/synthesizeppt`."

Run the `/synthesizeppt` skill with the same arguments. Stop here — that skill handles everything.

### Case B: All .pdf files

Delegate entirely:

> "All files are PDFs. Routing to `/synthesizepdf`."

Run the `/synthesizepdf` skill with the same arguments. Stop here — that skill handles everything.

### Case C: Mixed types (or non-pptx/pdf)

Handle inline using the Generic Synthesis flow below.

This includes:
- All markdown files
- All text/CSV/JSON files
- A mix of PDFs + markdown + data
- A mix of PPTXs + other formats
- Any combination that isn't purely one delegatable type

---

## Generic Synthesis Flow

For mixed or non-standard file types, synthesize directly.

### Phase 1: Ingest All Files

Read every file and extract content:

- **Markdown / Text** — read directly with the Read tool
- **PDF** — use the `/pdf` skill to extract text content
- **PPTX** — use the `/pptx` skill to extract slide text
- **CSV / TSV** — read as data, note column headers and row counts
- **JSON** — read and summarize structure and key data
- **DOCX** — extract text content (use python-docx via Bash if available, or note limitation)

For each file, record:
- **Source file** name and type
- **Content length** (pages, slides, rows, or word count as appropriate)
- **Key sections / structure** — headings, columns, slide titles
- **Core content summary** — main topics, data points, arguments

### Phase 2: Plan the Synthesis

Ask the user (if not clear from arguments):

1. **Output format** — What should the final product be?
   - A single markdown document (default for text-based inputs)
   - A PDF (use `/pdf` skill to create)
   - A presentation (use `/pptx` skill to create)
   - A webpage (use `/makewebpage` skill to create)
2. **Purpose** — What is this for? (report, summary, study guide, analysis, reference doc)
3. **Length** — Concise summary or comprehensive merge?

### Phase 3: Design the Structure

Create a proposed outline showing where each source contributes:

```
Proposed Structure
═══════════════════════════════════════════

1. Title & Overview                        [NEW — bridge content]
2. Background
   2.1 Context from Literature             [chen2024.pdf, p1-3]
   2.2 Historical Data                     [results.csv, all rows]
3. Analysis
   3.1 Key Findings                        [liu2023.pdf, p5-10]
   3.2 Supporting Notes                    [notes/week1.md, full]
   3.3 Data Summary                        [results.csv, summary]
4. Discussion                              [NEW — synthesized]
5. Conclusions                             [NEW — bridge content]
6. Sources                                 [MERGED — all files]

═══════════════════════════════════════════
```

Present to the user for approval before building.

### Phase 4: Build the Document

1. **Pull source content verbatim** where the plan says to
2. **Create bridge content** for sections marked `[NEW]`:
   - Transitions between sources
   - Synthesized analysis combining multiple inputs
   - Executive summary pulling from all sources
   - Combined conclusions
3. **Handle data files specially**:
   - CSV/JSON → convert to formatted tables or reference in text
   - Include key statistics inline, link to full data
4. **Cite sources** — every claim references which file it came from

### Phase 5: Create the Output

Based on the chosen output format:

- **Markdown** → Write to `<output-dir>/synthesized-<slug>.md`
- **PDF** → Use `/pdf` skill to create `<output-dir>/synthesized-<slug>.pdf`
- **PPTX** → Use `/pptx` skill to create `<output-dir>/synthesized-<slug>.pptx`, then run `/napkinpolishppt`
- **Webpage** → Use `/makewebpage` skill

### Phase 6: Quality Check

1. Read through the output — does the narrative flow?
2. Check transitions between content from different sources
3. Check for redundancy
4. Verify all sources are cited
5. Verify data consistency across sources

---

## Final Report

```
Synthesis Complete
═══════════════════════════════════════════
Input files:     N files (N types)
Route taken:     <delegated to synthesizeppt | delegated to synthesizepdf | generic synthesis>
Output format:   <markdown | pdf | pptx | webpage>
Output file:     <path>

Source Breakdown:
  chen2024.pdf       — N sections used
  results.csv        — N rows / N columns referenced
  notes/week1.md     — full document used
  ...

Bridge content:     N sections (newly written)
═══════════════════════════════════════════
```

---

## Rules

1. **Delegate when possible.** If all files are the same supported type (pptx or pdf), use the specialized skill. Don't reinvent the wheel.
2. **Source content is sacred.** Pull verbatim. Don't edit source text unless the user asks.
3. **Present the plan first.** Always show the proposed structure and get approval.
4. **Default output is markdown.** Unless the user specifies otherwise or the inputs suggest a different format (e.g., all PPTXs → PPTX output).
5. **Handle missing files gracefully.** If some files don't exist, report which ones are missing and ask whether to proceed with the rest.
6. **Mixed types are fine.** The whole point of this skill is handling heterogeneous inputs. Don't refuse — adapt.
7. **Cite everything.** Bridge content must reference which source file claims come from.
8. **Flag contradictions.** If sources disagree, note it explicitly.
9. **Less is more.** Cut redundancies aggressively. A tight synthesis beats a bloated merge.
