# Heimdall-patched Frigate image

This image patches [Frigate](https://github.com/blakeblackshear/frigate) so its
model/API integration points to a self-hosted
[Heimdall Vision](https://github.com/torsteinelv/heimdall-vision) instance
instead of `https://api.frigate.video`.

Published publicly to `ghcr.io/torsteinelv/heimdall-frigate` so anyone
self-hosting Heimdall + Frigate can pull it without needing access to
Heimdall's own (private) source repo.

## Tags

- `latest` / `stable-tensorrt` - rebuilt nightly, tracks Frigate's own moving
  `stable-tensorrt` release.
- `<frigate-version>-tensorrt` (e.g. `0.18.0-beta1-tensorrt`) - a specific
  pinned Frigate version, including pre-releases. Built automatically when a
  new Frigate GitHub release is detected, or on demand via
  `workflow_dispatch`.

## Default patched endpoint

```text
https://heimdall-vision.com
```

## Local build

```bash
docker build . \
  --build-arg FRIGATE_VERSION=0.17.0-tensorrt \
  --build-arg HEIMDALL_FRIGATE_API_URL=https://your-heimdall-instance.example \
  -t ghcr.io/YOUR_ORG/YOUR_REPO-frigate:latest
```

Use the generated Frigate plugin username/password from your Heimdall
instance's GUI against this patched image.
