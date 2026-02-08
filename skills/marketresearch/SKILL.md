# Market Research — Research, Organize, Present

Conduct a thorough market research report: find industry data, analyze competitors, map market dynamics, organize everything locally, and produce a polished presentation.

## Arguments

`<market, industry, or product area>` — What the market research is about.

Examples:
- `/marketresearch AI-powered diagnostic tools in radiology`
- `/marketresearch direct-to-consumer meal kit delivery in the US`
- `/marketresearch electric vehicle charging infrastructure in India`

If no arguments, ask the user for their research focus, scope, and any constraints (geography, market segment, timeframe).

## Pre-flight Check

1. Call `mcp__claude-in-chrome__tabs_context_mcp` to verify Chrome MCP is connected. If not, stop and tell the user to connect it — Chrome is needed for data-heavy sites and Napkin AI.
2. Confirm the user's home directory is accessible for saving files.

---

## Phase 1: Scope the Research

Before searching, clarify with the user:

1. **Market focus** — What specific market, product category, or industry?
2. **Depth** — Quick landscape (5-10 sources) or deep dive (20-30 sources)?
3. **Geography** — Global, specific region, or specific country?
4. **Timeframe** — Current snapshot? Or trend analysis over N years?
5. **Angle** — Are you evaluating an opportunity, sizing a market, analyzing competitors, or something else?
6. **Audience** — Who is this for? (investors, internal strategy, academic, personal)

Use answers to guide search strategy.

---

## Phase 2: Search for Sources

Use multiple sources in parallel to build a comprehensive picture.

### Source 1: Industry Reports & Market Data

Use `WebSearch` with targeted queries:
- `"<market>" market size 2024 2025 2026`
- `"<market>" industry report OR market analysis`
- `"<market>" TAM SAM SOM`
- `"<market>" CAGR growth forecast`
- `"<market>" market share leaders`
- `site:statista.com "<market>"`
- `site:grandviewresearch.com OR site:marketsandmarkets.com "<market>"`

Extract: report title, publisher, date, key data points, URL.

### Source 2: Competitor Intelligence

Use `WebSearch` to find:
- `"<market>" top companies OR key players OR market leaders`
- `"<market>" competitive landscape`
- Individual company searches: funding, revenue, headcount, product launches
- Crunchbase, PitchBook mentions for startups
- Public company filings (10-K, earnings calls) for established players

### Source 3: News & Trends

Use `WebSearch` for recent developments:
- `"<market>" news 2025 2026`
- `"<market>" trends OR emerging OR disruption`
- `"<market>" regulation OR policy`
- `"<market>" investment OR funding OR acquisition`

### Source 4: Chrome Deep Dives

Use Chrome automation for sites that need interaction:
- Navigate to relevant industry databases, trade publications, or data portals
- Read market overview pages, extract data tables
- Take snapshots of key charts and data visualizations
- Check company "About" pages, press releases, investor relations

### Source 5: Academic & Technical (if relevant)

If the market has a strong technical dimension:
- Use PubMed MCP tools for biomedical/healthtech markets
- Use `WebSearch` with `site:arxiv.org` for tech markets
- Look for technical white papers, patent filings

### Compile the Master Source List

Create a deduplicated list of all sources, categorized:

```
Found N sources across M categories:

Industry Reports (N):
  - <title> — <publisher> (<year>) — <key stat>

Competitor Profiles (N):
  - <company> — <brief description> — <key metric>

News & Trends (N):
  - <headline> — <source> (<date>)

Academic/Technical (N):
  - <title> — <authors> (<year>)
```

Present to the user. Ask: "Should I proceed with all of these, or focus on a subset?"

---

## Phase 3: Analyze and Synthesize

### 3a. Market Sizing

Compile available data into a market size picture:
- **TAM** (Total Addressable Market) — the full market opportunity
- **SAM** (Serviceable Addressable Market) — the segment you can reach
- **SOM** (Serviceable Obtainable Market) — realistic near-term capture
- **CAGR** — compound annual growth rate
- **Historical data points** — market size over past 3-5 years if available
- **Forecasts** — projected size for next 3-5 years

Note: clearly label which numbers come from which sources. Different reports often disagree — flag discrepancies.

### 3b. Competitive Landscape

For each major competitor, extract:
- **Company name & founding year**
- **Headquarters & geography**
- **Product/service offering** — what they sell
- **Business model** — how they make money
- **Revenue / funding** — if available
- **Market share** — if available
- **Differentiator** — what makes them unique
- **Weaknesses** — where they're vulnerable

Build a competitive matrix comparing key players across dimensions.

### 3c. Market Dynamics

Analyze:
- **Drivers** — what's fueling growth?
- **Barriers** — what's holding the market back?
- **Threats** — what could disrupt it?
- **Regulatory environment** — key regulations, pending legislation
- **Technology trends** — emerging tech that could reshape the market
- **Customer trends** — how buyer behavior is shifting

### 3d. SWOT / Porter's Five Forces (if relevant)

If the user is evaluating a specific opportunity:
- **SWOT** — Strengths, Weaknesses, Opportunities, Threats
- **Porter's Five Forces** — supplier power, buyer power, competitive rivalry, threat of substitution, threat of new entry

---

## Phase 4: Create Folder Structure

Create an organized directory structure:

```
~/market-research/<market-slug>/
├── sources/
│   ├── reports/
│   │   └── PublisherYear_ShortTitle.pdf
│   ├── competitors/
│   │   └── CompanyName_Profile.md
│   └── news/
│       └── YYYY-MM-DD_Headline.md
├── analysis/
│   ├── market-sizing.md
│   ├── competitive-landscape.md
│   ├── market-dynamics.md
│   └── swot.md (if applicable)
├── presentation/
│   └── market-research-<market-slug>.pptx
├── summary.md
└── sources.md
```

### Naming Convention

- **Folder name:** lowercase, hyphen-separated market slug (e.g., `ev-charging-india`)
- **Report PDFs:** `PublisherYear_ShortTitle.pdf` (e.g., `McKinsey2025_EVCharging.pdf`)
- **Competitor profiles:** `CompanyName_Profile.md`
- **News clips:** `YYYY-MM-DD_BriefHeadline.md`
- **No spaces in filenames.**

### Download Sources

For freely available reports and PDFs:
1. Ask user for permission before each download
2. Save to `sources/reports/` with proper naming

**Important:** Only download freely available content. Do not bypass paywalls. Note paywalled sources in `sources.md` with access instructions.

### Create Analysis Files

Write each analysis section as a standalone markdown file in `analysis/`:

**market-sizing.md:**
```markdown
# Market Sizing: <Market>

## TAM
<data with source citations>

## SAM
<data with source citations>

## SOM
<data with source citations>

## Growth Trajectory
| Year | Market Size | Source |
|------|------------|--------|
| 2022 | $X.XB      | <src>  |
| ...  | ...        | ...    |

## Forecasts
<projections with source citations>

## Notes on Data Quality
<discrepancies between sources, caveats>
```

**competitive-landscape.md:**
```markdown
# Competitive Landscape: <Market>

## Market Leaders
| Company | HQ | Revenue | Market Share | Key Product |
|---------|-----|---------|-------------|-------------|
| ...     | ... | ...     | ...         | ...         |

## Detailed Profiles
### <Company 1>
<profile>

### <Company 2>
<profile>

## Competitive Matrix
<comparison across key dimensions>
```

**market-dynamics.md:**
```markdown
# Market Dynamics: <Market>

## Growth Drivers
1. <driver with evidence>
2. ...

## Barriers
1. <barrier with evidence>
2. ...

## Regulatory Environment
<key regulations>

## Technology Trends
<emerging tech>

## Customer Trends
<shifting behaviors>
```

### Create summary.md

A narrative executive summary:

```markdown
# Market Research: <Market>

**Date:** <today>
**Sources reviewed:** N

## Executive Summary
<2-3 paragraph overview — the key takeaway>

## Market Overview
<size, growth, key players>

## Key Findings
1. <finding>
2. <finding>
3. <finding>

## Opportunities
<where the openings are>

## Risks
<what could go wrong>

## Recommendations
<what the user should consider doing>

## Sources
<reference to sources.md>
```

### Create sources.md

Full source list with access notes:

```markdown
# Sources

## Industry Reports
1. <Publisher>. (<Year>). *<Title>*. Retrieved from <URL>. [Open access / Paywalled]

## Company Sources
1. <Company> — <type of source> — <URL>

## News Articles
1. <Author>. (<Date>). "<Headline>". *<Publication>*. <URL>

## Academic
1. <Citation in APA>
```

---

## Phase 5: Create Presentation

Use the `/pptx` skill to create the market research deck.

Structure:

1. **Title slide** — Market, researcher name (ask user), date
2. **Executive Summary** — 3-5 bullet key takeaways
3. **Market Overview** — size, growth rate, geography
4. **Market Sizing** — TAM/SAM/SOM with data visualization notes
5. **Growth Drivers & Trends** — what's fueling the market
6. **Competitive Landscape** — key players, market share, competitive matrix
7. **Competitor Deep Dives** (1 slide per top 3-5 competitors)
8. **Market Dynamics** — drivers, barriers, regulatory
9. **SWOT / Porter's** (if applicable)
10. **Opportunities & Risks** — where to play, what to watch
11. **Recommendations** — actionable next steps
12. **Sources** — full reference list

Save to `presentation/market-research-<market-slug>.pptx`.

---

## Phase 6: Polish with Napkin AI

Use Chrome to polish the presentation slides:

1. Open a new Chrome tab
2. Navigate to `https://app.napkin.ai/page/create`
3. For each key content slide (especially market sizing, competitive landscape, dynamics, SWOT):
   - Paste the slide's text content into Napkin AI
   - Let Napkin generate visual representations (charts, comparisons, process flows)
   - Take a screenshot of the generated visual
   - Save the visual to `presentation/napkin-visuals/`
4. Report to the user which slides have Napkin visuals available, so they can manually insert their favorites into the PPTX.

**Note:** Napkin AI works best for: market size comparisons, competitive matrices, SWOT diagrams, trend timelines, process flows. Feed it structured data for best results.

---

## Final Report

```
Market Research Complete
═══════════════════════════════════════════
Market:          <market>
Sources found:   N
Sources used:    N
Reports downloaded: N (open access)

Created:
  ~/market-research/<market-slug>/
  ├── sources/         N reports, N profiles, N news
  ├── analysis/        market sizing, competitive, dynamics
  ├── presentation/    1 PPTX + N Napkin visuals
  ├── summary.md       Executive summary
  └── sources.md       Full source list

Presentation:    <path to pptx>
═══════════════════════════════════════════
```

---

## Rules

1. **Only use freely available data.** Never bypass paywalls. Note paywalled sources so the user can access them if they have subscriptions.
2. **Ask before every download.** Each PDF/report download needs explicit user permission.
3. **Cite everything.** Every number, claim, and data point must reference its source.
4. **Flag uncertainty.** If market size estimates vary between sources, show the range and explain why. Never present a single number as authoritative when sources disagree.
5. **Respect copyright.** Summarize in your own words. Short quotes only.
6. **No financial advice.** Present data and analysis. Never tell the user to invest, buy, or sell.
7. **Let the user steer.** Present source lists and analysis angles for approval — don't assume what's relevant.
8. **Save as you go.** Build the folder structure early and populate incrementally.
9. **Recency matters.** Prefer sources from the last 2 years. Flag older data clearly.
