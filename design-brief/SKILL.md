---
name: design-brief
description: UX and visual planning for a frontend feature before any code is written. Produces a structured design brief that guides implementation. Use for any new UI surface, component, page, or significant visual redesign. Does not write code — only plans. Complements plan-then-build (which handles architecture and data flow).
---

# Design Brief

Shape the UX and visual direction for a feature before any code is written. This produces a **design brief**: a structured artifact that guides implementation through discovery, not guesswork.

This skill does NOT write code. It produces the thinking that makes code good.

**Prerequisites:** Read `.context/PRODUCT.md` and `.context/DESIGN.md` if they exist. If `PRODUCT.md` is missing, suggest running `/skill:design-init` first.

---

## Phase 1: Discovery Interview

**Do NOT write any code or make any design decisions during this phase.** Your only job is to understand the feature deeply enough to make excellent design decisions later.

Have a natural dialogue. Ask 2–3 questions per round, then wait for answers. Treat PRODUCT.md and DESIGN.md as anchors — they reduce repeated questions but do not replace per-feature discovery.

### Round 1: Purpose, Audience, Content

- What is this feature for? What problem does it solve?
- Who specifically will use it? (role, context, frequency)
- What does success look like?
- What's the user's state of mind? (rushed? exploring? anxious? focused?)
- What content or data does this feature display or collect?
- What are the realistic ranges? (minimum, typical, maximum)
- What are the edge cases? (empty, error, first-time, power user)

### Round 2: Design Direction

Force a visual decision on three fronts. Skip anything PRODUCT.md or DESIGN.md already answers.

- **Color strategy for this surface.** Pick one: Restrained / Committed / Full palette / Drenched. Can override the project default if the surface earns it.
- **Theme via scene sentence.** Write one sentence of physical context: who uses it, where, under what ambient light, in what mood. The sentence forces dark vs light.
- **Two or three named anchor references.** Specific products, brands, objects. Not adjectives like "modern" or "clean."

### Round 3: Scope & Constraints

- **Fidelity.** Sketch / mid-fi / high-fi / production-ready?
- **Breadth.** One screen / a flow / a whole surface?
- **Interactivity.** Static visual / interactive prototype / shipped-quality component?
- **Technical constraints?** (framework, performance budget, browser support)
- **Accessibility requirements beyond the project baseline?**

### Anti-Goals

- What should this NOT be? What would be a wrong direction?
- What's the biggest risk of getting this wrong?

---

## Phase 2: Design Brief

After the interview, present a brief and **end your response**. The user must confirm before any implementation runs.

**Choose the brief shape:**

- **Compact form (3–5 bullets)** when discovery was crisp and PRODUCT.md/DESIGN.md already pinned scope. State what you're building, the visual lane, and end with "confirm or override?"
- **Full structured form** when the task is genuinely ambiguous, multi-screen, or when the user asked for a standalone design plan.

Don't pad a clear brief into a long one. Don't skip the confirmation pause.

### Full Brief Structure

**1. Feature Summary** (2–3 sentences)
What this is, who it's for, what it needs to accomplish.

**2. Primary User Action**
The single most important thing a user should do or understand here.

**3. Design Direction**
Color strategy + theme scene sentence + 2–3 named anchor references. Reference PRODUCT.md and DESIGN.md where they already answer, and note any per-surface overrides.

**4. Scope**
Fidelity, breadth, interactivity, and time intent. Task-scoped; these don't persist beyond the brief.

**5. Layout Strategy**
High-level spatial approach: what gets emphasis, what's secondary, how information flows. Describe visual hierarchy and rhythm, not specific CSS.

**6. Key States**
List every state: default, empty, loading, error, success, edge cases. For each, note what the user needs to see and feel.

**7. Interaction Model**
How users interact: click, hover, scroll, flow from entry to completion. What feedback do they get?

**8. Content Requirements**
What copy, labels, empty state messages, error messages, and microcopy are needed. Note dynamic content ranges.

**9. Recommended References**
Which design-craft reference sections would be most valuable during implementation (e.g. layout.md for complex layouts, animate.md for animated features, interaction-design.md for form-heavy features).

**10. Open Questions**
Anything genuinely unresolved. Don't list "open questions" you've already recommended a default for — assert the default and move on.

---

## Phase 3: Confirmation

Present the brief, then **stop and wait for explicit confirmation**.

> "This is the design brief. Do not proceed until you confirm. Say 'go' or 'approved' when you're ready, or tell me what to adjust."

If the user disagrees with any part, revisit the relevant discovery questions. A brief is incomplete until confirmed.

Once confirmed, the brief is ready. The user can now hand it to any implementation skill (e.g. `/skill:plan-then-build` for the functional layer, then code).

---

## Rules

- Never write code during this skill. Only read, discuss, and plan.
- Never proceed without explicit user confirmation of the brief.
- Always read PRODUCT.md and DESIGN.md first if they exist.
- If PRODUCT.md is missing, suggest `/skill:design-init` before continuing.
- If DESIGN.md is missing but PRODUCT.md exists, proceed with the interview — you'll infer visual defaults from the user's answers.
- Create `.context/` if it does not exist. Consider saving the confirmed brief to `.context/design-brief-<feature>-<date>.md` for future reference.
- Be concise. A 70-line brief restating answers the user just gave is noise, not rigor.
