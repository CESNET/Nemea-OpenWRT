include $(TOPDIR)/rules.mk

PKG_NAME:=ipfixprobe
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/CESNET/ipfixprobe.git
PKG_SOURCE_DATE:=2022-12-14
PKG_SOURCE_VERSION:=v4.7.1
PKG_MIRROR_HASH:=bc794db92ce3cc24bc54c76f31594c59f192957241f3b54385a843aa3ab02d21

PKG_MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>
PKG_LICENSE:=BSD-3-Clause

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ipfixprobe
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libstdcpp +libatomic +IPFIXPROBE_QUIC:libopenssl +IPFIXPROBE_PCAP:libpcap +IPFIXPROBE_NEMEA:nemea-framework
  TITLE:=IPFIX flow exporter
  URL:=https://github.com/CESNET/ipfixprobe
endef

define Package/ipfixprobe/description
  The ipfixprobe tool is a flow exporter that creates bi-directional IP flows (biflows) from packets captured via network interface
  and and exports them to IPFIX flow collector. It is capable of plugins to enrich IPFIX data with application information and statistics
  of network communication - connections.
endef

define Package/ipfixprobe/config
	source "$(SOURCE)/Config.in"
endef

define Package/ipfixprobe/conffiles
/etc/config/ipfixprobe
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-silent-rules \
	--with-flowcachesize=$(CONFIG_IPFIXPROBE_FLOW_CACHE_SIZE) \
	--with-flowlinesize=$(CONFIG_IPFIXPROBE_FLOW_CACHELINE_SIZE)

ifeq ($(CONFIG_IPFIXPROBE_PCAP),y)
  CONFIGURE_ARGS += --with-pcap
endif

ifeq ($(CONFIG_IPFIXPROBE_QUIC),y)
  CONFIGURE_ARGS += --with-quic
endif

ifeq ($(CONFIG_IPFIXPROBE_NEMEA),y)
  CONFIGURE_ARGS += --with-nemea
endif

define Package/ipfixprobe/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/ipfixprobe $(1)/usr/bin/ipfixprobe
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/ipfixprobe_stats $(1)/usr/bin/ipfixprobe_stats

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init.d/ipfixprobe $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/config/ipfixprobe $(1)/etc/config/
endef

$(eval $(call BuildPackage,ipfixprobe))

