---
name: design-audit
description: Run systematic technical quality checks on frontend code across accessibility, performance, theming, responsive design, and anti-patterns. Generates a scored report with prioritized fix recommendations. Use for pre-ship checks, codebase health assessments, or before significant redesigns.
---

# Design Audit

Run systematic **technical** quality checks and generate a scored report. This is a code-level audit, not a design critique. Check what's measurable and verifiable.

**Output:** A scored report saved to `.context/audit-<YYYY-MM-DD>.md`.

---

## Phase 1: Diagnostic Scan

Run comprehensive checks across 5 dimensions. Score each 0–4.

### 1. Accessibility (A11y)

**Check for:**
- **Contrast issues**: text contrast ratios < 4.5:1 (or 7:1 for AAA)
- **Missing ARIA**: interactive elements without proper roles, labels, or states
- **Keyboard navigation**: missing focus indicators, illogical tab order, keyboard traps
- **Semantic HTML**: improper heading hierarchy, missing landmarks, divs instead of buttons
- **Alt text**: missing or poor image descriptions
- **Form issues**: inputs without labels, poor error messaging, missing required indicators

**Score 0–4:**
- 0 = Inaccessible (fails WCAG A)
- 1 = Major gaps (few ARIA labels, no keyboard nav)
- 2 = Partial (some a11y effort, significant gaps)
- 3 = Good (WCAG AA mostly met, minor gaps)
- 4 = Excellent (WCAG AA fully met, approaches AAA)

### 2. Performance

**Check for:**
- **Layout thrashing**: reading/writing layout properties in loops
- **Expensive animations**: layout-property animation, unbounded blur/filter/shadow, frame drops
- **Missing optimization**: images without lazy loading, unoptimized assets, missing will-change
- **Bundle size**: unnecessary imports, unused dependencies
- **Render performance**: unnecessary re-renders, missing memoization

**Score 0–4:**
- 0 = Severe issues (layout thrash, unoptimized everything)
- 1 = Major problems (no lazy loading, expensive animations)
- 2 = Partial (some optimization, gaps remain)
- 3 = Good (mostly optimized, minor improvements possible)
- 4 = Excellent (fast, lean, well-optimized)

### 3. Theming

**Check for:**
- **Hard-coded colors**: colors not using design tokens
- **Broken dark mode**: missing variants, poor contrast in dark theme
- **Inconsistent tokens**: wrong tokens, mixing token types
- **Theme switching issues**: values that don't update on theme change

**Score 0–4:**
- 0 = No theming (hard-coded everything)
- 1 = Minimal tokens (mostly hard-coded)
- 2 = Partial (tokens exist but inconsistently used)
- 3 = Good (tokens used, minor hard-coded values)
- 4 = Excellent (full token system, dark mode works perfectly)

### 4. Responsive Design

**Check for:**
- **Fixed widths**: hard-coded widths that break on mobile
- **Touch targets**: interactive elements < 44×44px
- **Horizontal scroll**: content overflow on narrow viewports
- **Text scaling**: layouts that break when text size increases
- **Missing breakpoints**: no mobile/tablet variants

**Score 0–4:**
- 0 = Desktop-only (breaks on mobile)
- 1 = Major issues (some breakpoints, many failures)
- 2 = Partial (works on mobile, rough edges)
- 3 = Good (responsive, minor touch target or overflow issues)
- 4 = Excellent (fluid, all viewports, proper touch targets)

### 5. Anti-Patterns

Check against design-craft reference anti-patterns. Look for:
- AI slop tells: gradient text, glassmorphism, hero metrics, generic card grids, purple-to-blue gradients
- Gray text on colored backgrounds
- Nested cards
- Bounce/elastic easing
- Redundant copy, restated headings
- All-caps body copy
- Font-family count > 3
- Hero clamp > 6rem
- Display letter-spacing < -0.04em
- Missing reduced-motion alternatives

**Score 0–4:**
- 0 = AI slop gallery (5+ tells)
- 1 = Heavy AI aesthetic (3–4 tells)
- 2 = Some tells (1–2 noticeable)
- 3 = Mostly clean (subtle issues only)
- 4 = No AI tells (distinctive, intentional design)

---

## Phase 2: Generate Report

### Audit Health Score

| # | Dimension | Score | Key Finding |
|---|-----------|-------|-------------|
| 1 | Accessibility | ? | [most critical issue or "—"] |
| 2 | Performance | ? | |
| 3 | Theming | ? | |
| 4 | Responsive | ? | |
| 5 | Anti-Patterns | ? | |
| **Total** | | **??/20** | **[Rating band]** |

**Rating bands:**
- 18–20: Excellent (minor polish)
- 14–17: Good (address weak dimensions)
- 10–13: Acceptable (significant work needed)
- 6–9: Poor (major overhaul)
- 0–5: Critical (fundamental issues)

### Anti-Patterns Verdict

Pass/fail: does this look AI-generated? List specific tells. Be brutally honest.

### Executive Summary

- Audit Health Score: **??/20** ([rating band])
- Total issues found (count by severity: P0/P1/P2/P3)
- Top 3–5 critical issues
- Recommended next steps

### Detailed Findings by Severity

Tag every issue with **P0–P3**:
- **P0 Blocking**: Prevents task completion. Fix immediately.
- **P1 Major**: Significant difficulty or WCAG AA violation. Fix before release.
- **P2 Minor**: Annoyance, workaround exists. Fix in next pass.
- **P3 Polish**: Nice-to-fix, no real user impact. Fix if time permits.

For each issue:
- **[P?] Issue name**
- **Location**: component, file, line
- **Category**: Accessibility / Performance / Theming / Responsive / Anti-Pattern
- **Impact**: how it affects users
- **Recommendation**: how to fix it
- **Suggested skill**: which command to run (e.g. `/skill:design-polish`, `/skill:design-brief`)

### Patterns & Systemic Issues

Identify recurring problems:
- "Hard-coded colors appear in 15+ components, should use design tokens"
- "Touch targets consistently too small throughout mobile experience"

### Positive Findings

Note what's working well: good practices to maintain.

---

## Phase 3: Save Report

Write the report to:

```
.context/audit-<YYYY-MM-DD>.md
```

If `.context/` does not exist, create it.

Then present a summary to the user and recommend next skills in priority order (P0 first):

> You can ask me to run these one at a time, all at once, or in any order you prefer.
> Re-run `/skill:design-audit` after fixes to see your score improve.

---

## Rules

- Be thorough but actionable. Too many P3 issues creates noise.
- Never report issues without explaining impact.
- Never provide generic recommendations — be specific and actionable.
- Never skip positive findings.
- Never forget to prioritize. Everything can't be P0.
- Never report false positives without verification.
- Read `.context/PRODUCT.md` and `.context/DESIGN.md` first if they exist — they inform what "on-brand" means.
- Cross-reference the design-craft reference for anti-pattern detection.
