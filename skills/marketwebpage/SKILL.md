# Market Webpage — Market Research to Polished Webpage

Run a full pipeline: research a market, synthesize the findings, and publish as a beautiful interactive webpage.

## Arguments

`<market, industry, or product area>` — What to research and turn into a webpage.

Examples:
- `/marketwebpage AI-powered diagnostic tools in radiology`
- `/marketwebpage direct-to-consumer meal kit delivery in the US`
- `/marketwebpage electric vehicle charging infrastructure in India`

If no arguments, ask the user for the market/industry focus.

---

## Pipeline

This skill chains three skills in sequence. The output of each step feeds the next.

### Step 1: Market Research (`/marketresearch`)

Run the `/marketresearch` skill with the user's topic.

This will:
- Scope the research with the user
- Search for industry reports, competitor data, news, and trends
- Analyze market sizing (TAM/SAM/SOM), competitive landscape, and dynamics
- Organize everything into `~/market-research/<market-slug>/`
- Create analysis files, a summary, and a presentation

**Gate:** Wait for `/marketresearch` to complete. Confirm with the user:

> "Market research complete. N sources found, organized at `~/market-research/<slug>/`. Ready to synthesize into a single document?"

Proceed only after user confirmation.

### Step 2: Synthesize (`/synthesize`)

Run the `/synthesize` skill on the market research outputs.

Feed it the key files from Step 1:
- `~/market-research/<slug>/summary.md`
- `~/market-research/<slug>/analysis/*.md` (all analysis files — market-sizing, competitive-landscape, market-dynamics, swot)
- `~/market-research/<slug>/sources.md`

Tell `/synthesize` the purpose: "Synthesize these market research materials into a single cohesive markdown document suitable for converting into a webpage."

The output format should be **markdown** — this becomes the content source for the webpage.

**Gate:** Wait for `/synthesize` to complete. Confirm with the user:

> "Synthesis complete. Output at `<path>`. Ready to build the webpage?"

Proceed only after user confirmation.

### Step 3: Make Webpage (`/makewebpage`)

Run the `/makewebpage` skill using the synthesized document as the content source.

Tell `/makewebpage`:
- **Source:** the synthesized markdown from Step 2
- **Type:** dashboard / data page with article sections
- **Style:** clean, professional, data-forward — clear hierarchy, bold key metrics
- **Features to include:**
  - Sticky sidebar with section navigation
  - Key metrics row at top (big numbers — TAM, CAGR, market leaders)
  - Market sizing section with data tables
  - Competitive landscape as styled cards or comparison table
  - Growth drivers and barriers in callout boxes
  - SWOT or Porter's as a visual grid (if applicable)
  - Citation references (linked footnotes or inline citations)
  - Charts via Chart.js where data supports it (market size over time, market share breakdown)
  - Back-to-top button
  - Responsive — works on mobile
  - Dark mode toggle

**Gate:** `/makewebpage` will preview in Chrome and iterate with the user.

---

## Final Report

```
Market Webpage Pipeline Complete
═══════════════════════════════════════════
Market:             <market/industry>

Step 1 — Market Research:
  Sources found:    N
  Competitors:      N profiled
  Output:           ~/market-research/<slug>/

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
4. **Don't re-ask what's been answered.** If the user already scoped the market in Step 1, don't ask again in Steps 2 or 3.
5. **Save everything in the market research directory.** The synthesized doc and webpage should live alongside the research:
   ```
   ~/market-research/<slug>/
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
6. **The webpage is the deliverable.** The market research and synthesis are intermediate steps. Focus polish effort on the final webpage.
7. **Data visualization matters.** Market research is numbers-heavy. Push `/makewebpage` to use Chart.js for market size trends, pie charts for market share, and styled tables for competitor comparisons. A wall of text defeats the purpose.
8. **Respect all child skill rules.** Each delegated skill has its own rules — follow them.
