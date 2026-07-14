#!/usr/bin/env bash
# detect.sh — emit deterministic facts a codemap needs.
# Usage: detect.sh [repo-root]   (default: current dir)
#
# Output is plain text sections separated by blank lines. The agent reads this
# instead of regenerating the same `find | wc` calls every time.

set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

# Common exclude pattern shared by all find/du calls
PRUNE=( -path './.git' -o -path './node_modules' -o -path '*/node_modules' \
        -o -path './.next' -o -path '*/.next' -o -path './dist' -o -path '*/dist' \
        -o -path './build' -o -path '*/build' -o -path './target' -o -path '*/target' \
        -o -path './.venv' -o -path '*/.venv' -o -path './venv' -o -path '*/venv' \
        -o -path './__pycache__' -o -path '*/__pycache__' \
        -o -path './.turbo' -o -path '*/.turbo' \
        -o -path './coverage' -o -path '*/coverage' )

# Source extensions worth counting toward LOC
SRC_EXT='\.(ts|tsx|js|jsx|mjs|cjs|py|go|rs|java|kt|rb|php|cs|swift|scala|sql)$'
TEST_PATH='(test|spec|__tests__)'

echo "=== repo root ==="
pwd
echo

echo "=== counts ==="
SRC=$(find . \( "${PRUNE[@]}" \) -prune -o -type f -print 2>/dev/null \
  | grep -E "$SRC_EXT" | grep -vE "$TEST_PATH" | wc -l)
TST=$(find . \( "${PRUNE[@]}" \) -prune -o -type f -print 2>/dev/null \
  | grep -E "$SRC_EXT" | grep -E "$TEST_PATH" | wc -l)
LOC=$(find . \( "${PRUNE[@]}" \) -prune -o -type f -print 2>/dev/null \
  | grep -E "$SRC_EXT" | xargs -d '\n' wc -l 2>/dev/null | tail -1 | awk '{print $1}')
printf 'src files: %s\ntest files: %s\nLOC (src+test): %s\n' "$SRC" "$TST" "$LOC"
echo

echo "=== primary language (by file count) ==="
find . \( "${PRUNE[@]}" \) -prune -o -type f -print 2>/dev/null \
  | grep -oE "$SRC_EXT" | sort | uniq -c | sort -rn | head -5
echo

echo "=== manifest files (read these for stack info) ==="
for f in package.json pnpm-workspace.yaml turbo.json pyproject.toml requirements.txt \
         Cargo.toml go.mod pom.xml build.gradle build.gradle.kts Gemfile composer.json \
         Dockerfile docker-compose.yml docker-compose.yaml railway.toml railway.json \
         vercel.json netlify.toml .tool-versions .nvmrc .python-version; do
  [ -f "$f" ] && echo "  ./$f"
done
find . -maxdepth 3 \( "${PRUNE[@]}" \) -prune -o -type f \( \
    -name 'package.json' -o -name 'pyproject.toml' -o -name 'Cargo.toml' \
    -o -name 'go.mod' \) -print 2>/dev/null | grep -v '^\./package.json$' | head -30
echo

echo "=== top-level tree (depth 2) ==="
find . -maxdepth 2 \( "${PRUNE[@]}" \) -prune -o -type d -print 2>/dev/null \
  | grep -v '^\.$' | sort | head -60
echo

echo "=== existing CODEMAP ==="
if [ -f CODEMAP.md ]; then
  echo "  present — read it before drafting"
  head -3 CODEMAP.md
else
  echo "  none — create workflow"
fi
echo

echo "=== recent commit titles (last 20) ==="
if [ -d .git ]; then
  git log --oneline -20 2>/dev/null || echo "  (git log failed)"
else
  echo "  (not a git repo)"
fi
