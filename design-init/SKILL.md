---
name: design-init
description: One-time design context setup for a project. Interviews the user to capture strategic design intent, then writes .context/PRODUCT.md and optionally .context/DESIGN.md. Use before any design work (new project, or first time using design skills in an existing project). Not for backend-only projects.
---

# Design Init

Set up persistent design context for a project by interviewing the user and writing `.context/PRODUCT.md` (strategic) and optionally `.context/DESIGN.md` (visual). Every subsequent design skill reads these files instead of re-asking the same questions.

This is a one-time setup. Re-run only when the project's strategic direction changes significantly.

---

## Phase 1: Load Current State

Check what already exists. Read any present files:

```bash
ls -1 .context/ | grep -iE 'product|design'
```

Decision tree:
- **Neither exists**: proceed through all phases below.
- **PRODUCT.md exists, DESIGN.md missing**: read PRODUCT.md, skip to Phase 5 and offer DESIGN.md.
- **Both exist**: ask which to refresh. Skip the one the user doesn't want changed.
- **Just DESIGN.md exists (unusual)**: read it, then proceed to Phases 2–4 for PRODUCT.md.

Never silently overwrite. Always confirm first.

---

## Phase 2: Explore Codebase for Design Signals

Before asking questions, scan the project to discover what you can. This single crawl feeds everything below:

- **README and docs**: project purpose, target audience
- **Package.json / config files**: tech stack, existing design libraries (Tailwind, MUI, etc.)
- **Existing components**: current patterns, spacing, typography in use
- **Brand assets**: logos, favicons, color values already defined
- **Design tokens / CSS variables**: existing palettes, font stacks, spacing scales
- **Any style guides or brand documentation**

Form a **register hypothesis** from what you find:
- **Brand signals**: `/`, `/about`, `/pricing`, hero sections, big typography, landing-page content
- **Product signals**: `/app/*`, `/dashboard`, `/settings`, forms, data tables, app-shell components

Note what you've learned and what remains unclear.

---

## Phase 3: Interview

Ask the user about what you couldn't infer. Do not dump all questions at once — have a natural dialogue, 2–3 questions per round.

### Round 1: Register, Users, Purpose

**Register** (ask first; it shapes everything):

Every design task is either **brand** (marketing, landing, campaign, portfolio: design IS the product) or **product** (app UI, admin, dashboards, tools: design SERVES the product).

If Step 2 produced a clear hypothesis, lead with it: *"From the codebase, this looks like a [brand / product] surface. Does that match your intent?"*

If the signal is split (e.g. a product with a big marketing landing), ask which register describes the **primary** surface.

**Users & Purpose**:
- Who uses this? What's their context when using it?
- What job are they trying to get done?
- For brand: what emotions should the interface evoke?
- For product: what workflow are they in? What's the primary task?

### Round 2: Personality, References, Anti-References

- How would you describe the brand personality in 3 words?
- Reference sites or apps that capture the right feel? What specifically about them?
  - Push for **named references with specific details**, not generic adjectives.
- What should this explicitly NOT look like? Any anti-references?

### Round 3: Accessibility & Constraints

- Specific accessibility requirements? (WCAG level, known user needs)
- Considerations for reduced motion, color blindness, or other accommodations?
- Technical constraints? (framework, browser support, performance budget)

**Skip questions where the answer is already clear.** Do NOT ask about colors, fonts, radii, or visual styling here — those belong in DESIGN.md, not PRODUCT.md.

---

## Phase 4: Write PRODUCT.md

Write only after the user has confirmed the strategic answers. Synthesize into:

```markdown
# Product

## Register

[brand | product]

## Users
[Who they are, their context, the job to be done]

## Product Purpose
[What this product does, why it exists, what success looks like]

## Brand Personality
[Voice, tone, 3-word personality, emotional goals]

## Anti-references
[What this should NOT look like. Specific bad-example sites or patterns to avoid.]

## Design Principles
[3–5 strategic principles derived from the conversation. Principles like "practice what you preach", "show, don't tell", "expert confidence". NOT visual rules like "use OKLCH" or "magenta accent".]

## Accessibility & Inclusion
[WCAG level, known user needs, considerations]
```

Write to `.context/PRODUCT.md`.

---

## Phase 5: Decide on DESIGN.md

Offer to create DESIGN.md either way:

- **Code exists** (CSS tokens, components, a running site): *"I can generate a DESIGN.md that captures your visual system (colors, typography, components) so future design work stays on-brand. Want to do that now?"*
- **Pre-implementation** (empty project): *"I can seed a starter DESIGN.md from a few quick questions about color strategy, type direction, and motion energy. You can re-run once there's code to capture the real tokens. Want to do that now?"*

If the user agrees, proceed to Phase 6. If they skip, note they can re-run `design-init` later or use `/skill:design-brief` to set visual direction per feature.

---

## Phase 6: Write DESIGN.md

### If code exists (scan mode)

Read existing visual tokens, CSS, and representative components. Capture:

```markdown
# Design

## Color Palette
[Primary, secondary, background, surface, text, muted, accent. Include actual values.]

## Typography
[Font families, scale (modular or custom), weights, line heights, letter spacing.]

## Spacing System
[Base unit, scale steps, layout spacing tokens.]

## Component Patterns
[Buttons, inputs, cards, modals, navigation — describe the existing patterns.]

## Motion & Interaction
[Default easing, transition durations, hover/focus/active patterns.]

## Responsive Breakpoints
[Breakpoints in use, mobile-first or desktop-first.]

## Dark Mode
[Strategy: class-based, media-query, or none.]
```

### If pre-implementation (seed mode)

Ask 3–4 quick questions:
- Color strategy: Restrained / Committed / Full palette / Drenched?
- Type direction: serif + sans contrast? single family? mono usage?
- Motion energy: minimal / standard / expressive?
- Light or dark default? (or system-adaptive?)

Then seed a starter DESIGN.md with reasonable defaults based on the answers.

Write to `.context/DESIGN.md`.

---

## Phase 7: Wrap Up

Summarize tersely:
- Register captured (brand / product)
- What was written (PRODUCT.md, DESIGN.md, or both)
- The 3–5 strategic principles that will guide future work
- Recommended next command based on project state:
  - Empty/early project: `/skill:design-brief` for the first feature
  - Existing code: `/skill:design-audit` to assess current quality
  - Refining existing UI: `/skill:design-polish` on a specific component or page

---

## Rules

- Never silently overwrite existing PRODUCT.md or DESIGN.md. Always confirm first.
- Do NOT ask about visual styling (colors, fonts, radii) in the PRODUCT.md interview. Keep strategic.
- Assert-then-confirm, not menu-with-escape. When one option is obvious, name it and ask for confirmation.
- If both PRODUCT.md and DESIGN.md already exist and the user wants neither refreshed, exit cleanly.
- Create `.context/` if it does not exist.
- Cross-reference any existing `.context/` session files for project context before interviewing.
