# Design Craft Reference

A comprehensive reference for frontend design quality. Load this when working on any visual surface, component, or layout. Not a checklist — a source of truth for design decisions.

---

## Typography

### Scale & Hierarchy

- **Hierarchy through scale + weight contrast.** The ratio between adjacent type steps should be ≥1.25. Flat scales read as noise, not hierarchy.
- **Cap font-family count at 3** (display + body + optional mono). More than 3 reads as indecision. One well-tuned family with weight contrast usually beats three competing typefaces.
- **Pair on a contrast axis.** Don't pair fonts that are similar but not identical (two geometric sans-serifs, two humanist sans-serifs). Pair serif + sans, geometric + humanist, or use one family in multiple weights.
- **No all-caps body copy.** Reserve uppercase for short labels (≤4 words), section eyebrows (used sparingly), and badges. Sentences in ALL CAPS are unreadable at body sizes.

### Sizing & Spacing

- **Hero / display heading ceiling:** `clamp()` max ≤ 6rem (~96px). Above that the page is shouting, not designing.
- **Display heading letter-spacing floor:** ≥ -0.04em. Anything tighter and letters touch; cramped, not "designed." -0.02 to -0.03em is plenty for tight grotesque display.
- **Cap body line length at 65–75ch.** Longer lines fatigue the eye; shorter lines waste horizontal space.
- **Use `text-wrap: balance` on h1–h3** for even line lengths. Use `text-wrap: pretty` on long prose to reduce orphans.

### OpenType & Details

- Enable `font-feature-settings: "liga" 1` for standard ligatures in body text where the font supports them.
- For tabular data, use `font-variant-numeric: tabular-nums` to prevent column jitter.

---

## Color

### Contrast

- **Body text must hit ≥4.5:1** against its background. Large text (≥18px or bold ≥14px) needs ≥3:1.
- **Placeholder text needs the same 4.5:1**, not the muted-gray default.
- **The most common failure:** muted gray body text on a tinted near-white. If the contrast is even close, bump the body color toward the ink end of the ramp. Light gray "for elegance" is the single biggest reason AI designs feel hard to read.
- **Gray text on a colored background looks washed out.** Use a darker shade of the background's own hue, or a transparency of the text color.

### Palette Strategy

- Use **OKLCH** for perceptually uniform color manipulation. Prefer it over HSL for palettes.
- **Tinted neutrals beat pure gray.** A background with slight warmth or coolness feels intentional; `#f5f5f5` feels default.
- **Limit chroma on backgrounds.** Surfaces should be nearly achromatic; save chroma for accents and interactive states.
- **Every color in the palette needs a role:** background, surface, text/ink, accent, muted, error, success. Don't add colors without assigning them.

### Dark Mode

- Dark mode is not a color inversion. It's a recomposition of the palette for low-light reading.
- Reduce chroma in dark mode — saturated colors vibrate against dark backgrounds.
- Lighten text more than you'd expect. `#ffffff` on `#000000` is too stark; `#e2e2e2` on `#0a0a0a` is calmer.

---

## Layout

### Spacing & Rhythm

- **Vary spacing for rhythm.** Equal spacing everywhere reads as a grid, not a composition. Tighten related elements; loosen unrelated sections.
- **Build a spacing scale, not arbitrary values.** A modular scale (e.g. 4px base: 4, 8, 12, 16, 24, 32, 48, 64, 96) creates coherence. Pick 6–8 steps and use only those.

### Structural Choices

- **Flexbox for 1D, Grid for 2D.** Don't default to Grid when `flex-wrap` would be simpler.
- **For responsive grids without breakpoints:** `repeat(auto-fit, minmax(280px, 1fr))`.
- **Cards are the lazy answer.** Use them only when they're truly the best affordance. Nested cards are always wrong.
- **Build a semantic z-index scale:** dropdown → sticky → modal-backdrop → modal → toast → tooltip. Never arbitrary values like 999 or 9999.

### Responsive

- **Mobile-first by default.** Start with the narrowest reasonable viewport and add complexity as space allows.
- **Fluid design over breakpoint explosion.** Use `clamp()`, `min()`, `max()`, and viewport units where appropriate. Prefer 2–3 meaningful breakpoints over 6–8.
- **Container queries for component-level responsiveness.** Use when a component needs to adapt to its container, not the viewport.

---

## Motion

### Philosophy

- Motion should be intentional, not an afterthought. Consider it as part of the build.
- Don't animate CSS layout properties (`width`, `height`, `top`, `left`) unless truly needed. Use `transform` and `opacity` for performance.

### Curves & Timing

- **Ease out with exponential curves:** `ease-out-quart`, `quint`, `expo`. No bounce, no elastic.
- **Default durations:** 150–200ms for micro-interactions (hover, focus), 300–500ms for entrances and transitions, 800–1200ms for page-level reveals.
- **Staggering within one list is legitimate.** The tell is the uniform reflex (one identical entrance applied to every section). Each reveal should fit what it reveals. Suppressing the reflex is never a reason to ship a page with no motion at all.

### Safety & Accessibility

- **Reduced motion is not optional.** Every animation needs a `@media (prefers-reduced-motion: reduce)` alternative: typically a crossfade or instant transition.
- **Reveal animations must enhance an already-visible default.** Don't gate content visibility on a class-triggered transition; transitions pause on hidden tabs and headless renderers, so the reveal never fires and the section ships blank.

### Materials

- Premium motion materials are not just `transform`/`opacity`. Blur, `backdrop-filter`, `clip-path`, mask, and shadow/glow are part of the palette when they materially improve the effect and stay smooth (60fps).

---

## Interaction

### Form Patterns

- Every input needs an associated label. Placeholder is not a label.
- Error messages should explain what happened and what to do next. Not just "Invalid input."
- Required fields should be visually indicated, not only validated on submit.
- Focus indicators must be visible. Don't remove outlines without replacing them.

### Dropdowns & Overlays

- Dropdowns rendered with `position: absolute` inside an `overflow: hidden` or `overflow: auto` container will be clipped. Use the native `<dialog>` / popover API, `position: fixed`, or a portal to escape the stacking context.
- Modals should trap focus and restore it on close.

### Hover & Touch

- On touch devices, hover states should not be required to understand an element is interactive.
- Interactive elements should have a minimum touch target of 44×44px.

---

## Copy & UX Writing

### Voice

- Every word earns its place. No restated headings, no intros that repeat the title.
- No em dashes. Use commas, colons, semicolons, periods, or parentheses. Also not `--`.

### Buttons & Labels

- Button labels are actions, not nouns: "Save changes" not "Submit" or "OK".
- Destructive actions should be explicit: "Delete account" not "Remove".

### Empty & Error States

- Empty states should explain why it's empty and what to do about it. Never a raw "No data" table.
- Error states should be specific, actionable, and non-blaming. "We couldn't save your changes. Check your connection and try again." not "Error 500."

---

## Anti-Patterns

These are signals of unconsidered design. Flag them in audit; avoid them in implementation.

| Pattern | Why It's Wrong | What To Do Instead |
|---------|---------------|-------------------|
| Gradient text | Hard to read, screams "AI generated" | Solid color with weight or scale contrast |
| Glassmorphism | Usually poor contrast, overused | Opaque surfaces with intentional depth |
| Hero metric layout | "Trusted by 10,000+" — hollow social proof | Specific outcomes, customer quotes, or nothing |
| Generic card grid | Every SaaS looks identical | Vary layout by content hierarchy |
| Purple-to-blue gradients | The default AI palette | Choose a brand color and commit to it |
| Inter for everything | The default AI font | Pick a font with personality appropriate to the brand |
| Bounce/elastic easing | Feels playful in a way most products don't need | Expo or quart ease-out |
| Nested cards | Creates visual noise and unclear hierarchy | Flatten, use spacing instead of borders |
| Gray text on colored bg | Washed out, low energy | Use a darker shade of the bg hue, or translucent text |
| 999 / 9999 z-index | Maintenance nightmare | Semantic z-index scale |

---

## Quality Checklist (Quick Reference)

Use before declaring any UI complete:

- [ ] Contrast ratios verified (body ≥4.5:1, large ≥3:1)
- [ ] All interactive elements have hover, focus, active, disabled states
- [ ] Reduced motion alternatives exist for all animations
- [ ] Empty, loading, error states implemented
- [ ] No placeholder text used as labels
- [ ] No hard-coded colors outside token system
- [ ] Touch targets ≥44×44px on mobile
- [ ] Keyboard navigation works and focus is visible
- [ ] Text wraps at ≤75ch for body copy
- [ ] Hero headings ≤6rem
- [ ] Display letter-spacing ≥ -0.04em
- [ ] Font families ≤3
- [ ] Every word earns its place
