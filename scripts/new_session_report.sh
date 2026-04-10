#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <agent> <short-topic>"
  echo "Example: $0 codex nlp-move-parser"
  exit 1
fi

AGENT="$1"
TOPIC="$2"
TS="$(date +%Y-%m-%d_%H-%M-%S)"
OUT_DIR="reports/sessions"
OUT_FILE="${OUT_DIR}/${TS}_${AGENT}_${TOPIC}.md"

mkdir -p "${OUT_DIR}"

cat > "${OUT_FILE}" <<EOT
# Session Report

## Metadata
- Date/Time: ${TS}
- Agent: ${AGENT}
- Branch: \$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "N/A")
- Session goal:

## Operational Rationale
- Which operational need this session addressed.
- Why this work was prioritized now.
- Which cost/risk this session aimed to reduce.

## Technical Rationale
- Initial technical diagnosis.
- Design/implementation decisions.
- Accepted tradeoffs.

## Changes Implemented
- Files modified:
- Behavior before:
- Behavior after:

## Commits
- SHA:
- Message:
- Scope:

## Validation
- Test cases executed:
- Result:
- Evidence (commands/logs):

## Pending Risks / Debt
- Risk 1:
- Risk 2:

## Cross-Review Request
- What to review:
- Suggested reviewer agent:
- Approval criteria:
EOT

echo "Report created: ${OUT_FILE}"
