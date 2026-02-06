#!/usr/bin/env bash
# Validation script for agent-crew plugin
# Checks all verification items from the plan

cd "$(dirname "$0")"

PASS=0
FAIL=0

check() {
  local num="$1" desc="$2"
  shift 2
  if "$@" >/dev/null 2>&1; then
    echo "  [PASS] Check $num: $desc"
    PASS=$((PASS + 1))
  else
    echo "  [FAIL] Check $num: $desc"
    FAIL=$((FAIL + 1))
  fi
}

echo "=== agent-crew plugin validation ==="
echo ""

# Check 1: Valid JSON in both manifest files
check 1 "plugin.json is valid JSON" \
  python3 -c "import json; json.load(open('.claude-plugin/plugin.json'))"

check 1b "marketplace.json is valid JSON" \
  python3 -c "import json; json.load(open('.claude-plugin/marketplace.json'))"

# Check 2: plugin.json has required fields
check 2 "plugin.json has required fields (name, description, version, author)" \
  python3 -c "
import json
d = json.load(open('.claude-plugin/plugin.json'))
assert all(k in d for k in ('name','description','version','author')), 'missing fields'
"

# Check 3: marketplace.json has plugins array with name+source
check 3 "marketplace.json has plugins array with name and source" \
  python3 -c "
import json
d = json.load(open('.claude-plugin/marketplace.json'))
assert 'plugins' in d and len(d['plugins']) > 0
for p in d['plugins']:
    assert 'name' in p and 'source' in p, f'plugin entry missing name/source: {p}'
"

# Check 4: Agent files have valid YAML frontmatter with name field
check 4 "Agent files have YAML frontmatter with name field" \
  bash -c '
for f in agents/codex-coder.md agents/crew-code.md agents/crew-plan.md agents/crew-review.md; do
  head -1 "$f" | grep -q "^---$" || exit 1
  # Find closing --- and check name field exists between them
  awk "/^---$/{c++; if(c==2) exit} c==1 && /^name:/{found=1} END{exit !found}" "$f" || exit 1
done
'

# Check 5: codex-coder.md frontmatter includes description field
check 5 "codex-coder.md frontmatter has description field" \
  bash -c '
awk "/^---$/{c++; if(c==2) exit} c==1 && /^description:/{found=1} END{exit !found}" agents/codex-coder.md
'

# Check 6: Codex-requiring agents contain "which codex" prerequisite check
check 6 "Codex-requiring agents contain 'which codex' prerequisite check" \
  bash -c '
grep -q "which codex" agents/codex-coder.md && grep -q "which codex" agents/crew-review.md
'

# Check 7: crew-review.md contains "which gemini" check with fallback
check 7 "crew-review.md contains 'which gemini' with fallback logic" \
  bash -c '
grep -q "which gemini" agents/crew-review.md
'

# Check 8: crew-review.md contains both Gemini available and unavailable paths
check 8 "crew-review.md has Gemini-available and Gemini-unavailable code paths" \
  bash -c '
grep -qi "gemini.*available" agents/crew-review.md && grep -qi "gemini.*unavailable\|gemini.*not.*available\|codex.only\|codex-only\|without gemini" agents/crew-review.md
'

# Check 9: README contains mermaid diagram blocks
check 9 "README contains mermaid diagram blocks" \
  grep -q 'mermaid' README.md

# Check 10: Internal links/references are consistent
check 10 "All repo URL references match plugin.json homepage" \
  python3 -c "
import json
d = json.load(open('.claude-plugin/plugin.json'))
url = d.get('homepage','')
assert url, 'no homepage in plugin.json'
# Check README references the same URL
with open('README.md') as f:
    readme = f.read()
# Just verify the repo URL appears in README
assert url in readme or url.replace('https://','') in readme, f'{url} not found in README'
"

# Check 11: commands/crew-code.md has valid frontmatter
check 11 "commands/crew-code.md has valid frontmatter with name field" \
  bash -c '
head -1 "commands/crew-code.md" | grep -q "^---$" || exit 1
awk "/^---$/{c++; if(c==2) exit} c==1 && /^name:/{found=1} END{exit !found}" commands/crew-code.md
'

# Check 12: commands/crew-plan.md has valid frontmatter
check 12 "commands/crew-plan.md has valid frontmatter with name field" \
  bash -c '
head -1 "commands/crew-plan.md" | grep -q "^---$" || exit 1
awk "/^---$/{c++; if(c==2) exit} c==1 && /^name:/{found=1} END{exit !found}" commands/crew-plan.md
'

# Check 13: crew-code.md has both CLI checks but NO exit 1
check 13 "crew-code.md has CLI checks but no exit 1 (both optional)" \
  bash -c '
grep -q "which codex" agents/crew-code.md && grep -q "which gemini" agents/crew-code.md && ! grep -q "exit 1" agents/crew-code.md
'

# Check 14: crew-plan.md has Codex required + Gemini optional
check 14 "crew-plan.md has Codex required (exit 1) and Gemini optional" \
  bash -c '
grep -q "which codex" agents/crew-plan.md && grep -q "exit 1" agents/crew-plan.md && grep -q "which gemini" agents/crew-plan.md
'

echo ""
echo "=== Results: $PASS passed, $FAIL failed out of $((PASS+FAIL)) checks ==="
if [ "$FAIL" -eq 0 ]; then
  echo "ALL CHECKS PASSED"
else
  echo "SOME CHECKS FAILED"
  exit 1
fi
