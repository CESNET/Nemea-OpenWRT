include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ipfixprobe
PKG_VERSION:=0.3
PKG_SOURCE_DATE=2022-03-19
PKG_RELEASE:=1

PKG_MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>
PKG_LICENSE:=GPL-3.0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

# Default locations
HTDOCS = /www
LUA_LIBRARYDIR = /usr/lib/lua
LUCI_LIBRARYDIR = $(LUA_LIBRARYDIR)/luci
UCODE_LIBRARYDIR = /usr/share/ucode/luci

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-ipfixprobe
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=IPFIX exporter profiles
	URL:=https://github.com/CESNET/NEMEA-OpenWrt
	MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>
	DEPENDS:=+ipfixprobe +luci-base
endef

define Package/luci-app-ipfixprobe/description
	This package allows you to configure and inspect IPFIX exporter ipfixprobe using LuCI.
endef

define Build/Compile
endef

define Package/luci-app-ipfixprobe/install
	$(INSTALL_DIR) $(1)$(HTDOCS)
	cp -pR $(PKG_BUILD_DIR)/htdocs/* $(1)$(HTDOCS)/

	$(INSTALL_DIR) $(1)/
	cp -pR $(PKG_BUILD_DIR)/root/* $(1)/
endef

$(eval $(call BuildPackage,luci-app-ipfixprobe))
