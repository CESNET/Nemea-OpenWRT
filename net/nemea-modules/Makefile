include $(TOPDIR)/rules.mk

PKG_NAME:=namea-modules
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/CESNET/nemea-modules.git
PKG_SOURCE_DATE:=2020-09-20
PKG_SOURCE_VERSION:=996c3353050320470004e11977c68f26367e02bc
PKG_MIRROR_HASH:=3de5cd13d61620b6f6aca8a2a78e0f1b293ea52ad0081b2b2903d4f56a27c3f3

PKG_MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>
PKG_LICENSE:=BSD-3-Clause

PKG_FIXUP:=autoreconf
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
endef

define Package/nemea-logreplay
	$(call Package/nemea-modules/Default)
	TITLE+=logreplay
	DEPENDS+=+libstdcpp
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
	DEPENDS+=+python3 +python3-nemea-pytrap
endef

define Package/nemea-supervisorl
	$(call Package/nemea-modules/Default)
	TITLE+=supervisorl
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
	$(INSTALL_CONF) ./files/config/nemea-supervisor $(1)/etc/config/nemea-supervisor
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

