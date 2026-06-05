#!/usr/bin/env bash
set -euo pipefail

# bag-of-skills installer
# Drop this in any project root and run: bash install.sh

REPO_URL="${SKILLS_REPO:-https://github.com/johngohrw/bag-of-skills.git}"
TARGET_DIR=".skills"

PREPEND_FILE="$TARGET_DIR/AGENTS-PREPEND.md"
BAG_FILE="$TARGET_DIR/BAG-OF-SKILLS.md"

echo "📦 Installing skills from $REPO_URL ..."

if [ -d "$TARGET_DIR/.git" ]; then
  echo "⚠️  $TARGET_DIR/ already exists and is a git repo."
  echo "   Run 'cd $TARGET_DIR && git pull' to update."
  exit 0
fi

if [ -d "$TARGET_DIR" ]; then
  echo "❌ $TARGET_DIR/ exists but is not a git repo. Aborting to avoid overwriting."
  exit 1
fi

git clone --depth 1 "$REPO_URL" "$TARGET_DIR"

echo ""
echo "✅ Skills installed to $TARGET_DIR/"

# 1. Copy BAG-OF-SKILLS.md to project root (overwrite allowed)
cp -f "$BAG_FILE" "BAG-OF-SKILLS.md"
echo "📋 Copied BAG-OF-SKILLS.md to project root"

# 2. Ensure AGENTS.md exists
if [ ! -f "AGENTS.md" ]; then
  touch "AGENTS.md"
  echo "📋 Created AGENTS.md"
fi

# 3. Prepend AGENTS-PREPEND.md if not already present
if [ -f "$PREPEND_FILE" ]; then
  PREPEND_LINES=$(wc -l < "$PREPEND_FILE" | tr -d ' ')

  if [ -s "AGENTS.md" ]; then
    HEAD_LINES=$(head -n "$PREPEND_LINES" "AGENTS.md")
  else
    HEAD_LINES=""
  fi
  PREPEND_CONTENT=$(cat "$PREPEND_FILE")

  if [ "$HEAD_LINES" != "$PREPEND_CONTENT" ]; then
    # Not present at start — prepend it
    {
      cat "$PREPEND_FILE"
      echo ""
      echo ""
      cat "AGENTS.md"
    } > "AGENTS.md.tmp"
    mv "AGENTS.md.tmp" "AGENTS.md"
    echo "📋 Prepended AGENTS-PREPEND.md to AGENTS.md"
  else
    echo "📋 AGENTS-PREPEND.md already present at start of AGENTS.md"
  fi
fi

echo ""
echo "Done. Your project now has its own .skills/ instance."
echo "Commit .skills/, BAG-OF-SKILLS.md, and AGENTS.md to your repo to share the setup with your team."
echo "To update later, run: cd $TARGET_DIR && git pull"

# Self-destruct
rm -f "$0"
echo "🧹 Removed install.sh"
