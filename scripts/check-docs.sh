#!/usr/bin/env bash
# Fails when doc counts drift from disk reality. Run after editing any count.
set -u
cd "$(dirname "$0")/.." || exit 1
fail=0

repo_skills=$(git ls-files '.agents/skills/*/SKILL.md' | cut -d/ -f3 | sort -u | wc -l | tr -d ' ')
readme_n=$(grep -oE '[0-9]+ self-contained skills' README.md | grep -oE '^[0-9]+')
if [ "$readme_n" != "$repo_skills" ]; then
  echo "README.md: says ${readme_n:-<none>} self-contained skills, repo has $repo_skills"
  fail=1
fi

tree_n=$(awk '/^\.agents\/skills\//{f=1; next} /^\.claude\/skills\//{f=0} f && /^[├└]/ {n++} END {print n+0}' docs/architecture/skill-layout.md)
if [ "$tree_n" != "$repo_skills" ]; then
  echo "docs/architecture/skill-layout.md: tree lists $tree_n skills, repo has $repo_skills"
  fail=1
fi

store=$(ls -1 ~/.agents/skills 2>/dev/null | wc -l | tr -d ' ')
doc_store=$(grep -oE 'agents/skills/`, [0-9]+' docs/reference/skills-inventory.md | grep -oE '[0-9]+$')
if [ "$doc_store" != "$store" ]; then
  echo "docs/reference/skills-inventory.md: says store has ${doc_store:-<none>}, disk has $store"
  fail=1
fi

links=$(ls -1 ~/.claude/skills 2>/dev/null | wc -l | tr -d ' ')
doc_links=$(grep -oE 'skills/`, [0-9]+ links' docs/reference/skills-inventory.md | grep -oE '[0-9]+' | head -1)
if [ "$doc_links" != "$links" ]; then
  echo "docs/reference/skills-inventory.md: says ~/.claude/skills has ${doc_links:-<none>} links, disk has $links"
  fail=1
fi

exit $fail
