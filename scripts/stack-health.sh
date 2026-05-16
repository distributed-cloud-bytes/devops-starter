#!/usr/bin/env bash
set -euo pipefail

REGISTRY="${SCHEMA_REGISTRY_URL:-http://localhost:18081}"

echo "Checking Schema Registry..."
curl -fsS "${REGISTRY}/subjects" >/dev/null
echo "OK: Schema Registry"

if command -v psql >/dev/null 2>&1; then
  PGPASSWORD="${POSTGRES_PASSWORD:-platform}" psql -h localhost -p "${POSTGRES_HOST_PORT:-5433}" \
    -U "${POSTGRES_USER:-platform}" -d "${POSTGRES_DB:-platform}" -c "SELECT 1" >/dev/null
  echo "OK: Postgres"
else
  echo "SKIP: psql not installed"
fi

echo "Stack health checks passed."
