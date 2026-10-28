#!/usr/bin/env bash
# A script template must start with its shebang at byte 0: the kernel rejects anything else with
# "Exec format error" (the comment from `ansible_managed` used to come first).
set -euo pipefail

cd "$(dirname "$0")/.."

fails=0
for tpl in templates/*.sh; do
  rendered="$(mktemp)"
  sed 's/{{ *ansible_managed *}}/Ansible managed/' "$tpl" >"$rendered"
  if [ "$(head -c 2 "$rendered")" != '#!' ]; then
    echo "FAIL: ${tpl}: does not start with '#!'" >&2
    fails=$((fails + 1))
  fi
  bash -n "$rendered" || fails=$((fails + 1))
  rm -f "$rendered"
done

[ "$fails" -eq 0 ] && echo "ok"
