# MathDer — Write a Mathematical Derivation

Write a clean, step-by-step mathematical derivation for a statement, theorem, identity, or concept. Output as a markdown file with proper LaTeX formatting. This is the proof sketch — rigorous enough to follow, concise enough to be useful.

## Arguments

`<mathematical statement or concept>` — What to derive.

Examples:
- `/mathder the Euler-Lagrange equation from the calculus of variations`
- `/mathder why the determinant of a product equals the product of determinants`
- `/mathder the gradient of the cross-entropy loss function`
- `/mathder Bayes' theorem from the definition of conditional probability`
- `/mathder the closed-form solution to the ordinary least squares estimator`
- `/mathder the Fourier transform of a Gaussian is a Gaussian`
- `/mathder the spectral theorem for symmetric matrices`

If no arguments, ask the user what they want derived.

---

## Step 1: Understand the Statement

Before writing anything:

1. **State the result precisely** — What exactly are we deriving? Write the theorem/identity/formula.
2. **Identify prerequisites** — What does the reader need to know? (definitions, prior results, notation)
3. **Choose the approach** — There may be multiple proof strategies. Pick the most illuminating one, not necessarily the shortest. If multiple approaches exist and the choice matters, briefly mention alternatives.
4. **Scope** — This is a derivation sketch, not a textbook chapter. Hit every essential step, skip routine algebra the reader can fill in.

---

## Step 2: Write the Derivation

Create: `~/mathder/<slug>.md`

### Document Structure

```markdown
# <Result Name>

## Statement

$$
<precise mathematical statement in LaTeX>
$$

<One sentence in plain English saying what this means.>

## Setup

<Define notation, state assumptions, recall any prerequisite results needed.>

**Notation:**
- $X$ — <what X is>
- $f: A \to B$ — <what the function is>

**Assumptions:**
- <assumption 1>
- <assumption 2>

**Prerequisites:**
- <any prior result we'll invoke, stated briefly>

## Derivation

<Step-by-step derivation. Each step should be a logical unit.>

**Step 1: <descriptive name>**

<Motivation — why are we doing this step?>

$$
<math>
$$

<Justification — what rule/identity/theorem did we use?>

**Step 2: <descriptive name>**

...

**Step N: <descriptive name>**

$$
\boxed{<final result>}
$$

## Key Insights

- <What's the core trick or idea that makes this work?>
- <What's the geometric/physical/probabilistic intuition?>
- <Where does this break down — what assumptions are load-bearing?>

## Related

- <Pointers to generalizations, special cases, or related results>
```

### LaTeX Formatting Rules

- **Display math** for important equations: `$$ ... $$`
- **Inline math** for variables and short expressions: `$x$`, `$f(x)$`
- **Aligned equations** for multi-step manipulations:
  ```
  $$
  \begin{aligned}
  f(x) &= \int_0^x g(t) \, dt \\
        &= G(x) - G(0) \\
        &= G(x)
  \end{aligned}
  $$
  ```
- **Boxed final result**: `$$\boxed{...}$$`
- **Named theorems/lemmas** in bold: **Theorem (Cauchy-Schwarz).**
- **QED or conclusion marker**: end the derivation with $\blacksquare$ or a clear concluding sentence
- Use `\text{}` for words inside math: `$\text{Var}(X)$`
- Use `\operatorname{}` for custom operators: `$\operatorname{tr}(A)$`
- Proper differentials: `\, dx` not `dx` (thin space before)
- Proper fractions: `\frac{a}{b}` for display, `a/b` for inline when readability is better

### Writing Style

- **Every step earns its place.** If a step is routine algebra, say "expanding and simplifying" rather than showing every term.
- **Motivate before computing.** Before each major step, one sentence on *why* we're doing it.
- **Justify after computing.** After each step, note what rule was applied (chain rule, linearity, Fubini, etc.).
- **Plain English between equations.** The derivation should read as a narrative, not just a stack of equations.
- **Flag the clever parts.** If there's a non-obvious trick (substitution, change of variables, clever grouping), call it out explicitly.
- **Be honest about gaps.** If you're skipping a technical detail (e.g., "assuming we can exchange limit and integral"), say so.

---

## Step 3: Review

Read through the derivation and check:

1. **Logical flow** — Does each step follow from the previous one?
2. **No gaps** — Is there a step where the reader would be lost?
3. **LaTeX renders** — Are all equations properly formatted? Matched delimiters? No broken syntax?
4. **Notation consistency** — Is the same symbol used for the same thing throughout?
5. **Boxed result** — Is the final answer clearly marked?
6. **Readable** — Could someone with the stated prerequisites follow this in one sitting?

---

## Final Report

```
Derivation Complete
═══════════════════════════════════════════
Result:     <what was derived>
Approach:   <proof strategy used>
Steps:      N major steps
File:       ~/mathder/<slug>.md

Prerequisites: <what the reader needs to know>
Key insight:   <the core idea in one sentence>
═══════════════════════════════════════════
```

---

## Rules

1. **Precision matters.** State assumptions explicitly. Don't hand-wave where it changes the result.
2. **Sketch, not textbook.** Hit every essential step but skip routine computation. The reader can multiply matrices on their own.
3. **LaTeX must be correct.** Broken math formatting defeats the entire purpose. Double-check delimiters, alignment environments, and escaping.
4. **Motivate and justify.** Every major step gets a "why we do this" before and a "what we used" after.
5. **One file, one derivation.** Keep it focused. If the user wants multiple derivations, run the skill multiple times.
6. **Box the final result.** The reader should be able to find the punchline instantly.
7. **Honesty about rigor.** If a step requires heavy technical machinery you're glossing over (measure theory, functional analysis), say so. Don't pretend a sketch is a complete proof.
8. **Consistent notation.** Define everything once in Setup, use it the same way throughout.
