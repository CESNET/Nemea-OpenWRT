#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk


PKG_NAME:=nemea-modules
PKG_REV:=7f2d14dc9946c4f01b4187761b0b97e8a594b8f5
PKG_VERSION:=$(PKG_REV)
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

define Package/nemea-modules
  SECTION:=nemea
  CATEGORY:=NEMEA
  DEPENDS:=+nemea-framework +libpcap +libpthread +librt +libstdcpp
  TITLE:=NEMEA system modules
  URL:=https://github.com/CESNET/nemea-modules
  MENU:=1
endef

define Package/nemea-modules/description
This package contains base modules of the NEMEA system.
endef

define Package/nemea-modules/config
	source "$(SOURCE)/Config.in"
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
	--with-flowcachesize=$(CONFIG_FLOW_CACHE_SIZE)

MAKE_FLAGS += \
	CCOPT="$(TARGET_CFLAGS) -I$(BUILD_DIR)/linux/include"

define Build/Configure
	$(call Build/Configure/Default)
endef

define Package/nemea-modules/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/* $(1)/usr/bin/nemea/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./init.d/flow_meter $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./config/flow_meter $(1)/etc/config/
endef

$(eval $(call BuildPackage,nemea-modules))
