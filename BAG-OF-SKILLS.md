> **AGENT RULE:** invoke `resume-session` skill before proceeding with user prompt, as stated below in "Session Startup". do NOT read user prompt before executing `resume-session`.

# Agent Skills

This project includes a `.skills/` directory containing reusable agent capabilities, following the [Agent Skills standard](https://agentskills.io). These are available for use within this project.

## Available Skills

| Skill                     | Description                                            |
| ------------------------- | ------------------------------------------------------ |
| `save-session`            | Persist session state to `.context/`                   |
| `resume-session`          | Read `.context/` to resume work                        |
| `plan-then-build`         | Collaborative planning before coding                   |
| `generate-commit-message` | Conventional commit drafting                           |
| `arch-review`             | Deep codebase analysis                                 |
| `spec-gen`                | Generate comprehensive project specs                   |
| `design-init`             | One-time design context setup (PRODUCT.md / DESIGN.md) |
| `design-brief`            | UX and visual planning before implementing UI          |
| `design-audit`            | Scored quality check on frontend code                  |
| `design-polish`           | Shipping readiness pass on UI surfaces                 |

## Design Reference

`reference/design-craft.md` — comprehensive reference covering typography, color, layout, motion, interaction, and copy. Skills that do design work load this automatically.

## Session Startup (DO NOT SKIP)

At the start of **every** session, automatically invoke `resume-session` to load the current project state. Do this silently — do not wait for the user to ask. If context exists, confirm catch-up in 1–2 sentences max. If `.context/` is empty or missing, proceed without mentioning it.

## `.context/` Convention

Skills read from and write to a `.context/` directory at the project root. This directory serves as persistent memory for session summaries, architecture decisions, and project specs across agent sessions.

If `.context/` does not exist, create it when a skill requires it.
