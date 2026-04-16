#!/bin/bash

#
# Containerized Arch Linux ARM aarch64 makepkg wrapper
#

set -e

readonly ENGINE="${ENGINE:-podman}"
readonly CONTAINER_ARCH='linux/arm64'
readonly CONTAINER_IMG="${IMAGE:-aarch64-lts-builder:latest}"
readonly CONTAINER_ULIMIT='nofile=1024:524288'
readonly WORK_DIR='/work'


if ! [ -r "PKGBUILD" ]; then
	echo "error: unable to read 'PKGBUILD'"
	exit 1
fi

if tty -s; then
	INTERACTIVE="-i"
fi

if [ "$ENGINE" == "podman" ]; then
	UIDMAP="--userns=keep-id:uid=1000,gid=1000"
elif [ "$ENGINE" == "docker" ]; then
	UIDMAP="--user $(id -u ):$(id -g)"
fi

exec $ENGINE run \
	-t $INTERACTIVE --rm \
	--log-driver=none \
	$UIDMAP \
	--ulimit $CONTAINER_ULIMIT \
	--platform $CONTAINER_ARCH \
	--mount type=bind,source=/etc/ca-certificates,destination=/etc/ca-certificates,ro=true \
	--mount type=bind,source=/etc/ssl,destination=/etc/ssl,ro=true \
	--mount type=bind,source=$(pwd),destination=$WORK_DIR \
	--workdir $WORK_DIR \
	--env PACKAGER="$PACKAGER" \
	--env MAKEFLAGS="-j$(nproc)" \
	$CONTAINER_IMG /usr/bin/makepkg $@
