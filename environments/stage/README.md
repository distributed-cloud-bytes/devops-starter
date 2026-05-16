# Stage environment

Placeholder for non-production validation overlays (Compose, Kustomize, or Helm).

Recommended contents when you add this environment:

- Image tags pinned by CI
- Stricter resource limits
- Secrets from your secret store (not committed here)

Promotion flow: `dev` → `stage` → `prod`.
