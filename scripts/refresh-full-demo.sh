#!/usr/bin/env bash
set -euo pipefail

# Recreate the fullstack-app demo by clearing its contents and running init.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMOS_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
WORKSPACE_ROOT="$(cd "${DEMOS_ROOT}/.." && pwd)"
DEMO_DIR="${DEMOS_ROOT}/fullstack-app"

usage() {
  cat <<'EOF'
Usage:
  refresh-full-demo.sh [watch] [<webstir-watch-args...>]

Examples:
  refresh-full-demo.sh
  refresh-full-demo.sh watch
  refresh-full-demo.sh watch --verbose
EOF
}

WATCH=0

case "${1:-}" in
  "" ) ;;
  -h|--help|help )
    usage
    exit 0
    ;;
  watch )
    WATCH=1
    shift
    ;;
  * )
    echo "Unknown argument: ${1}" >&2
    usage >&2
    exit 1
    ;;
esac

echo "Refreshing Fullstack demo at ${DEMO_DIR}..."
mkdir -p "${DEMO_DIR}"

# Remove everything inside the demo directory (including dotfiles), but keep the folder.
rm -rf "${DEMO_DIR}/"{*,.[!.]*,..?*} 2>/dev/null || true

(
  cd "${WORKSPACE_ROOT}"
  dotnet run --project webstir-dotnet/CLI -- init full "${DEMO_DIR}"
)

echo "Done. Reinitialized fullstack-app."

if [[ "${WATCH}" -eq 1 ]]; then
  echo "Starting watch for ${DEMO_DIR}..."
  cd "${WORKSPACE_ROOT}"
  exec dotnet run --project webstir-dotnet/CLI -- watch "$@" "${DEMO_DIR}"
fi

