#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage:
  refresh-demo.sh <ssg|spa|api|full> [watch] [<webstir-watch-args...>]

Examples:
  refresh-demo.sh ssg
  refresh-demo.sh ssg watch --runtime frontend
  refresh-demo.sh spa watch --verbose
EOF
}

MODE="${1:-}"
if [[ -z "${MODE}" || "${MODE}" == "help" || "${MODE}" == "--help" || "${MODE}" == "-h" ]]; then
  usage
  exit 0
fi

shift

SCRIPT=""
case "${MODE}" in
  ssg )
    SCRIPT="${SCRIPT_DIR}/refresh-ssg-demo.sh"
    ;;
  spa )
    SCRIPT="${SCRIPT_DIR}/refresh-spa-demo.sh"
    ;;
  api )
    SCRIPT="${SCRIPT_DIR}/refresh-api-demo.sh"
    ;;
  full|fullstack )
    SCRIPT="${SCRIPT_DIR}/refresh-full-demo.sh"
    ;;
  * )
    echo "Unknown demo mode: ${MODE}" >&2
    usage >&2
    exit 1
    ;;
esac

exec "${SCRIPT}" "$@"

