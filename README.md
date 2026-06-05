# Bag of Skills

A collection of agent-agnostic skills following the [Agent Skills standard](https://agentskills.io). These are stateless capabilities that read from and write to a project-local `.context/` directory to maintain continuity across sessions.

This repository is not a standalone project. It is meant to be cloned into a `.skills/` directory within other repositories.

---

## Skills

| Skill                     | Description                                                                                                                                                      |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `save-session`            | Capture the current session — files changed, decisions made, test state, open items — to a timestamped markdown file in `.context/`.                             |
| `resume-session`          | Read the most recent `.context/` files to reconstruct project state. **Note:** this happens automatically at session startup via `AGENTS.md` — manual invocation is rarely needed. |
| `plan-then-build`         | Explore the codebase, present implementation options with tradeoffs, grill the user on constraints, and crystallize an explicit plan before any code is written. |
| `generate-commit-message` | Inspect staged changes, recent commit history, and `.context/` files to draft a Conventional Commit message for user approval.                                   |
| `arch-review`             | Walk the codebase to identify coupling, untested modules, shallow abstractions, and mixed concerns. Presents ranked candidates for refactoring.                  |
| `spec-gen`                | Deeply explore a codebase and emit a comprehensive project spec covering stack, schemas, routes, features, design decisions, and technical debt.                 |
| `design-init`             | One-time design context setup: interviews the user and writes `.context/PRODUCT.md` and `.context/DESIGN.md`.                                                     |
| `design-brief`            | UX and visual planning for a frontend feature before any code is written. Produces a confirmed design brief.                                                     |
| `design-audit`            | Scored quality check on frontend code across a11y, performance, theming, responsive, and anti-patterns. Outputs a ranked report.                                   |
| `design-polish`           | Shipping readiness pass on UI surfaces. Checks states, micro-interactions, copy, and edge cases.                                                                 |

---

## Install

Drop `install.sh` into the target project root and execute it:

```bash
curl -O https://raw.githubusercontent.com/johngohrw/bag-of-skills/main/install.sh
bash install.sh
```

The script performs the following:

1. Clones this repository into `.skills/` via a shallow clone.
2. Copies `BAG-OF-SKILLS.md` from `.skills/` into the project root (overwrites any preexisting file).
3. Ensures `AGENTS.md` exists in the project root, creating it if necessary.
4. Prepends `AGENTS-PREPEND.md` from `.skills/` to the start of `AGENTS.md` if not already present.
5. Deletes `install.sh`.

> **Note:** `.skills/` is not added to `.gitignore`. Commit it alongside `AGENTS.md` and `BAG-OF-SKILLS.md` so your team shares the same skill set.

---

## Update

Each project maintains its own `.skills/` clone. To update skills in a project:

```bash
.skills/update.sh
```

This is a thin wrapper around `git pull` executed from within `.skills/`.

---

## The `.context/` Convention

Most skills in this collection interact with a `.context/` directory at the project root. This directory serves as out-of-band persistent memory: session summaries, architecture decisions, project specs, and other continuity artifacts are written here by agents and read back on subsequent invocations.

Because `.context/` lives inside the project, it can be committed to git or left untracked, depending on whether you want session history to travel with the repository.

**Automatic resume:** `AGENTS.md` instructs the agent to automatically read recent `.context/` files at every session startup. No manual `/skill:resume-session` invocation is needed.

---

## `AGENTS.md` and `BAG-OF-SKILLS.md`

This repository provides two files that work together:

- **`BAG-OF-SKILLS.md`** — the full skills documentation, conventions, and reference. Copied to the project root on install.
- **`AGENTS-PREPEND.md`** — a short directive that tells the agent to read `BAG-OF-SKILLS.md` before proceeding. Automatically prepended to the project's `AGENTS.md`.

Agents that support context files (e.g. pi, Claude Code) automatically load `AGENTS.md` at startup. The prepended directive ensures the agent reads the full skills documentation from `BAG-OF-SKILLS.md` without requiring manual invocation.
