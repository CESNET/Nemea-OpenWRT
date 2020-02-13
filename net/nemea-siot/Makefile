include $(TOPDIR)/rules.mk

PKG_NAME:=nemea-siot
PKG_VERSION:=20-01.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/CESNET/nemea-siot.git
PKG_SOURCE_VERSION:=5000cebad99631b071f4c61aab67ed09e0b98bed
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_SOURCE_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_SOURCE_VERSION)

PKG_MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/nemea-siot/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=NEMEA
  TITLE:=NEMEA SIoT modules
  URL:=https://github.com/CESNET/nemea-siot
  DEPENDS:=+nemea-framework +libpthread +librt
endef

define Package/siot-ble-pairing
  $(call Package/nemea-siot/Default)
  TITLE:=BLE pairing detector
  DEPENDS+= +libstdcpp +bluez-libs
endef

define Package/siot-hci-collector
  $(call Package/nemea-siot/Default)
  TITLE:=BLE HCI collector
  DEPENDS+= +libstdcpp +bluez-libs
endef

define Package/siot-lora-airtime
  $(call Package/nemea-siot/Default)
  TITLE:=LoRaWAN Airtime regulations
endef

define Package/siot-lora-distance
  $(call Package/nemea-siot/Default)
  TITLE:=LoRaWAN detection of distance change
endef

define Package/siot-lora-replay
  $(call Package/nemea-siot/Default)
  TITLE:=LoRaWAN Replay attack ABP detection
endef

define Package/siot-wsn-anomaly
  $(call Package/nemea-siot/Default)
  TITLE:=Wireless Sensor Network Detector (based on time series)
endef

define Package/siot-zwave-collector
  $(call Package/nemea-siot/Default)
  TITLE:=Zwave collector
endef

define Package/siot-zwave-detector
  $(call Package/nemea-siot/Default)
  TITLE:=Zwave detector
endef

define Package/siot-zwave-sniffer
  $(call Package/nemea-siot/Default)
  TITLE:=Zwave SDR sniffer
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

define Package/siot-ble-pairing/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-ble-pairing $(1)/usr/bin/nemea/
endef

define Package/siot-hci-collector/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-hci-collector $(1)/usr/bin/nemea/
endef

define Package/siot-lora-airtime/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-lora-airtime $(1)/usr/bin/nemea/
endef

define Package/siot-lora-distance/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-lora-distance $(1)/usr/bin/nemea/
endef

define Package/siot-lora-replay/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-lora-replay $(1)/usr/bin/nemea/
endef

define Package/siot-wsn-anomaly/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-wsn-anomaly $(1)/usr/bin/nemea/
endef

define Package/siot-zwave-collector/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-zwave-collector $(1)/usr/bin/nemea/
endef


define Package/siot-zwave-detector/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-zwave-detector $(1)/usr/bin/nemea/
endef


define Package/siot-zwave-sniffer/install
	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/nemea/siot-zwave-sdr-sniffer $(1)/usr/bin/nemea/
endef




$(eval $(call BuildPackage,siot-ble-pairing))
$(eval $(call BuildPackage,siot-hci-collector))
$(eval $(call BuildPackage,siot-lora-airtime))
$(eval $(call BuildPackage,siot-lora-distance))
$(eval $(call BuildPackage,siot-lora-replay))
$(eval $(call BuildPackage,siot-wsn-anomaly))
$(eval $(call BuildPackage,siot-zwave-collector))
$(eval $(call BuildPackage,siot-zwave-detector))
$(eval $(call BuildPackage,siot-zwave-sniffer))
