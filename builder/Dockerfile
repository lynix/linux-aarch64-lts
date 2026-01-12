FROM gmanka/archlinuxarm:base-devel

RUN sed -i /etc/pacman.conf -r \
		-e 's/^SigLevel .+$/SigLevel = Never DatabaseOptional/' \
		-e 's/#DisableSandboxFilesystem/DisableSandboxFilesystem/' \
		-e 's/#DisableSandboxSyscalls/DisableSandboxSyscalls/' && \
	pacman -Sy --disable-download-timeout && \
	pacman -S --disable-download-timeout --noconfirm \
		xmlto docbook-xsl inetutils bc git uboot-tools vboot-utils dtc openssl-1.1 python && \
	rm -rf /var/cache/pacman/pkg/*
