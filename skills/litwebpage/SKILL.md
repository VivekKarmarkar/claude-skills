# Lit Webpage — Literature Review to Polished Webpage

Run a full pipeline: research a topic, synthesize the findings, and publish as a beautiful interactive webpage.

## Arguments

`<research topic and/or context>` — What to research and turn into a webpage.

Examples:
- `/litwebpage CRISPR delivery mechanisms for in vivo gene therapy`
- `/litwebpage recent advances in transformer architectures for protein folding`
- `/litwebpage comparative effectiveness of GLP-1 receptor agonists`

If no arguments, ask the user for the research topic.

---

## Pipeline

This skill chains three skills in sequence. The output of each step feeds the next.

### Step 1: Literature Review (`/litreview`)

Run the `/litreview` skill with the user's topic.

This will:
- Scope the research with the user
- Search PubMed, Google Scholar, the web, and Connected Papers
- Read and annotate papers
- Organize everything into `~/lit-reviews/<topic-slug>/`
- Create analysis files, a summary, and a presentation

**Gate:** Wait for `/litreview` to complete. Confirm with the user:

> "Literature review complete. N sources found, organized at `~/lit-reviews/<slug>/`. Ready to synthesize into a single document?"

Proceed only after user confirmation.

### Step 2: Synthesize (`/synthesize`)

Run the `/synthesize` skill on the lit review outputs.

Feed it the key files from Step 1:
- `~/lit-reviews/<slug>/summary.md`
- `~/lit-reviews/<slug>/analysis/*.md` (all analysis files)
- Any downloaded PDFs from `~/lit-reviews/<slug>/sources/papers/`

Tell `/synthesize` the purpose: "Synthesize these literature review materials into a single cohesive markdown document suitable for converting into a webpage."

The output format should be **markdown** — this becomes the content source for the webpage.

**Gate:** Wait for `/synthesize` to complete. Confirm with the user:

> "Synthesis complete. Output at `<path>`. Ready to build the webpage?"

Proceed only after user confirmation.

### Step 3: Make Webpage (`/makewebpage`)

Run the `/makewebpage` skill using the synthesized document as the content source.

Tell `/makewebpage`:
- **Source:** the synthesized markdown from Step 2
- **Type:** documentation / article page (sticky sidebar nav, table of contents, sections)
- **Style:** clean, academic, readable — generous whitespace, clear typography hierarchy
- **Features to include:**
  - Sticky sidebar with section navigation
  - Table of contents auto-generated from headings
  - Citation references (linked footnotes or inline citations)
  - Key findings highlighted in callout boxes
  - Data tables styled with alternating rows
  - Back-to-top button
  - Responsive — works on mobile
  - Dark mode toggle (if the content is long)

**Gate:** `/makewebpage` will preview in Chrome and iterate with the user.

---

## Final Report

```
Lit Webpage Pipeline Complete
═══════════════════════════════════════════
Topic:              <research topic>

Step 1 — Literature Review:
  Sources found:    N
  Papers read:      N
  Output:           ~/lit-reviews/<slug>/

Step 2 — Synthesis:
  Files merged:     N
  Output:           <path>/synthesized-<slug>.md

Step 3 — Webpage:
  Output:           <path>/index.html
  Preview:          file://<absolute-path>/index.html

Full pipeline:  research → synthesize → publish
═══════════════════════════════════════════
```

---

## Rules

1. **Sequential, not parallel.** Each step depends on the previous one's output. Run them in order.
2. **Gate between steps.** Always confirm with the user before moving to the next step. They may want to adjust the intermediate output.
3. **Pass context forward.** Each skill needs to know what the previous one produced. Reference specific file paths.
4. **Don't re-ask what's been answered.** If the user already scoped the topic in Step 1, don't ask again in Steps 2 or 3.
5. **Save everything in the lit review directory.** The synthesized doc and webpage should live alongside the research:
   ```
   ~/lit-reviews/<slug>/
   ├── sources/
   ├── analysis/
   ├── presentation/
   ├── synthesis/
   │   └── synthesized-<slug>.md
   ├── webpage/
   │   └── index.html
   ├── summary.md
   └── sources.md
   ```
6. **The webpage is the deliverable.** The lit review and synthesis are intermediate steps. Focus polish effort on the final webpage.
7. **Respect all child skill rules.** Each delegated skill has its own rules — follow them.
