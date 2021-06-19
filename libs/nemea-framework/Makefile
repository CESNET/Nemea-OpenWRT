include $(TOPDIR)/rules.mk

PKG_NAME:=namea-framework
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/CESNET/nemea-framework.git
PKG_SOURCE_DATE:=2020-10-01
PKG_SOURCE_VERSION:=9facfe7f4d2657a830cb30f9107541fc410f83b3
PKG_MIRROR_HASH:=aac0881ba8627897b23906eabde97450178a8f9285699c0368f88a745a934b96

PKG_MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>
PKG_LICENSE:=BSD-3-Clause

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/nemea-framework
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=NEMEA
  DEPENDS:=+libpthread +librt +libstdcpp +libopenssl
  TITLE:=NEMEA system libraries
  URL:=https://github.com/CESNET/nemea-framework
endef

define Package/nemea-framework/description
  This package contains a system-independent library for the Nemea.
  It is system for network traffic analysis and anomaly detection.
endef

define Package/nemea-framework/config
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
	--disable-python \
	--disable-pycommon \
	--disable-silent-rules \
	--disable-example \
	--disable-tests \
	LIBS=-lm \
	--bindir=\$$(bindir)/nemea \
	--with-build-cc="$(HOSTCC)" \
	--with-ifcbuffersize=$(CONFIG_NEMEA_LIBTRAP_BUFFER_SIZE) \
	--with-ifcmaxclients=$(CONFIG_NEMEA_LIBTRAP_IFC_MAX_CLIENTS) \
	--without-libxml2

MAKE_FLAGS += \
	CCOPT="$(TARGET_CFLAGS) -I$(BUILD_DIR)/linux/include"

define Build/InstallDev
	$(INSTALL_DIR) $(2)/bin
	$(CP) $(PKG_BUILD_DIR)/unirec/ur_processor.sh $(2)/bin/

	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/libtrap* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/include/nemea-common
	$(CP) $(PKG_INSTALL_DIR)/usr/include/nemea-common* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/include/unirec/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/unirec* $(1)/usr/include/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib*.{a,so*} $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/*.pc $(1)/usr/lib/pkgconfig
endef

define Package/nemea-framework/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib*.so* $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin/nemea
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/nemea/trap_stats $(1)/usr/bin/nemea/
endef

$(eval $(call BuildPackage,nemea-framework))
