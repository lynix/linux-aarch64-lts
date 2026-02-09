# linux-aarch64-lts

**aarch64 LTS Kernel package for [Arch Linux ARM](https://archlinuxarm.org)**

---

## Motivation

This repository aims at providing a kernel package for aarch64 that
follows the latest LTS branch while staying as close to upstream Arch
packaging as possible.

It is maintained as a separate project as pull requests on
[archlinuxarm/PKGBUILDs](https://github.com/archlinuxarm/PKGBUILDs) have
all been ignored.


## Usage

In order to make use of the kernel package provided by this repository there are
four options:

### Build Natively

Simply run `makepkg` from within this directory on the target device to build
natively:

    $ makepkg -s -r

### Emulated Native Build using Docker and QEMU

In _builder_ there is a `Dockerfile` and a wrapper script that enable QEMU binfmt
emulation based cross-platform builds using Docker.

The build container itself can be built using

    $ docker build --pull -t aarch64-lts-builder:latest --platform linux/arm64 builder

after which the package build process can be started using the wrapper script:

    $ ./builder/aarch64-makepkg.sh -C -c

### Cross Compilation

On an x86_64 Arch Linux host one can install `aarch64-linux-gnu-gcc` and use the
following to cross-compile the package without modification:

    $ CARCH=aarch64 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- makepkg -s -r

This may be considered somewhat unclean (even when done in a clean chroot) but
has the advantage of reducing build time drastically compared to emulated
native builds (due to the lack of binfmt emulation).

### Using Pre-Built Packages via Pacman Repository

In order to include this as a repository add the following block in
`pacman.conf`:

    [linux-aarch64-lts]
    SigLevel = Optional
    Server = https://github.com/lynix/linux-aarch64-lts/releases/latest/download

:warning: **Please note:** I can only test this package on an *Odroid C4*
and a Hetzner cloud VM as those are the only aarch64 machines I have at hand.

Use at your own risk on other platforms!


## Migrating from *linux-aarch64*

Please consider the following differences when migrating from the official
*linux-aarch64* package:

 * file names for kernel and initrd follow upstream Arch packaging, e.g. `/boot/vmlinuz-linux-aarch64-lts` instead of `/boot/Image`
 * no support for ChromeBooks


## Contributions

Pull requests are generally welcome and appreciated.

However I try to keep the number of patches against kernel sources low, so
please understand that I won't accept everything (e.g. patches for niche SBCs
that are not supported by mainline).
