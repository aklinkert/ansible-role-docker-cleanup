#!/usr/bin/env bash
# A role is installed by ansible-galaxy from a git archive, which rejects a symlink whose target is
# absolute or outside the role ("Invalid linkname for tarfile member"). Local tool caches such as
# .ansible/ have committed one by accident, so fail on any symlink that leaves the repo.
set -euo pipefail

cd "$(dirname "$0")/.."

root="$(pwd -P)"
fails=0
while IFS= read -r link; do
  target="$(readlink "$link")"
  case "$target" in
    /*) echo "FAIL: ${link}: absolute symlink target ${target}" >&2; fails=$((fails + 1)); continue ;;
  esac
  resolved="$(cd "$(dirname "$link")" && cd "$(dirname "$target")" 2>/dev/null && pwd -P)/$(basename "$target")" || resolved=""
  case "$resolved" in
    "$root"/*) ;;
    *) echo "FAIL: ${link}: symlink target ${target} points outside the repository" >&2; fails=$((fails + 1)) ;;
  esac
done < <(git ls-files -s | awk '$1 == 120000 { print substr($0, index($0, "\t") + 1) }')

[ "$fails" -eq 0 ] && echo "ok"
