#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk


PKG_NAME:=ipfixprobe
PKG_REV:=f2b7fc1

PKG_VERSION:=2.17.1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=ipfixprobe-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/CESNET/ipfixprobe
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_REV).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_FIXUP:=autoreconf


PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=COPYING

PKG_MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ipfixprobe
  SECTION:=net
  CATEGORY:=Network
  #SUBMENU:=P4_exporter
  DEPENDS:=+libpcap +libstdcpp
  TITLE:=IPFIX flow exporter
  URL:=https://github.com/CESNET/ipfixprobe
  MENU:=1
endef

define Package/ipfixprobe/config
	source "$(SOURCE)/Config.in"
endef

define Package/conffiles/ipfixprobe
/etc/config/ipfixprobe
endef

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	--disable-silent-rules

define Build/Configure
	$(call Build/Configure/Default)
endef

define Package/ipfixprobe/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/ipfixprobe $(1)/usr/bin/nemea/ipfixprobe

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init.d/ipfixprobe $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/config/ipfixprobe $(1)/etc/config/
endef

$(eval $(call BuildPackage,ipfixprobe))
