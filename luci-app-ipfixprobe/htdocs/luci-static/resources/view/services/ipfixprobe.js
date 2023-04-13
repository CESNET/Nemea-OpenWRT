'use strict';
'require ui';
'require uci';
'require view';
'require form';
'require validation';
'require tools.widgets as widgets';

function validatePowerOf2(sid, s) {
	if (s == null || s == '')
		return true;

	var x = validation.parseInteger(s);

	if (isNaN(x) || x < 1) {
		// Must be unsigned integer
		return _('Expecting: positive integer value');
	}

	if (Math.log2(x) % 1 !== 0) {
		// Must be power of 2
		return _('Expecting: power of 2, e.g. 16, 128, 2048,...');
	}

	return true;
}

return view.extend({
	render: function(data) {
		var m, s, o;

		m = new form.Map('ipfixprobe', _('IPFIX exporter'));

		s = m.section(form.TypedSection, 'profile', 'Export profiles', 'List of exporting processes');
		s.anonymous = false;
		s.addremove = true;

		s.tab('main', 'Main options');
		s.tab('ipfix', 'IPFIX Collector');
		s.tab('advanced', 'Advanced options');

		o = s.taboption('main', form.Flag, 'enabled', _('Enabled'));
		o.default = '0';
		o.rmempty = false;

		o = s.taboption('main', widgets.DeviceSelect, 'interfaces', _('Monitored interface'));
		o.multiple = true;
		o.noaliases = true;
		o.rmempty = false;

		o = s.taboption('main', form.DynamicList, 'plugins', _('List of plugins'),
			_('Enable one or more processing plugins. Plugin with parameters must be entered as a custom string, see manual of ipfixprobe for details - <a href="https://github.com/CESNET/ipfixprobe/" target="_blank">https://github.com/CESNET/ipfixprobe/</a>'));
		o.rmempty = false;
		o.value('basic', 'Basic');
		o.value('bstats', 'BSTATS (burst packet stats)');
		o.value('dns', 'DNS');
		o.value('dnssd', 'DNS-Service Discovery');
		o.value('dnssd;txt', 'DNS-Service Discovery with extexded TXT');
		o.value('http', 'HTTP');
		o.value('idpcontent', 'IDPCONTENT (initial data packets content)');
		o.value('netbios', 'Netbios');
		o.value('ntp', 'NTP');
		o.value('ovpn', 'OpenVPN');
		o.value('passivedns', 'Passive DNS (dumped DNS data)');
		o.value('phists', 'PHISTS (packet histograms - payload sizes and interpacket times)');
		o.value('pstats', 'PSTATS (Per-Packet-Information)');
		o.value('quic', 'QUIC');
		o.value('rtsp', 'RTSP');
		o.value('sip', 'SIP');
		o.value('smtp', 'SMTP');
		o.value('ssdp', 'SSDP');
		o.value('tls', 'TLS');
		o.value('wg', 'WireGuard');

		o = s.taboption('main', form.Flag, 'split_biflow', _('Split biflow'));
		o.default = '0';
		o.rmempty = false;

		o = s.taboption('ipfix', form.Value, 'ipfix_host', _('IPFIX Collector address'));
		o.datatype = 'host';

		o = s.taboption('ipfix', form.Value, 'ipfix_port', _('IPFIX Collector port'));
		o.datatype = 'port';

		o = s.taboption('ipfix', form.Value, 'ipfix_mtu', _('IPFIX Collector MTU'));
		o.datatype = 'uinteger';
		o.default = '1452';
		o.rmempty = false;

		o = s.taboption('ipfix', form.Flag, 'ipfix_udp', _('Use UDP'));
		o.default = '1';
		o.rmempty = false;

		o = s.taboption('ipfix', form.Value, 'link', _('Observation ID'), _('Identification of link'));
		o.datatype = 'uinteger';
		o.default = '1';
		o.rmempty = false;

		o = s.taboption('ipfix', form.Value, 'dir', _('Interface'), _('Identification of interface'));
		o.datatype = 'uinteger';
		o.default = '0';
		o.rmempty = false;

		o = s.taboption('advanced', form.Value, 'active_timeout', _('Active timeout'),
			_('Split long flows into at most N seconds flow records.'));
		o.datatype = 'uinteger';
		o.default = '300';

		o = s.taboption('advanced', form.Value, 'inactive_timeout', _('Inactive timeout'),
			_('Export a flow record after N seconds of inactivity.'));
		o.datatype = 'uinteger';
		o.default = '30';

		o = s.taboption('advanced', form.Value, 'raw_blocks', _('Number of blocks'),
			_('Number of allocated blocks for capturing from NIC.'));
		o.datatype = 'uinteger';
		o.default = '2';

		o = s.taboption('advanced', form.Value, 'raw_packetsinblock', _('Packets in block'),
			_('Number of packets in a block read from NIC.'));
		o.datatype = 'uinteger';
		o.default = '10';

		o = s.taboption('advanced', form.Value, 'cache_size', _('Size of flow cache'),
			_('Number of entries. Must be power of 2 (i.e. 2**N).'));
		o.default = '1024';
		o.validate = validatePowerOf2;

		o = s.taboption('advanced', form.Value, 'cache_line', _('Size of flow cache line'),
			_('Number of entries. Must be power of 2 (i.e. 2**N).'));
		o.default = '4';
		o.validate = validatePowerOf2;

		o = s.taboption('advanced', form.Flag, 'respawn', _('Respawn'),
			_('Enable respawn of crashed process.'));
		o.default = '1';

		o = s.taboption('advanced', form.Value, 'respawn_threshold', _('Respawn threshold'),
			_('Timeout in seconds for restarting a service after it closes.'));
		o.datatype = 'uinteger';
		o.default = '3600';

		o = s.taboption('advanced', form.Value, 'respawn_timeout', _('Respawn timeout'),
			_('Maximum time in seconds to wait for a process respawn to complete.'));
		o.datatype = 'uinteger';
		o.default = '5';

		o = s.taboption('advanced', form.Value, 'respawn_retry', _('Respawn retry'),
			_('Maximum number of times to attempt respawning before giving up, 0 means never stop trying to respawn.'));
		o.datatype = 'uinteger';
		o.default = '5';

		o = s.taboption('advanced', form.Flag, 'core', _('Core dumps'));
		o.default = '0';

		return m.render();
	}
})
