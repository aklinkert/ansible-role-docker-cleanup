# {{ ansible_managed }}

#!/usr/bin/env bash

set -e

docker system prune -af

echo "Done"
