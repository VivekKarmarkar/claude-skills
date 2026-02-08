# Architectural Walkthrough Video — From System Design to Polished Video

Take a system architecture, turn it into an interactive visual, record a walkthrough video with Remotion, add a chill instrumental track via Suno, and package it all with ffmpeg into a short, sweet architectural explainer.

## Arguments

`<system, codebase, or architecture description>` — What architecture to walk through.

Examples:
- `/architectural-walkthrough-video the microservices architecture of this project`
- `/architectural-walkthrough-video how our auth flow works end-to-end`
- `/architectural-walkthrough-video the data pipeline from ingestion to dashboard`
- `/architectural-walkthrough-video` — no args, infer from current codebase and conversation

If no arguments, look at the current conversation and codebase for architecture context. If nothing obvious, ask the user what system they want to walk through.

---

## Pipeline

Five steps in sequence. Each feeds the next.

### Step 1: Interactive Architecture Diagram (`/playground`)

Run the `/playground` skill to create an interactive system architecture explorer.

Tell `/playground`:
- **Topic:** the system architecture from the user's arguments / codebase
- **What to build:** An interactive architecture diagram where users can click on components to see details, hover for connections, toggle layers (frontend/backend/infra), and trace data flows with animations
- **Key elements:**
  - System components as clickable nodes (services, databases, queues, APIs, clients)
  - Connections with labeled arrows showing data flow direction
  - Color-coded layers (e.g., blue for frontend, green for backend, orange for infra, purple for external)
  - Click a component → sidebar panel shows: name, responsibility, tech stack, connections
  - Animated data flow traces — click a flow path to see data move through the system
  - Legend explaining colors and symbols
- **Style:** dark background, neon/bright accents on nodes, clean lines — looks good on video

**Gate:** Wait for `/playground` to finish and the user to approve the interactive diagram.

> "Interactive architecture diagram ready. Preview it in Chrome and let me know if you want changes before we record the video."

Proceed only after user confirmation.

### Step 2: Walkthrough Video with Remotion (`/remotion`)

Run the Remotion skill to create an animated walkthrough video from the architecture.

The video should be a **scripted tour** of the architecture, not just a screen recording. Plan the sequence:

1. **Intro (3-5s)** — Title card: system name, "Architecture Walkthrough"
2. **Big picture (5-8s)** — Full architecture diagram fades in, all components visible
3. **Component spotlight (3-5s each)** — Camera zooms into each major component one at a time, with a text label explaining what it does
4. **Data flow trace (5-10s)** — Animated path showing a request flowing through the system end-to-end (e.g., "User request → API Gateway → Auth Service → Database → Response")
5. **Layer breakdown (5-8s)** — Toggle layers on/off to show frontend, backend, infra separately
6. **Outro (3-5s)** — Full diagram again, fade out

Target duration: **30-60 seconds total.** Short and sweet.

Use content from the playground HTML as visual source material — extract the component data, positions, and connections to drive the Remotion composition.

**Gate:** Wait for Remotion to render the video. Confirm with the user:

> "Walkthrough video rendered (Xs). Ready to create the background music?"

Proceed only after user confirmation.

### Step 3: Background Music (`/makesong`)

Run the `/makesong` skill to generate a chill instrumental track.

Tell `/makesong`:
- **Style:** chill lo-fi instrumental, light electronic, ambient tech vibes
- **Mood:** calm, professional, slightly futuristic — think "developer conference background music"
- **Duration:** match the video length (30-60 seconds)
- **No vocals.** Pure instrumental.
- **Prompt suggestion:** "chill lo-fi instrumental, soft synth pads, light electronic beats, ambient tech, clean and minimal, 45 seconds"

Download the generated track from Suno.

**Gate:** Confirm with the user:

> "Background track ready. Listen to it and let me know if you want a different vibe before I package the final video."

Proceed only after user confirmation.

### Step 4: Package with ffmpeg

Use ffmpeg to combine the video and audio into a polished final product.

#### 4a. Combine video + audio

```bash
ffmpeg -i <video.mp4> -i <music.mp3> \
  -filter_complex "[1:a]afade=t=in:st=0:d=2,afade=t=out:st=<end-2>:d=2,volume=0.3[music]; \
  [music]apad[apadded]; [apadded]atrim=0:<video-duration>[trimmed]" \
  -map 0:v -map "[trimmed]" \
  -c:v copy -c:a aac -shortest \
  <output-combined.mp4>
```

Key audio touches:
- **Fade in** music over first 2 seconds
- **Fade out** music over last 2 seconds
- **Volume at 30%** — background, not foreground
- **Trim** music to match video length

#### 4b. Add video polish

```bash
ffmpeg -i <output-combined.mp4> \
  -vf "fade=t=in:st=0:d=1,fade=t=out:st=<end-1>:d=1" \
  -c:v libx264 -preset slow -crf 18 \
  -c:a copy \
  <final-output.mp4>
```

Video touches:
- **Fade in** from black over first 1 second
- **Fade out** to black over last 1 second
- **High quality encoding** — CRF 18, slow preset

#### 4c. Generate thumbnail

```bash
ffmpeg -i <final-output.mp4> -ss 5 -frames:v 1 \
  -vf "scale=1280:720" \
  <thumbnail.png>
```

Grab a frame from the 5-second mark (should be the full architecture view) as a thumbnail.

### Step 5: Organize Output

Save everything together:

```
~/videos/architectural-walkthrough-<slug>/
├── playground/
│   └── index.html              ← interactive architecture diagram
├── remotion/
│   └── walkthrough-raw.mp4     ← raw Remotion video (no audio)
├── music/
│   └── background-track.mp3    ← Suno instrumental
├── final/
│   ├── architectural-walkthrough-<slug>.mp4  ← THE DELIVERABLE
│   └── thumbnail.png           ← video thumbnail
└── README.md                   ← what this is, how it was made
```

---

## Final Report

```
Architectural Walkthrough Video Complete
═══════════════════════════════════════════
Architecture:       <system name>

Step 1 — Playground:     Interactive diagram created
Step 2 — Remotion:       Walkthrough video rendered (Xs)
Step 3 — Suno:           Background track generated
Step 4 — ffmpeg:         Video + audio packaged with fades
Step 5 — Output:         Organized and ready

Final video:    ~/videos/architectural-walkthrough-<slug>/final/<filename>.mp4
Duration:       Xs
Resolution:     1920x1080
File size:      ~X MB

Interactive:    ~/videos/architectural-walkthrough-<slug>/playground/index.html
Thumbnail:      ~/videos/architectural-walkthrough-<slug>/final/thumbnail.png
═══════════════════════════════════════════
```

---

## Rules

1. **Sequential, not parallel.** Each step depends on the previous one. Run in order.
2. **Gate between steps.** Always confirm with the user before moving on. They may want to tweak the diagram, re-record, or pick a different music vibe.
3. **Short and sweet.** Target 30-60 seconds. This is an overview, not a deep dive. Every second should earn its place.
4. **Music is background.** Volume at 30% max. The architecture is the star, not the beat.
5. **Dark theme for video.** Dark backgrounds with bright accents look best on video and in thumbnails.
6. **Don't re-ask what's been answered.** If the user scoped the architecture in Step 1, carry that context through all steps.
7. **ffmpeg must be installed.** Check with `ffmpeg -version` before Step 4. If missing, tell the user to install it.
8. **Respect all child skill rules.** Each delegated skill has its own rules — follow them.
9. **The final .mp4 is the deliverable.** Everything else is intermediate. Make sure the final video is polished.
