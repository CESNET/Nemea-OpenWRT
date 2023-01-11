# NEMEA OpenWrt feed

## Description

This is an OpenWrt package feed containing primarily
[ipfixprobe](https://github.com/CESNET/ipfixprobe) IP flow exporter (monitoring
probe) and some [NEMEA system](https://github.com/CESNET/NEMEA) components to
process the flow data.

The big picture is shown in the following figure. OpenWrt devices/routers can
be deployed as monitoring probes that aggregate information about flowing
packets and extract useful information for monitoring and analysis systems. The
output of ipfixprobe running on the OpenWrt device are IP flow data that can be
exported in IPFIX data format and sent to a flow collector (storage, analysis,
intrusion/anomaly detection, visualization).

![Infrastructure with NEMEA and OpenWRT router](doc/openwrt-scheme.png)


## Usage (of this feed)

To build and use the contained packages, add the following line to the `feeds.conf` file
in the OpenWrt buildroot (https://github.com/openwrt/openwrt):

```
src-git nemea https://github.com/CESNET/Nemea-OpenWRT
```

To install package definitions, run:

```
./scripts/feeds update nemea
./scripts/feeds install -a -p nemea
```

The ipfixprobe and NEMEA packages should appear in `make menuconfig` now.

Package build can be started, e.g., using:

`make package/luci-app-ipfixprobe/compile`

`make package/ipfixprobe/compile`

(to build luci (GUI) plugin and ipfixprobe)

The results will be present in `./bin/packages/` directory of the buildroot.

Note: the build process might be found in the set up
[Github action](https://github.com/CESNET/Nemea-OpenWRT/blob/master/.github/workflows/packages.yml#L37).

