#!/usr/bin/env bash
set -euo pipefail

# Recreate the ssg-site demo by clearing its contents and running init.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMOS_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
WORKSPACE_ROOT="$(cd "${DEMOS_ROOT}/.." && pwd)"
DEMO_DIR="${DEMOS_ROOT}/ssg-site"

echo "Refreshing SSG demo at ${DEMO_DIR}..."
mkdir -p "${DEMO_DIR}"

# Remove everything inside the demo directory (including dotfiles), but keep the folder.
rm -rf "${DEMO_DIR}/"{*,.[!.]*,..?*} 2>/dev/null || true

(
  cd "${WORKSPACE_ROOT}"
  dotnet run --project webstir-dotnet/CLI -- init ssg "${DEMO_DIR}"
)

echo "Done. Reinitialized ssg-site."
