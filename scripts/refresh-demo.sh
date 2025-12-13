#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMOS_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
WORKSPACE_ROOT="$(cd "${DEMOS_ROOT}/.." && pwd)"

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

WATCH=0
case "${1:-}" in
  watch )
    WATCH=1
    shift
    ;;
esac

INIT_MODE=""
DEMO_FOLDER=""
case "${MODE}" in
  ssg )
    INIT_MODE="ssg"
    DEMO_FOLDER="ssg-site"
    ;;
  spa )
    INIT_MODE="spa"
    DEMO_FOLDER="spa-frontend"
    ;;
  api )
    INIT_MODE="api"
    DEMO_FOLDER="backend-api"
    ;;
  full|fullstack )
    INIT_MODE="full"
    DEMO_FOLDER="fullstack-app"
    ;;
  * )
    echo "Unknown demo mode: ${MODE}" >&2
    usage >&2
    exit 1
    ;;
esac

DEMO_DIR="${DEMOS_ROOT}/${DEMO_FOLDER}"

echo "Refreshing ${MODE} demo at ${DEMO_DIR}..."
mkdir -p "${DEMO_DIR}"

# Remove everything inside the demo directory (including dotfiles), but keep the folder.
rm -rf "${DEMO_DIR}/"{*,.[!.]*,..?*} 2>/dev/null || true

(
  cd "${WORKSPACE_ROOT}"
  dotnet run --project webstir-dotnet/CLI -- init "${INIT_MODE}" "${DEMO_DIR}"
)

echo "Done. Reinitialized ${DEMO_FOLDER}."

if [[ "${WATCH}" -eq 1 ]]; then
  echo "Starting watch for ${DEMO_DIR}..."
  cd "${WORKSPACE_ROOT}"
  exec dotnet run --project webstir-dotnet/CLI -- watch "$@" "${DEMO_DIR}"
fi
