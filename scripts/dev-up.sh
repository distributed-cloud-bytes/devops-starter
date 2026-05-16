#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../environments/dev/compose"
docker compose up -d
docker compose ps
