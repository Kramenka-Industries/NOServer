#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-noserver}"
IMAGE_TAG="${IMAGE_TAG:-latest}"
RCON_TOOLS_REF="${RCON_TOOLS_REF:-main}"
STEAM_APP_ID="${STEAM_APP_ID:-3930080}"

docker build \
    --pull \
    --build-arg RCON_TOOLS_REF="${RCON_TOOLS_REF}" \
    --build-arg STEAM_APP_ID="${STEAM_APP_ID}" \
    -t "${IMAGE_NAME}:${IMAGE_TAG}" \
    .