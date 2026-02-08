# Professor Claude — Teach a Concept with Interactive Material

Split-screen teaching: interactive material in the right pane (PhET sim, Brilliant game, website), Claude Code as the teacher in the left pane. Learn the concept by playing with the material, plan a lesson around ONE idea + ONE action, rehearse twice, then record the final take as a video.

## Arguments

`<concept or topic to teach>` — What to teach, and optionally what interactive material to use.

Examples:
- `/professorclaude wave interference using the PhET sim`
- `/professorclaude sorting algorithms using the Brilliant visualization`
- `/professorclaude gradient descent using the interactive demo on my site`
- `/professorclaude` — no args, look at what's already open in the right pane

If no arguments and no interactive material is detected, ask the user what they want to learn and what material to use.

---

## Pre-flight: Check the Right Pane

**This must happen FIRST. Do not proceed without interactive material.**

1. Call `mcp__claude-in-chrome__tabs_context_mcp` to see what tabs are open
2. Take a screenshot of the current browser state
3. Check: is there interactive material open?
   - A PhET simulation
   - A Brilliant lesson/game
   - An interactive webpage with controls, sliders, visualizations
   - Any educational interactive content

**If NO interactive material is found:**

Stop and tell the user:

> "I don't see interactive material open in Chrome. Please open the simulation, game, or interactive page you want me to teach with, then run `/professorclaude` again."
>
> "Examples of what to open:"
> - "A PhET sim (phet.colorado.edu)"
> - "A Brilliant lesson (brilliant.org)"
> - "An interactive demo on your website"
> - "Any webpage with interactive educational content"

Do not proceed until interactive material is confirmed.

**If interactive material IS found:**

> "I can see [description of what's open]. I'll use this to teach [concept]. Let me start by exploring it myself."

---

## Take 1: Exploration (Learning Phase)

**Goal:** Understand the interactive material deeply. Prove you get it.

### 1a. Survey the Interface

1. Take a screenshot of the full interactive material
2. Identify all interactive elements:
   - Sliders, toggles, buttons, dropdowns
   - Draggable objects
   - Input fields
   - Play/pause/reset controls
   - Visualization areas (graphs, animations, canvases)
3. Read any visible instructions, labels, titles, or tooltips
4. Note the current state (what's shown, default settings)

### 1b. Play and Experiment

Systematically interact with the material:

1. **Explore controls one at a time** — change one slider/toggle, observe what happens
2. **Test extremes** — what happens at min/max values?
3. **Look for cause and effect** — which input changes which output?
4. **Find the key relationship** — what's the ONE core concept this material demonstrates?
5. **Scroll the page** if needed to find additional content, instructions, or context

Take screenshots at key moments to document what you're learning.

### 1c. Demonstrate Understanding

Prove you understand by performing a **deliberate, meaningful interaction**:

- If it's a simulation: set it up to clearly show the concept (e.g., constructive interference by aligning two waves)
- If it's a game: complete the objective or solve the puzzle
- If it's a visualization: configure it to reveal the key insight

Take a screenshot of this "understanding moment."

Print to the terminal:

```
════════════════════════════════════════════
EXPLORATION COMPLETE
════════════════════════════════════════════
Material:    <what it is>
Concept:     <the core concept>
Key insight: <one sentence — the "aha" moment>
Controls:    <what levers the user can pull>
Sweet spot:  <the configuration that best shows the concept>
════════════════════════════════════════════
```

---

## Planning: The Lesson Script

Create: `~/professorclaude/<slug>/lesson-plan.md`

This is the most important step. Think deeply.

### The ONE Idea, ONE Action Principle

The lesson teaches **ONE concept** through **ONE visual action**. Not three things. Not a survey. One.

- **ONE idea:** a single sentence the student should walk away understanding
- **ONE action:** a single interaction with the material that makes that idea visually obvious

Examples:
- **Idea:** "Constructive interference happens when wave peaks align"
- **Action:** Drag the phase slider until two waves perfectly overlap → amplitude doubles

- **Idea:** "Binary search is O(log n) because it halves the search space each step"
- **Action:** Click through a sorted array search, watching the highlighted region shrink by half each time

- **Idea:** "Gradient descent follows the steepest downhill direction"
- **Action:** Click on the loss surface to place a starting point, watch the optimizer roll downhill

### Lesson Plan Structure

```markdown
# Lesson Plan: <Concept>

## The ONE Idea
<One sentence. This is what the student learns.>

## The ONE Action
<One interaction. This is what makes it click visually.>

## Setup State
<What the interactive material should look like BEFORE the action.
 Describe exact slider positions, toggle states, initial configuration.>

## The Action Sequence
<Step-by-step what happens on screen during the teaching moment.
 Be precise — this becomes the video choreography.>

1. [SHOW] <what's visible on screen>
   [SAY]  <text to display in terminal / render in video>

2. [SHOW] <next visual state>
   [SAY]  <corresponding explanation>

3. [SHOW] <the key moment — the action>
   [SAY]  <the punchline — the ONE idea>

4. [SHOW] <the result — what changed>
   [SAY]  <why this matters>

## Terminal Script
<The exact text you'll print in the terminal during the teaching.
 Each line is timed to match a visual action.
 Keep it SHORT — big text in video means few words per screen.>

Line 1: "<setup context — 5-8 words>"
Line 2: "<what to watch for — 5-8 words>"
Line 3: "<the action description — 5-8 words>"
Line 4: "<the insight / punchline — 5-8 words>"

## Video Plan
- Duration: <target seconds, keep it SHORT — 15-45s>
- Format: split screen (terminal left, interactive right)
- Text overlay: terminal text rendered large by ffmpeg
- Key frame: <the exact moment that captures the concept>
```

**Gate:** Show the lesson plan to the user:

> "Here's my lesson plan. ONE idea: '<idea>'. ONE action: '<action>'. Does this capture what you want to teach?"

Wait for approval before rehearsing.

---

## Take 2: First Rehearsal

Run through the full lesson WITHOUT recording.

### 2a. Reset the Material

Set the interactive material back to the planned "Setup State":
- Reset sliders, toggles, positions
- Clear any previous interactions
- Verify it matches the lesson plan's starting configuration

### 2b. Execute the Lesson

Walk through the Action Sequence from the lesson plan:

1. Print each terminal line at the planned moment
2. Perform the corresponding interaction in the right pane
3. Pause between steps — give the "student" time to read

### 2c. Self-Critique

After the run-through, evaluate:

```
════════════════════════════════════════════
TAKE 2 — SELF-CRITIQUE
════════════════════════════════════════════
Timing:      <too fast / too slow / right>
Terminal:    <text clear? too long? too short?>
Action:      <did the interaction clearly show the concept?>
Sync:        <did text and action line up?>
Adjustments: <what to fix for Take 3>
════════════════════════════════════════════
```

Update the lesson plan if needed.

---

## Take 3: Final Rehearsal

Run through again with any adjustments from Take 2.

Same process:
1. Reset material to setup state
2. Execute the full lesson sequence
3. Verify timing, clarity, and sync

After Take 3, confirm with the user:

> "Take 3 complete. I'm ready to record the final take. The recording will capture both panes — my terminal text on the left, the interactive material on the right. Ready?"

**Gate:** Wait for user confirmation before recording.

---

## Final Take: Record the Video

### Option A: GIF Recording (Quick)

Use `mcp__claude-in-chrome__gif_creator`:

1. Start recording: `gif_creator` action `start_recording`
2. Take a screenshot to capture initial state
3. Execute the full lesson sequence (terminal text + interactions)
4. Take a screenshot to capture final state
5. Stop recording: `gif_creator` action `stop_recording`
6. Export: `gif_creator` action `export` with descriptive filename

### Option B: Full Video with ffmpeg (Polished)

If a higher quality video is needed:

1. Use the GIF recording to capture the screen interaction
2. Extract the terminal text lines from the lesson plan
3. Use ffmpeg to:
   - Take the screen recording as base
   - Overlay large, readable text at planned timestamps
   - Add fade in/out
   - Add title card at start: "<Concept> — Taught by Professor Claude"
   - Add end card: "ONE idea: <the idea>"

```bash
# Add text overlay at specific timestamps
ffmpeg -i recording.gif -vf "\
  drawtext=text='<Line 1>':fontsize=48:fontcolor=white:borderw=3:bordercolor=black:\
    x=(w-text_w)/2:y=h-80:enable='between(t,0,4)',\
  drawtext=text='<Line 2>':fontsize=48:fontcolor=white:borderw=3:bordercolor=black:\
    x=(w-text_w)/2:y=h-80:enable='between(t,4,8)',\
  drawtext=text='<Line 3>':fontsize=48:fontcolor=white:borderw=3:bordercolor=black:\
    x=(w-text_w)/2:y=h-80:enable='between(t,8,12)',\
  drawtext=text='<Line 4>':fontsize=60:fontcolor=yellow:borderw=3:bordercolor=black:\
    x=(w-text_w)/2:y=h-80:enable='between(t,12,16)'\
" -c:a copy output.mp4
```

The punchline line (Line 4) is larger and yellow to emphasize it.

---

## Output Organization

```
~/professorclaude/<slug>/
├── lesson-plan.md               ← the teaching script
├── exploration/
│   ├── screenshot-initial.png   ← what the material looks like
│   ├── screenshot-insight.png   ← the "understanding moment"
│   └── notes.md                 ← exploration observations
├── video/
│   ├── recording.gif            ← raw screen recording
│   └── professor-claude-<slug>.mp4  ← final polished video (if ffmpeg used)
└── README.md
```

---

## Final Report

```
Professor Claude — Lesson Complete
═══════════════════════════════════════════
Concept:        <what was taught>
Material:       <what interactive content was used>
ONE Idea:       <the single takeaway>
ONE Action:     <the single interaction>

Takes:
  Take 1:       Exploration — learned the material
  Take 2:       First rehearsal — identified timing issues
  Take 3:       Final rehearsal — ready to record
  Final:        Recorded

Output:         ~/professorclaude/<slug>/
Video:          <path to final video>
Lesson plan:    <path to lesson-plan.md>
═══════════════════════════════════════════
```

---

## Rules

1. **Check the right pane FIRST.** Never proceed without interactive material. If nothing is open, stop and tell the user.
2. **ONE idea, ONE action.** This is the core constraint. Resist the urge to teach three things. One concept, one visual demonstration.
3. **Learn before teaching.** Take 1 is real exploration. Don't fake understanding — actually interact with the material and figure out what it does.
4. **Terminal text is short.** 5-8 words per line. This text will be rendered large in the video. Long sentences become unreadable.
5. **Three takes minimum.** Take 1 (explore), Take 2 (rehearse), Take 3 (final rehearse), then record. Don't skip rehearsals.
6. **Gate before recording.** Always get user approval of the lesson plan AND confirmation before the final recorded take.
7. **Sync text and action.** The terminal text and the visual interaction must happen at the same moment. If they drift, the lesson fails.
8. **Keep it short.** 15-45 seconds for the final video. Longer is not better. The student should get the ONE idea in under a minute.
9. **Show, don't tell.** The interactive material does the heavy lifting. Your terminal text is the caption, not the content.
10. **Be honest about failures.** If the material doesn't clearly demonstrate the concept, say so. Not every sim/game is a good teaching tool for every idea.
