FROM scratch AS stage1

ARG ROOTFS_URL=http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz
ARG MIRROR=http://mirror.archlinuxarm.org/\$arch/\$repo
ADD --unpack ${ROOTFS_URL} /

RUN pacman-key --init && \
	pacman-key --populate archlinuxarm && \
	sed -i /etc/pacman.conf -r \
		-e 's/^SigLevel .+$/SigLevel = Never DatabaseOptional/' \
		-e 's/#DisableSandboxFilesystem/DisableSandboxFilesystem/' \
		-e 's/#DisableSandboxSyscalls/DisableSandboxSyscalls/' && \
	echo "Server = ${MIRROR}" > /etc/pacman.d/mirrorlist && \
	pacman -Rs --noconfirm \
		linux-aarch64 \
		linux-firmware \
		dhcpcd \
		nano && \
	pacman -Syu --disable-download-timeout --noconfirm && \
	rm -rf /var/cache/pacman/pkg/*


FROM scratch AS stage2

COPY --from=stage1 / /
RUN pacman -S --disable-download-timeout --noconfirm \
		base-devel \
		git \
		bc \
		uboot-tools \
		dtc \
		xmlto \
		docbook-xsl \
		python \
		inetutils && \
	rm -rf /var/cache/pacman/pkg/*
