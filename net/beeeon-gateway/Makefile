#
# Copyright (c) 2016, 2017, Brno University of Technology
#
# This is free software, licensed under the BSD-3-Clause.
#
# This file is based on
# https://github.com/BeeeOn/openwrt-packages/tree/master/beeeon-gateway
#

include $(TOPDIR)/rules.mk

PKG_NAME:=beeeon-gateway
PKG_VERSION:=v2019.7.1
PKG_RELEASE:=1
INIT_SCRIPT_NAME:=$(PKG_NAME)


PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/BeeeOn/gateway.git
PKG_SOURCE_VERSION:=7328b4377efcba98d1fef25372f2d2d6a7e685f0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=Jakub Jalowiczor <jakub.jalowiczor@vsb.cz>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1
CMAKE_INSTALL:=1
BUILD_DIR:=$(TOPDIR)/build_dir/turris
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(_PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

ifeq ($(BUILD_VARIANT),all)
	CMAKE_OPTIONS += \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE:STRING=Release \
		-DENABLE_TESTS=OFF \
		-DENABLE_UDEV=OFF \
		-DENABLE_BELKIN_WEMO=ON \
		-DENABLE_BLE_SMART=ON \
		-DENABLE_BLUETOOTH_AVAILABILITY=ON \
		-DENABLE_HCI_INFO_REPORTER=ON \
		-DENABLE_FITP=OFF \
		-DENABLE_IQRF=ON \
		-DENABLE_JABLOTRON=ON \
		-DENABLE_PHILIPS_HUE=ON \
		-DENABLE_VEKTIVA=ON \
		-DENABLE_PRESSURE_SENSOR=ON \
		-DENABLE_VIRTUAL_DEVICES=ON \
		-DENABLE_VPT=ON \
		-DENABLE_ZWAVE=ON \
		-DENABLE_TESTING_CENTER=ON \
		-DENABLE_NEMEA=ON
else
	CMAKE_OPTIONS += \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE:STRING=Release \
		-DENABLE_TESTS=OFF \
		-DENABLE_UDEV=OFF \
		-DENABLE_BELKIN_WEMO=OFF \
		-DENABLE_BLE_SMART=OFF \
		-DENABLE_BLUETOOTH_AVAILABILITY=OFF \
		-DENABLE_HCI_INFO_REPORTER=OFF \
		-DENABLE_FITP=OFF \
		-DENABLE_IQRF=OFF \
		-DENABLE_JABLOTRON=OFF \
		-DENABLE_PHILIPS_HUE=OFF \
		-DENABLE_VEKTIVA=OFF \
		-DENABLE_PRESSURE_SENSOR=ON \
		-DENABLE_VIRTUAL_DEVICES=ON \
		-DENABLE_VPT=OFF \
		-DENABLE_ZWAVE=OFF \
		-DENABLE_TESTING_CENTER=ON \
		-DENABLE_NEMEA=OFF
endif

TARGET_CXXFLAGS += -DPOCO_NO_FPENVIRONMENT

define Package/beeeon-gateway/config
	source "$(SOURCE)/Config.in"
endef

ifeq ($(BUILD_VARIANT),all)
	PKG_BUILD_DEPENDS += +poco-all python3/host +glib2 +bluez +openzwave +mosquitto
else
	PKG_BUILD_DEPENDS += +poco-all python3/host
endif

define Package/beeeon-gateway
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=BeeeOn Gateway
	URL:=https://beeeon.github.io/gateway/
	DEPENDS:=+poco-all
	VARIANT:=minimal
endef

define Package/beeeon-gateway/description
	The main application for BeeeOn Gateway with all modules disabled.
endef

define Package/beeeon-gateway-all
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=BeeeOn Gateway
	URL:=https://beeeon.github.io/gateway/
	DEPENDS:=+poco-all
	DEPENDS += +bluez-daemon +bluez-libs +glib2 +libmosquittopp +nemea-framework +libpcap +openzwave-config +libopenzwave
	VARIANT:=all
endef

define Package/beeeon-gateway-all/description
        The main application for BeeeOn Gateway with all modules enabled.
endef

BEEEON_GATEWAY_MODULE_ENABLE += psdev \
				vdev \
				testing.center \
				testing.collector \
				gws

ifeq ($(BUILD_VARIANT),all)
	BEEEON_GATEWAY_MODULE_ENABLE += belkinwemo \
					blesmart \
					bluetooth.availability \
					bluetooth.reporting \
					iqrf \
					jablotron \
					exporter.mqtt \
					philipshue \
					vpt \
					zwave \
					nemea
else
	BEEEON_GATEWAY_MODULE_DISABLE += belkinwemo \
                                        blesmart \
                                        bluetooth.availability \
                                        bluetooth.reporting \
                                        iqrf \
                                        jablotron \
                                        exporter.mqtt \
                                        philipshue \
                                        vpt \
                                        zwave \
                                        nemea
endif

# Generate random BeeeOn Gateway ID
ifeq ($(CONFIG_BEEEON_GATEWAY_ID_RANDOM),y)
BEEEON_GATEWAY_MODULE_ENABLE += gateway.id

define BEEEON_GATEWAY_ID_INSTALL
	echo gateway.id = `python3 $(PKG_BUILD_DIR)/tools/gateway-genid.py` \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties
	echo ssl.key = >> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties
	echo ssl.certificate = >> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties
endef
endif

# Configure the manually inserted BeeeOn Gateway ID
ifeq ($(CONFIG_BEEEON_GATEWAY_ID_CUSTOM),y)
BEEEON_GATEWAY_MODULE_ENABLE += gateway.id

define BEEEON_GATEWAY_ID_INSTALL
	echo gateway.id = $(CONFIG_BEEEON_GATEWAY_ID_CUSTOM_VALUE) \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties
	echo ssl.key = >> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties
	echo ssl.certificate = >> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties
endef
endif

# Use SSL/TLS to provide BeeeOn Gateway ID
ifeq ($(CONFIG_BEEEON_GATEWAY_ID_CERT),y)
BEEEON_GATEWAY_MODULE_DISABLE += gateway.id

define BEEEON_GATEWAY_ID_INSTALL
	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/etc/ssl/beeeon/private
	$(CP) $(CONFIG_BEEEON_GATEWAY_ID_CERT_PKEY) \
		$(PKG_INSTALL_DIR)/etc/ssl/beeeon/private/beeeon_gateway.key

	$(INSTALL_DIR) $(PKG_INSTALL_DIR)/etc/ssl/beeeon/certs
	$(CP) $(CONFIG_BEEEON_GATEWAY_ID_CERT_FILE) \
		$(PKG_INSTALL_DIR)/etc/ssl/beeeon/certs/beeeon_gateway.crt
	$(CP) $(CONFIG_BEEEON_GATEWAY_ID_CERT_AUTHORITY) \
		$(PKG_INSTALL_DIR)/etc/ssl/beeeon/certs/beeeon_root_ca.crt
endef
endif

ifeq ($(CONFIG_BEEEON_GATEWAY_MQTT_EXPORTER),y)
define BEEEON_GATEWAY_MQTT_INSTALL
	echo exporter.mqtt.host = $(CONFIG_BEEEON_GATEWAY_MQTT_EXPORTER_HOST) \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-mqtt.properties
	echo exporter.mqtt.port = $(CONFIG_BEEEON_GATEWAY_MQTT_EXPORTER_PORT) \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-mqtt.properties
	echo exporter.mqtt.topic = $(CONFIG_BEEEON_GATEWAY_MQTT_EXPORTER_TOPIC) \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-mqtt.properties
	echo exporter.mqtt.clientID = $(CONFIG_BEEEON_GATEWAY_MQTT_EXPORTER_CLIENT_ID) \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-mqtt.properties
endef
endif

define Package/beeeon-gateway/install
	echo hotplug.impl = pipeHotplug \
		> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-hotplug.properties

	$(RM) $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-modules.properties
	$(foreach module,$(BEEEON_GATEWAY_MODULE_ENABLE),\
		echo $(module).enable = yes \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-modules.properties;)
	$(foreach module,$(BEEEON_GATEWAY_MODULE_DISABLE),\
		echo $(module).enable = no \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-modules.properties;)

	$(RM) $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties

	$(if $(CONFIG_BEEEON_GATEWAY_GWS_HOST),\
		echo gws.host = $(CONFIG_BEEEON_GATEWAY_GWS_HOST) \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties)
	$(if $(CONFIG_BEEEON_GATEWAY_GWS_PORT),\
		echo gws.port = $(CONFIG_BEEEON_GATEWAY_GWS_PORT) \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties)

	$(BEEEON_GATEWAY_ID_INSTALL)

	sed -i "s|/var/cache|/usr/lib|" ${PKG_INSTALL_DIR}/usr/etc/beeeon/gateway/gateway-startup.ini
	mkdir -p $(1)/usr/lib/beeeon/gateway

	$(INSTALL_DIR) $(1)
	$(CP) -r $(PKG_INSTALL_DIR)/* $(1)
	$(RM) -r $(1)/var

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/$(INIT_SCRIPT_NAME) $(1)/etc/init.d/$(INIT_SCRIPT_NAME)

	$(INSTALL_DIR) $(1)/etc/hotplug.d
	$(CP) ./files/beeeon-hotplug-functions $(1)/etc/hotplug.d/beeeon-hotplug-functions
	$(INSTALL_DIR) $(1)/etc/hotplug.d/tty
	$(CP) ./files/tty-beeeon-dongle $(1)/etc/hotplug.d/tty/30-beeeon-dongle
	$(INSTALL_DIR) $(1)/etc/hotplug.d/bluetooth
	$(CP) ./files/bluetooth-beeeon-dongle $(1)/etc/hotplug.d/bluetooth/30-beeeon-dongle
endef

define Package/beeeon-gateway-all/install
	echo hotplug.impl = pipeHotplug \
		> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-hotplug.properties

	$(RM) $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-modules.properties
	$(foreach module,$(BEEEON_GATEWAY_MODULE_ENABLE),\
		echo $(module).enable = yes \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-modules.properties;)
	$(foreach module,$(BEEEON_GATEWAY_MODULE_DISABLE),\
		echo $(module).enable = no \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-modules.properties;)

	$(RM) $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties

	$(if $(CONFIG_BEEEON_GATEWAY_GWS_HOST),\
		echo gws.host = $(CONFIG_BEEEON_GATEWAY_GWS_HOST) \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties)
	$(if $(CONFIG_BEEEON_GATEWAY_GWS_PORT),\
		echo gws.port = $(CONFIG_BEEEON_GATEWAY_GWS_PORT) \
		>> $(PKG_INSTALL_DIR)/usr/etc/beeeon/gateway/config.d/x-gws.properties)

	$(BEEEON_GATEWAY_ID_INSTALL)

	sed -i "s|/var/cache|/usr/lib|" ${PKG_INSTALL_DIR}/usr/etc/beeeon/gateway/gateway-startup.ini
	mkdir -p $(1)/usr/lib/beeeon/gateway

	$(INSTALL_DIR) $(1)
	$(CP) -r $(PKG_INSTALL_DIR)/* $(1)
	$(RM) -r $(1)/var

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/$(INIT_SCRIPT_NAME) $(1)/etc/init.d/$(INIT_SCRIPT_NAME)

	$(INSTALL_DIR) $(1)/etc/hotplug.d
	$(CP) ./files/beeeon-hotplug-functions $(1)/etc/hotplug.d/beeeon-hotplug-functions
	$(INSTALL_DIR) $(1)/etc/hotplug.d/tty
	$(CP) ./files/tty-beeeon-dongle $(1)/etc/hotplug.d/tty/30-beeeon-dongle
	$(INSTALL_DIR) $(1)/etc/hotplug.d/bluetooth
	$(CP) ./files/bluetooth-beeeon-dongle $(1)/etc/hotplug.d/bluetooth/30-beeeon-dongle
endef

define Package/beeeon-gateway/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo "Enabling and starting $(PKG_NAME) service"
  /etc/init.d/$(INIT_SCRIPT_NAME) enable
  /etc/init.d/$(INIT_SCRIPT_NAME) start
fi
exit 0
endef

define Package/beeeon-gateway-all/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo "Enabling and starting $(PKG_NAME) service"
  /etc/init.d/$(INIT_SCRIPT_NAME) enable
  /etc/init.d/$(INIT_SCRIPT_NAME) start
fi
exit 0
endef

define Package/beeeon-gateway/prerm
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo "Disabling and stopping $(PKG_NAME) service"
  /etc/init.d/$(INIT_SCRIPT_NAME) disable
  /etc/init.d/$(INIT_SCRIPT_NAME) stop
fi
exit 0
endef

define Package/beeeon-gateway-all/prerm
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo "Disabling and stopping $(PKG_NAME) service"
  /etc/init.d/$(INIT_SCRIPT_NAME) disable
  /etc/init.d/$(INIT_SCRIPT_NAME) stop
fi
exit 0
endef

$(eval $(call BuildPackage,beeeon-gateway))
$(eval $(call BuildPackage,beeeon-gateway-all))
