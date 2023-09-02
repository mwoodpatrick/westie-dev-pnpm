#!/usr/bin/env bash
#
# Use --build-arg BUILDKIT_INLINE_CACHE=1 so that the built image can be used as a cache source for subsequent builds

sudo docker buildx build --load --build-arg BUILDKIT_INLINE_CACHE=1 -f /mnt/wsl/projects/git/westie-dev-pnpm/.devcontainer/archlinux/Dockerfile -t westie-arch-dev:latest --build-arg _DEV_CONTAINERS_BASE_IMAGE=dev_container_auto_added_stage_label /mnt/wsl/projects/git/westie-dev-pnpm/.devcontainer/archlinux
