#!/usr/bin/env bash
# {{ ansible_managed }}

set -euo pipefail

docker system prune -af

echo "Done"
