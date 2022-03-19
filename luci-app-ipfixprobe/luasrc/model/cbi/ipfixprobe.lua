-- Copyright 2019 Tomas Cejka <cejkat@cesnet.cz>
-- Licensed to the public under the Apache License 2.0.

local sys = require "luci.sys"

m = Map("ipfixprobe", translate("IPFIX exporter"))

s = m:section(TypedSection, "profile", "Export profiles", "List of exporting processes")
s.anonymous = false
s.addremove = true

s:tab("main", "Main options")
s:tab("ipfix", "IPFIX Collector")
s:tab("advanced", "Advanced options")

-- s.template = "cbi/tblsection"

nic = s:taboption("main", DynamicList, "interfaces", translate("Monitored interface"))
nic.rmempty = true
local iface
for k, v in pairs(luci.sys.net.devices()) do
   nic:value(v, v)
end

pl = s:taboption("main", DynamicList, "plugins", translate("List of plugins"), translate("Enable one or more processing plugins. Plugin with parameters must be entered as a custom string, see manual of ipfixprobe for details - https://github.com/CESNET/ipfixprobe/"))
pl:value("basic", "Basic")
pl:value("bstats", "BSTATS (burst packet stats)")
pl:value("dns", "DNS")
pl:value("dnssd", "DNS-Service Discovery")
pl:value("dnssd:txt", "DNS-Service Discovery with extexded TXT")
pl:value("http", "HTTP")
pl:value("idpcontent", "IDPCONTENT (initial data packets content)")
pl:value("netbios", "Netbios")
pl:value("ntp", "NTP")
pl:value("ovpn", "OpenVPN")
pl:value("passivedns", "Passive DNS (dumped DNS data)")
pl:value("phists", "PHISTS (packet histograms - payload sizes and interpacket times)")
pl:value("pstats", "PSTATS (Per-Packet-Information)")
pl:value("quic", "QUIC")
pl:value("rtsp", "RTSP")
pl:value("sip", "SIP")
pl:value("smtp", "SMTP")
pl:value("ssdp", "SSDP")
pl:value("tls", "TLS")
pl:value("wg", "WireGuard")

pl.rmempty = false

splitbiflow = s:taboption("main", Flag, "split_biflow", translate("Split biflow"))
splitbiflow.enabled = "1"
splitbiflow.disabled = "0"
splitbiflow.default = "0"
splitbiflow.rmempty = false
en = s:taboption("main", Flag, "enabled", translate("Enabled"))
en.enabled = "1"
en.disabled = "0"
en.default = "0"
en.rmempty = false

ipfix_host = s:taboption("ipfix", Value, "ipfix_host", translate("IPFIX Collector address"))
ipfix_host.datatype = "host"
ipfix_port = s:taboption("ipfix", Value, "ipfix_port", translate("IPFIX Collector port"))
ipfix_port.datatype = "port"
udp = s:taboption("ipfix", Flag, "ipfix_udp", translate("Use UDP"))
udp.enabled = "1"
udp.disabled = "0"
udp.default = "1"
udp.rmempty = false
link = s:taboption("ipfix", Value, "link", translate("Observation ID"), translate("Identification of link"))
link.default = "1"
link.rmempty = false
dir = s:taboption("ipfix", Value, "dir", translate("Interface"), translate("Identification of interface"))
dir.default = "0"
dir.rmempty = false

raw_blocks = s:taboption("advanced", Value, "raw_blocks", translate("Number of blocks"), translate("Number of allocated blocks for capturing from NIC"))
raw_blocks.default = "3"

raw_packetsinblock = s:taboption("advanced", Value, "raw_packetsinblock", translate("Packets in block"), translate("Number of packets in a block read from NIC"))
raw_packetsinblock.default = "10"

active_timeout = s:taboption("advanced", Value, "active_timeout", translate("Active timeout"), translate("Split long flows into at most N seconds flow records"))
active_timeout.default = "300"

inactive_timeout = s:taboption("advanced", Value, "inactive_timeout", translate("Inactive timeout"), translate("Export a flow record after N seconds of inactivity"))
inactive_timeout.default = "30"

cache_size = s:taboption("advanced", Value, "cache_size", translate("Size of flow cache"), translate("Number of entries given by an exponent 2**N"))
cache_size.default = "10"

cache_line = s:taboption("advanced", Value, "cache_line", translate("Size of flow cache line"), translate("Number of entries given by an exponent 2**N"))
cache_line.default = "2"

respawn = s:taboption("advanced", Flag, "respawn", translate("Respawn"))
respawn.enabled = "1"
respawn.disabled = "0"
respawn.default = "1"

respawn_threshold = s:taboption("advanced", Value, "respawn_threshold", translate("Respawn threshold"))
respawn_threshold.default = "3600"

respawn_timeout = s:taboption("advanced", Value, "respawn_timeout", translate("Respawn timeout"))
respawn_timeout.default = "5"

respawn_retry = s:taboption("advanced", Value, "respawn_retry", translate("Respawn retry"))
respawn_retry.default = "5"

core = s:taboption("advanced", Flag, "core", translate("Core dumps"))
core.enabled = "1"
core.disabled = "0"
core.default = "0"

m.on_after_commit = function()
  luci.sys.call('/etc/init.d/ipfixprobe reload')
  luci.sys.call('/etc/init.d/ipfixprobe restart')
end

return m
