#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="${ROOT_DIR}/projects"
FRAMEWORK_DIR="${ROOT_DIR}/framework"
REPORTS_DIR="${ROOT_DIR}/reports/sessions"

ERRORS=0
WARNINGS=0

err() {
  echo "ERROR: $*" >&2
  ERRORS=$((ERRORS + 1))
}

warn() {
  echo "WARN: $*" >&2
  WARNINGS=$((WARNINGS + 1))
}

parse_project_path() {
  local file="$1"
  awk '
    $0 ~ /^## Path$/ { in_path=1; next }
    in_path && $0 ~ /^$/ { next }
    in_path {
      line=$0
      gsub(/`/, "", line)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)
      print line
      exit
    }
  ' "$file"
}

extract_framework_refs() {
  local file="$1"
  awk '
    BEGIN { in_table=0 }
    /^## Framework File Locations$/ { in_table=1; next }
    in_table && /^## / { exit }
    in_table && /^\|/ {
      line=$0
      gsub(/^\|[[:space:]]*/, "", line)
      split(line, cols, "|")
      key=cols[1]
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", key)
      if (key != "" && key != "Framework Doc" && key !~ /^-+$/) {
        print key
      }
    }
  ' "$file"
}

validate_project_context_files() {
  local project_file="$1"
  local project_name
  local project_path

  project_name="$(basename "$project_file" .md)"
  project_path="$(parse_project_path "$project_file")"

  if [ -z "$project_path" ]; then
    err "${project_name}: no se pudo extraer '## Path' desde $(basename "$project_file")"
    return
  fi

  if [ ! -d "$project_path" ]; then
    err "${project_name}: ruta de proyecto no existe: ${project_path}"
    return
  fi

  for context_file in CLAUDE.md CODEX.md GEMINI.md; do
    if [ ! -f "${project_path}/${context_file}" ]; then
      err "${project_name}: falta ${context_file} en ${project_path}"
    fi
  done
}

validate_project_framework_refs() {
  local project_file="$1"
  local project_name
  local refs

  project_name="$(basename "$project_file" .md)"
  refs="$(extract_framework_refs "$project_file")"

  if [ -z "$refs" ]; then
    warn "${project_name}: no se detectaron referencias en '## Framework File Locations'"
    return
  fi

  while IFS= read -r ref; do
    [ -z "$ref" ] && continue
    if [ ! -f "${FRAMEWORK_DIR}/${ref}.md" ]; then
      err "${project_name}: referencia inválida '${ref}' (no existe ${FRAMEWORK_DIR}/${ref}.md)"
    fi
  done <<< "$refs"
}

report_has_placeholder() {
  local file="$1"

  if grep -Eq '^- Session goal:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Files modified:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Behavior before:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Behavior after:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- SHA:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Message:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Scope:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Test cases executed:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Result:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Evidence \(commands/logs\):[[:space:]]*$' "$file"; then return 0; fi

  if grep -Fq -- '- Which operational need this session addressed.' "$file"; then return 0; fi
  if grep -Fq -- '- Why this work was prioritized now.' "$file"; then return 0; fi
  if grep -Fq -- '- Which cost/risk this session aimed to reduce.' "$file"; then return 0; fi
  if grep -Fq -- '- Initial technical diagnosis.' "$file"; then return 0; fi
  if grep -Fq -- '- Design/implementation decisions.' "$file"; then return 0; fi
  if grep -Fq -- '- Accepted tradeoffs.' "$file"; then return 0; fi
  if grep -Eq '^- Risk 1:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Risk 2:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- What to review:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Suggested reviewer agent:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Eq '^- Approval criteria:[[:space:]]*$' "$file"; then return 0; fi
  if grep -Fq -- '[Pending commit]' "$file"; then return 0; fi

  return 1
}

validate_reports() {
  if [ ! -d "$REPORTS_DIR" ]; then
    warn "No existe ${REPORTS_DIR}; se omite validación de reportes"
    return
  fi

  while IFS= read -r report_file; do
    if report_has_placeholder "$report_file"; then
      err "reporte con placeholders sin completar: ${report_file#${ROOT_DIR}/}"
    fi
  done < <(find "$REPORTS_DIR" -type f -name '*.md' | sort)
}

main() {
  if [ ! -d "$PROJECTS_DIR" ]; then
    err "No existe directorio de proyectos: ${PROJECTS_DIR}"
    exit 2
  fi

  while IFS= read -r project_file; do
    validate_project_context_files "$project_file"
    validate_project_framework_refs "$project_file"
  done < <(find "$PROJECTS_DIR" -maxdepth 1 -type f -name '*.md' | sort)

  validate_reports

  if [ "$ERRORS" -gt 0 ]; then
    echo "framework-lint: FAILED (${ERRORS} errores, ${WARNINGS} warnings)" >&2
    exit 1
  fi

  echo "framework-lint: OK (${WARNINGS} warnings)"
}

main "$@"
