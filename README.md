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

 * [limited](https://github.com/lynix/linux-aarch64-lts/pull/3) support for Chromebooks
 * file names for kernel and initrd follow upstream Arch packaging, e.g. `/boot/vmlinuz-linux-aarch64-lts` instead of `/boot/Image`


## Contributions

Pull requests are generally welcome and appreciated.

However I try to keep the number of patches against kernel sources low, so
please understand that I won't accept everything (e.g. patches for niche SBCs
that are not supported by mainline).
