# Heimdall-patched Frigate image.
#
# This keeps Frigate's built-in model API/client code, but redirects the official
# Frigate API base URL to your Heimdall Frigate-compatible API.
#
# Build args can be overridden in GitHub Actions or locally:
#   docker build . \
#     --build-arg FRIGATE_VERSION=0.17.0-tensorrt \
#     --build-arg HEIMDALL_FRIGATE_API_URL=https://heimdall-vision.com

ARG FRIGATE_VERSION=0.17.0-tensorrt
FROM ghcr.io/blakeblackshear/frigate:${FRIGATE_VERSION}

ARG HEIMDALL_FRIGATE_API_URL=https://heimdall-vision.com

USER root

# Patch Frigate's API endpoint. Avoid installing debug packages in production.
RUN set -eux; \
    test -f /opt/frigate/frigate/const.py; \
    grep -q 'https://api.frigate.video' /opt/frigate/frigate/const.py; \
    sed -i "s|https://api.frigate.video|${HEIMDALL_FRIGATE_API_URL}|g" /opt/frigate/frigate/const.py; \
    grep -q "${HEIMDALL_FRIGATE_API_URL}" /opt/frigate/frigate/const.py

LABEL org.opencontainers.image.title="Heimdall patched Frigate"
LABEL org.opencontainers.image.description="Frigate image patched to use Heimdall's Frigate-compatible API endpoint"
