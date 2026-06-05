#!/usr/bin/env bash
# Run this from your project root as: .skills/update.sh
# Or cd into .skills/ and run: git pull

set -euo pipefail

SKILLS_DIR="$(dirname "$0")"
PROJECT_ROOT="$(cd "$SKILLS_DIR/.." && pwd)"

cd "$SKILLS_DIR"
echo "🔄 Updating skills..."
git pull
echo "✅ Skills updated."

# Update BAG-OF-SKILLS.md in project root
cp -f "$SKILLS_DIR/BAG-OF-SKILLS.md" "$PROJECT_ROOT/BAG-OF-SKILLS.md"
echo "📋 Updated BAG-OF-SKILLS.md"

# Ensure AGENTS-PREPEND.md is still at the start of AGENTS.md
if [ -f "$SKILLS_DIR/AGENTS-PREPEND.md" ]; then
  PREPEND_LINES=$(wc -l < "$SKILLS_DIR/AGENTS-PREPEND.md" | tr -d ' ')

  if [ -s "$PROJECT_ROOT/AGENTS.md" ]; then
    HEAD_LINES=$(head -n "$PREPEND_LINES" "$PROJECT_ROOT/AGENTS.md")
  else
    HEAD_LINES=""
  fi
  PREPEND_CONTENT=$(cat "$SKILLS_DIR/AGENTS-PREPEND.md")

  if [ "$HEAD_LINES" != "$PREPEND_CONTENT" ]; then
    {
      cat "$SKILLS_DIR/AGENTS-PREPEND.md"
      echo ""
      echo ""
      cat "$PROJECT_ROOT/AGENTS.md"
    } > "$PROJECT_ROOT/AGENTS.md.tmp"
    mv "$PROJECT_ROOT/AGENTS.md.tmp" "$PROJECT_ROOT/AGENTS.md"
    echo "📋 Prepended AGENTS-PREPEND.md to AGENTS.md"
  else
    echo "📋 AGENTS-PREPEND.md already present at start of AGENTS.md"
  fi
fi
