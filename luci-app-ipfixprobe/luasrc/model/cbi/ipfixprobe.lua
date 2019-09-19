-- Copyright 2019 Tomas Cejka <cejkat@cesnet.cz>
-- Licensed to the public under the Apache License 2.0.

local sys = require "luci.sys"

m = Map("ipfixprobe", translate("IPFIX exporter"))

s = m:section(TypedSection, "profile", "Export profiles", "List of exporting processes")
s.anonymous = false
s.addremove = true
-- s.template = "cbi/tblsection"

nic = s:option(Value, "interface", translate("Monitored interface"))
nic.rmempty = true
local iface
for k, v in pairs(luci.sys.net.devices()) do
   nic:value(v, v)
end

pl = s:option(MultiValue, "plugins", translate("List of plugins"))
pl:value("basic", "Basic")
pl:value("http", "HTTP")
pl:value("https", "HTTPS")
pl:value("smtp", "SMTP")
pl:value("dns", "DNS")
pl:value("sip", "SIP")
pl:value("arp", "ARP")
pl:value("ntp", "NTP")
pl.delimiter = ","
pl.default = "basic"
pl.rmempty = false

link = s:option(Value, "link", translate("Observation ID"), translate("Identification of link"))
link.default = "1"
link.rmempty = false

dir = s:option(Value, "dir", translate("Interface"), translate("Identification of interface"))
dir.default = "0"
dir.rmempty = false

s:option(Value, "ipfix_collector", translate("Collector address:port"))
udp = s:option(Flag, "ipfix_udp", translate("Use UDP"))
udp.enabled = "1"
udp.disabled = "0"
udp.default = "1"
udp.rmempty = False


en = s:option(Flag, "enabled", translate("Enabled"))
en.enabled = "1"
en.disabled = "0"
en.default = "0"
en.rmempty = False

m.on_after_commit = function()
  luci.sys.call('/etc/init.d/ipfixprobe reload')
  luci.sys.call('/etc/init.d/ipfixprobe restart')
end

return m
