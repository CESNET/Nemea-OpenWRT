# NEMEA OpenWrt feed

## Description
This OpenWrt package feed contains parts that are necessary for the SIoT project but are not ready to be deployed on the Turris Omnia router without certain changes. 

Conditions for the pull request to master branch include:
* Newer version of glib (2.58.3 or newer) in Turris OS
* Poco libraries from [newer commit](https://github.com/openwrt/packages/commit/4712deffa57c9f919b1e60238daff7d164f6a695) in Turris OS

Besides [NEMEA system](https://github.com/CESNET/Nemea) components and P4 generated [IPFIX exporter](https://github.com/CESNET/NEMEA-Probe) for exporting flow data, this Openwrt package feed contains [BeeeOn gateway] (https://github.com/BeeeOn/gateway).

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
