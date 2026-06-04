# Bag of Skills

A personal collection of reusable coding agent skills. These are designed for use with [pi](https://pi.dev) and other agents that follow the [Agent Skills standard](https://agentskills.io).

This is not a runnable project — it is a shared library of capabilities that you install into individual projects.

---

## Skills

| Skill | Description |
|-------|-------------|
| `save-session` | Persist the current development session to a timestamped file in `.context/` |
| `get-up-to-speed` | Read `.context/` files to understand project state before continuing work |
| `plan-and-implement` | Collaborative planning phase before any code is written |
| `generate-commit-message` | Analyze staged changes and generate a Conventional Commit message |
| `architecture-review` | Deep codebase analysis for refactoring and testability improvements |
| `project-spec-generator` | Explore a codebase and produce a comprehensive project specification |

---

## Quick Start

### Install skills into a project

Drop `install.sh` into any project root and run it:

```bash
curl -O https://raw.githubusercontent.com/johngohrw/bag-of-skills/main/install.sh
bash install.sh
```

Or clone manually:

```bash
git clone --depth 1 https://github.com/johngohrw/bag-of-skills.git .skills
echo ".skills/" >> .gitignore
```

### What `install.sh` does

1. Clones this repo into `.skills/`
2. Copies `AGENTS.md` into your project root (aborts if one already exists)
3. Adds `.skills/` to `.gitignore`
4. Deletes itself

### Update skills

```bash
cd .skills && git pull
```

Or if `update.sh` was included:

```bash
.skills/update.sh
```

---

## The `.context/` Convention

Most skills in this collection read from and write to a `.context/` directory in the project root. This is where session summaries, architecture decisions, and project specs live.

**Why `.context/`?** It gives every project its own persistent memory. Agents can save state at the end of a session and resume from it in the next one.

Example `.context/` contents:

```
.context/
  session-2026-06-05.md
  session-2026-06-05-pm.md
  project-spec-2026-05-01.md
  architecture-decisions.md
```

---

## `AGENTS.md`

The repo includes an `AGENTS.md` file that provides introductory context for coding agents. When installed into a project, pi (and other compatible agents) automatically read it at startup — no need to tell the agent about the skills manually.

> **Note:** `install.sh` will abort if an `AGENTS.md` already exists in the target directory, to avoid overwriting your project's own agent instructions.

---

## Repo Structure

```
bag-of-skills/
  AGENTS.md                    # Introductory context for agents
  README.md                    # This file
  install.sh                   # One-shot installer for new projects
  update.sh                    # Helper to git pull from within .skills/
  save-session/SKILL.md
  get-up-to-speed/SKILL.md
  plan-and-implement/SKILL.md
  generate-commit-message/SKILL.md
  architecture-review/SKILL.md
  project-spec-generator/SKILL.md
```

---

## Customizing the Repo URL

The install script defaults to this repo, but you can override it:

```bash
SKILLS_REPO="https://github.com/johngohrw/bag-of-skills.git" bash install.sh
```

Or edit `REPO_URL` directly in `install.sh` before distributing it.

---

## Adding New Skills

1. Create a new directory: `my-new-skill/`
2. Add a `SKILL.md` following the [Agent Skills standard](https://agentskills.io)
3. Commit and push
4. In each project, `cd .skills && git pull` to receive the new skill
