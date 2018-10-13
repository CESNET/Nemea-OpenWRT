# NEMEA OpenWrt feed

## Description

This is an OpenWrt package feed containing [NEMEA system](https://github.com/CESNET/Nemea) components for exporting flow data.

![Infrastructure with NEMEA and OpenWRT router](doc/openwrt-scheme.png)

The figure above shows OpenWRT router with running NEMEA flow exporter [flow_meter](https://github.com/CESNET/Nemea-Modules/tree/master/flow_meter).
Since OpenWRT routers usually use big-endian architecture, it is necessary to use a special module [endiverter](https://github.com/CESNET/Nemea-Modules/tree/master/endiverter) that converts values of UniRec fields to the byte-order that is used on x86 architecture.
Due to performace reasons, this conversion is not done automatically in libtrap nor UniRec.

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

The NEMEA packages should now appear in `make menuconfig`.

## Munin

NEMEA module flow_meter can report statistics using munin client. See [this guide](https://github.com/CESNET/Nemea-OpenWRT/tree/master/net/nemea-modules/munin/README.md).
