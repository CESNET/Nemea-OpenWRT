-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.ipfixprobe", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ipfixprobe") then
		return
	end

	local page

	page = entry({"admin", "services", "ipfixprobe"}, cbi("ipfixprobe"), _("IPFIX export"))
	page.dependent = true
end
