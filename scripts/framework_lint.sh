#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="${ROOT_DIR}/projects"
FRAMEWORK_DIR="${ROOT_DIR}/framework"
REPORTS_DIR="${ROOT_DIR}/reports/sessions"

ERRORS=0
WARNINGS=0
SYNC=0

usage() {
  echo "Uso: $0 [--sync]"
  echo "  --sync    Sincroniza los archivos del framework hacia los proyectos según sus mapeos."
  exit 1
}

if [[ $# -gt 0 ]]; then
  if [[ "$1" == "--sync" ]]; then
    SYNC=1
  else
    usage
  fi
fi

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

# Extrae mapeos de la tabla en formato: framework_doc|project_path
extract_mappings() {
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
      val=cols[2]
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", key)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", val)
      if (key != "" && key != "Framework Doc" && key !~ /^-+$/) {
        print key "|" val
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

sync_project_framework() {
  local project_file="$1"
  local project_path
  local mappings

  project_path="$(parse_project_path "$project_file")"
  mappings="$(extract_mappings "$project_file")"

  echo "Sincronizando $(basename "$project_file" .md)..."

  while IFS='|' read -r fw_doc dest_path; do
    [ -z "$fw_doc" ] && continue
    local src="${FRAMEWORK_DIR}/${fw_doc}.md"
    local dst="${project_path}/${dest_path}"

    if [ ! -f "$src" ]; then
      err "No existe el archivo origen: $src"
      continue
    fi

    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "  -> $dest_path"
  done <<< "$mappings"

  # Sincronización de secciones en CLAUDE.md usando el script Python
  if [ -f "${ROOT_DIR}/scripts/sync_claude.py" ]; then
    python3 "${ROOT_DIR}/scripts/sync_claude.py" "${project_path}/CLAUDE.md"
    echo "  -> CLAUDE.md (sections)"
  fi
}

validate_project_framework_refs() {
  local project_file="$1"
  local project_name
  local refs

  project_name="$(basename "$project_file" .md)"
  refs="$(extract_mappings "$project_file")"

  if [ -z "$refs" ]; then
    warn "${project_name}: no se detectaron referencias en '## Framework File Locations'"
    return
  fi

  while IFS='|' read -r fw_doc dest_path; do
    [ -z "$fw_doc" ] && continue
    if [ ! -f "${FRAMEWORK_DIR}/${fw_doc}.md" ]; then
      err "${project_name}: referencia inválida '${fw_doc}' (no existe ${FRAMEWORK_DIR}/${fw_doc}.md)"
    fi
  done <<< "$refs"
}

report_has_placeholder() {
  local file="$1"
  grep -Eq '^- Session goal:[[:space:]]*$' "$file" && return 0
  grep -Eq '^- Files modified:[[:space:]]*$' "$file" && return 0
  grep -Eq '^- Behavior before:[[:space:]]*$' "$file" && return 0
  grep -Eq '^- Behavior after:[[:space:]]*$' "$file" && return 0
  grep -Fq -- '[Pending commit]' "$file" && return 0
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
    if [[ $SYNC -eq 1 ]]; then
      sync_project_framework "$project_file"
    fi
  done < <(find "$PROJECTS_DIR" -maxdepth 1 -type f -name '*.md' | sort)

  if [[ $SYNC -eq 0 ]]; then
    validate_reports
  fi

  if [ "$ERRORS" -gt 0 ]; then
    echo "framework-lint: FAILED (${ERRORS} errores, ${WARNINGS} warnings)" >&2
    exit 1
  fi

  if [[ $SYNC -eq 1 ]]; then
    echo "Sincronización completada exitosamente."
  else
    echo "framework-lint: OK (${WARNINGS} warnings)"
  fi
}

main "$@"
