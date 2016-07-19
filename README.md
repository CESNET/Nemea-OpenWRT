# Nemea OpenWrt feed

## Description

This is an OpenWrt package feed containing nemea system.

## Usage

To use these packages, add the following line to the feeds.conf
in the OpenWrt buildroot:

```
src-git nemea https://github.com/CESNET/Nemea-OpenWRT
```

To install package definitions, run:

```
./scripts/feeds update nemea
./scripts/feeds install -a -p nemea
```

The nemea packages should now appear in menuconfig.
