---
name: design-polish
description: Final shipping readiness pass on a UI surface, component, or page. Checks for completeness, consistency, edge cases, micro-interactions, and copy polish. Use after implementation is functionally complete but before declaring it done. Not for finding bugs — for finding gaps between "it works" and "it ships."
---

# Design Polish

Final pass before declaring a UI complete. This is not about finding bugs — it's about the gap between "it works" and "it ships."

**Prerequisites:** The target surface should be functionally complete. Read `.context/PRODUCT.md` and `.context/DESIGN.md` if they exist.

---

## Phase 1: Completeness Check

### States

Verify every state is implemented and visually coherent:

- [ ] **Default**: the happy path
- [ ] **Empty**: no data yet, first-time user
- [ ] **Loading**: skeleton, spinner, or progress indicator
- [ ] **Error**: validation, network, or system failure
- [ ] **Success**: confirmation, completion, or transition
- [ ] **Edge cases**: max length, overflow, power-user volume

For each missing state: describe what it should show and how it should feel.

### Edge Cases

- **Text overflow**: long names, URLs, descriptions. Is truncation handled? Does it break layout?
- **Empty collections**: lists with 0 items, search with no results
- **Network failure**: does the UI degrade gracefully?
- **Slow connections**: are loading states visible and reassuring?
- **Permission denied**: does the UI explain why instead of just hiding?

---

## Phase 2: Design System Alignment

### Tokens & Consistency

- Are design tokens used everywhere? (colors, spacing, typography, radii)
- Any hard-coded values that should be tokens?
- Does the surface match the DESIGN.md spec (if one exists)?
- Are component patterns consistent with the rest of the codebase?

### Spacing Rhythm

- Is spacing consistent with the project's scale?
- Do related elements have tighter spacing than unrelated ones?
- Is there adequate breathing room around interactive elements?

---

## Phase 3: Interaction Completeness

### Micro-interactions

- [ ] **Hover**: does every interactive element respond on hover?
- [ ] **Focus**: are focus indicators visible and styled? (not just browser default)
- [ ] **Active / pressed**: does the pressed state exist?
- [ ] **Disabled**: is the disabled state visually distinct, not just grayed out?
- [ ] **Selected / current**: does the active/selected state exist and is it clear?

### Motion

- Are transitions purposeful, not decorative?
- Does every animation respect `@media (prefers-reduced-motion: reduce)`?
- Are easing curves consistent with the project's motion language?
- Are durations appropriate? (not too fast to perceive, not too slow to feel sluggish)

---

## Phase 4: Copy Polish

### Every Word Earns Its Place

- No restated headings or intros that repeat the title
- No placeholder text ("Lorem ipsum", "Sample text", "Description here")
- Button labels are actions, not nouns: "Save changes" not "Submit"
- Error messages explain what happened and what to do next
- Empty states explain why it's empty and what to do about it
- No em dashes — use commas, colons, semicolons, periods, or parentheses

### Specific Checks

- [ ] All button labels are verb-led
- [ ] All form labels are clear and scannable
- [ ] All error messages are actionable
- [ ] All empty states have a primary action or clear next step
- [ ] No ALL CAPS body copy (short labels ≤4 words are fine)
- [ ] Placeholder text is used only for examples, never for labels

---

## Phase 5: Accessibility Polish

- Contrast ratios verified, not eyeballed
- All interactive elements reachable by keyboard
- Focus order is logical
- Screen reader labels exist where visual labels don't (icon buttons, etc.)
- Color is not the only indicator of state (errors, selection, etc.)

---

## Phase 6: Output

Produce a concise polish report:

```markdown
# Polish Report — [Surface Name] (YYYY-MM-DD)

## Completeness
- Missing states: [list]
- Edge cases handled: [list]
- Gaps: [list]

## Design System
- Token violations: [list]
- Spacing issues: [list]

## Interactions
- Missing micro-interactions: [list]
- Motion gaps: [list]

## Copy
- Issues: [list]

## Accessibility
- Issues: [list]

## Recommended Fixes
[P0–P3 prioritized]
```

Save to `.context/polish-<surface>-<YYYY-MM-DD>.md` if the user wants it persisted.

Present the findings and ask:

> "These are the gaps between 'works' and 'ships.' Shall I fix the P0 and P1 items?"

---

## Rules

- This is a completeness check, not a bug hunt. Don't duplicate what tests catch.
- If PRODUCT.md or DESIGN.md exists, use them as the source of truth for "correct."
- If they don't exist, infer standards from the existing codebase and flag inconsistencies.
- Be specific: "Card shadow is 8px here but 4px everywhere else" beats "shadows are inconsistent."
- Never skip positive findings. Note what's already polished so the user knows what not to touch.
- Create `.context/` if it does not exist.
- Cross-reference the design-craft reference for specific thresholds (contrast ratios, letter-spacing floors, etc.).
