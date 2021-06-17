#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk


PKG_NAME:=nemea-modules
PKG_REV:=3abc31d
PKG_VERSION:=20-08.19
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=nemea-modules-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/CESNET/nemea-modules
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

define Package/nemea-modules/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=NEMEA
  DEPENDS:=+nemea-framework +libpthread +librt
  TITLE:=NEMEA module
  URL:=https://github.com/CESNET/nemea-modules
  MENU:=1
endef

define Package/nemea-logreplay
	$(call Package/nemea-modules/Default)
	TITLE+=logreplay
	DEPENDS+= +libstdcpp
endef
define Package/nemea-flowcounter
	$(call Package/nemea-modules/Default)
	TITLE+=flowcounter
endef
define Package/nemea-traffic_repeater
	$(call Package/nemea-modules/Default)
	TITLE+=traffic_repeater
endef
define Package/nemea-topn
	$(call Package/nemea-modules/Default)
	TITLE+=topn
endef
define Package/nemea-logger
	$(call Package/nemea-modules/Default)
	TITLE+=logger
endef
define Package/nemea-merger
	$(call Package/nemea-modules/Default)
	TITLE+=merger
endef
define Package/nemea-email_reporter
	$(call Package/nemea-modules/Default)
	TITLE+=email_reporter
	DEPENDS+=+python3 +nemea-pytrap
endef
define Package/nemea-supervisorl
	$(call Package/nemea-modules/Default)
	TITLE+=supervisorl
	DEPENDS=
endef

TARGET_CFLAGS += \
	-ffunction-sections \
	-fdata-sections

CONFIGURE_VARS += \
	ac_cv_linux_vers=$(LINUX_VERSION) \
	ac_cv_header_libusb_1_0_libusb_h=no \
	ac_cv_netfilter_can_compile=no

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-static \
	LIBS=-lm --bindir=/usr/bin/nemea --disable-silent-rules \
	--with-build-cc="$(HOSTCC)" \
	--with-flowcachesize=$(CONFIG_NEMEA_FLOW_CACHE_SIZE)

MAKE_FLAGS += \
	CCOPT="$(TARGET_CFLAGS) -I$(BUILD_DIR)/linux/include"

define Build/Configure
	$(call Build/Configure/Default)
endef

define Package/nemea-flowcounter/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/flowcounter $(1)/usr/bin/nemea/
endef
define Package/nemea-logreplay/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/logreplay $(1)/usr/bin/nemea/
endef
define Package/nemea-traffic_repeater/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/traffic_repeater $(1)/usr/bin/nemea/
endef
define Package/nemea-topn/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/topn $(1)/usr/bin/nemea/
endef
define Package/nemea-logger/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/logger $(1)/usr/bin/nemea/
endef
define Package/nemea-merger/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/merger $(1)/usr/bin/nemea/
endef
define Package/nemea-email_reporter/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/email_reporter.py $(1)/usr/bin/nemea/
endef
define Package/nemea-supervisorl/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_BIN) ./files/init.d/nemea-supervisorl $(1)/etc/init.d/
	$(INSTALL_DATA) ./files/config/nemea-supervisor $(1)/etc/config/nemea-supervisor
endef

define Package/nemea-supervisorl/conffiles
/etc/config/nemea-supervisor
endef

$(eval $(call BuildPackage,nemea-flowcounter))
$(eval $(call BuildPackage,nemea-logreplay))
$(eval $(call BuildPackage,nemea-traffic_repeater))
$(eval $(call BuildPackage,nemea-topn))
$(eval $(call BuildPackage,nemea-logger))
$(eval $(call BuildPackage,nemea-merger))
$(eval $(call BuildPackage,nemea-email_reporter))
$(eval $(call BuildPackage,nemea-supervisorl))

