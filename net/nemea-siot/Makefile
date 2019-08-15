#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk


PKG_NAME:=nemea-siot
PKG_REV:=dd3b9a73af68aa54857b38ed18320c5078f08523

PKG_VERSION:=19-08.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=nemea-siot-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/CESNET/nemea-siot
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

define Package/nemea-siot/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=NEMEA-SIoT
  DEPENDS:=+nemea-framework +libpthread +librt
  TITLE:=NEMEA SIoT modules
  URL:=https://github.com/CESNET/nemea-siot
  MENU:=1
endef

define Package/nemea-ble_pairing
	$(call Package/nemea-siot/Default)
	TITLE+=BLE pairing detector
	DEPENDS+= +libstdcpp +bluez-libs
endef
define Package/nemea-ble_hci_collector
	$(call Package/nemea-siot/Default)
	TITLE+=BLE HCI collector
	DEPENDS+= +libstdcpp +bluez-libs
endef
define Package/nemea-lora-airtime
	$(call Package/nemea-siot/Default)
	TITLE+=LoRaWAN Airtime regulations
endef
define Package/nemea-lora-distance
	$(call Package/nemea-siot/Default)
	TITLE+=LoRaWAN detection of distance change
endef
define Package/nemea-lora-replay-abp
	$(call Package/nemea-siot/Default)
	TITLE+=LoRaWAN Replay attack ABP detection
endef
define Package/nemea-wsn-detector
	$(call Package/nemea-siot/Default)
	TITLE+=Wireless Sensor Network Detector (based on time series)
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
	--with-build-cc="$(HOSTCC)"

MAKE_FLAGS += \
	CCOPT="$(TARGET_CFLAGS) -I$(BUILD_DIR)/linux/include"

define Build/Configure
	$(call Build/Configure/Default)
endef

define Package/nemea-ble_pairing/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-ble-pairing $(1)/usr/bin/nemea/
endef
define Package/nemea-ble_hci_collector/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-hci-collector $(1)/usr/bin/nemea/
endef
define Package/nemea-lora-airtime/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-lora-airtime $(1)/usr/bin/nemea/
endef
define Package/nemea-lora-distance/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-lora-distance $(1)/usr/bin/nemea/
endef
define Package/nemea-lora-replay-abp/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-lora-replay $(1)/usr/bin/nemea/
endef
define Package/nemea-wsn-detector/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-wsn-anomaly $(1)/usr/bin/nemea/
endef

$(eval $(call BuildPackage,nemea-ble_pairing))
$(eval $(call BuildPackage,nemea-ble_hci_collector))
$(eval $(call BuildPackage,nemea-lora-airtime))
$(eval $(call BuildPackage,nemea-lora-distance))
$(eval $(call BuildPackage,nemea-lora-replay-abp))
$(eval $(call BuildPackage,nemea-wsn-detector))

