#!/bin/bash

#
# Dockerized Arch Linux ARM aarch64 makepkg wrapper
#

set -e

readonly DOCKER_ARCH='linux/arm64'
readonly DOCKER_IMG="${IMAGE:-aarch64-lts-builder:latest}"
readonly DOCKER_ULIMIT='nofile=1024:524288'
readonly WORK_DIR='/work'


if ! [ -r "PKGBUILD" ]; then
	echo "error: unable to read 'PKGBUILD'"
	exit 1
fi

if tty -s; then
	INTERACTIVE="-i"
fi


exec docker run \
	-t $INTERACTIVE --rm \
	--log-driver=none \
	--ulimit $DOCKER_ULIMIT \
	--platform $DOCKER_ARCH \
	--user $(id -u):$(id -g) \
	--mount type=bind,source=/etc/ca-certificates,destination=/etc/ca-certificates,ro=true \
	--mount type=bind,source=/etc/ssl,destination=/etc/ssl,ro=true \
	--mount type=bind,source=$(pwd),destination=$WORK_DIR \
	--workdir $WORK_DIR \
	--env PACKAGER="$PACKAGER" \
	--env MAKEFLAGS="-j$(nproc)" \
	$DOCKER_IMG /usr/bin/makepkg $@
