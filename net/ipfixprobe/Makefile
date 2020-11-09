include $(TOPDIR)/rules.mk

PKG_NAME:=ipfixprobe
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/CESNET/ipfixprobe.git
PKG_SOURCE_DATE:=2020-10-01
PKG_SOURCE_VERSION:=b0c452977ac04f199c53ad8ae83fc13fd367fdbc
PKG_MIRROR_HASH:=aac0881ba8627897b23906eabde97450178a8f9285699c0368f88a745a934b96

PKG_MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>
PKG_LICENSE:=BSD-3-Clause

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ipfixprobe
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=NEMEA
  TITLE:=IPFIX flow exporter
  URL:=https://github.com/CESNET/ipfixprobe
  DEPENDS:=+libpcap +libstdcpp
endef

define Package/ipfixprobe/description
  This NEMEA module creates biflows from input PCAP file / network interface
  and exports them to output interface.
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
	--disable-silent-rules

define Package/ipfixprobe/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/ipfixprobe $(1)/usr/bin/ipfixprobe

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init.d/ipfixprobe $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/config/ipfixprobe $(1)/etc/config/
endef

$(eval $(call BuildPackage,ipfixprobe))
