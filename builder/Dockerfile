FROM gmanka/archlinuxarm:base-devel

RUN sed -i /etc/pacman.conf -re 's/^SigLevel .+$/SigLevel = Never DatabaseOptional/' && \
	pacman -Sy --disable-download-timeout && \
	pacman -S --disable-download-timeout --noconfirm \
		xmlto docbook-xsl inetutils bc git uboot-tools vboot-utils dtc openssl-1.1 python && \
	rm -rf /var/cache/pacman/pkg/*
