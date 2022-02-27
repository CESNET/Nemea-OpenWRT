include $(TOPDIR)/rules.mk

PKG_NAME:=nemea-pytrap
PKG_VERSION:=0.12.2
PKG_RELEASE:=1

PYPI_NAME:=$(PKG_NAME)
PKG_HASH:=33388c81f12754e4288d630a18f0c136d5bac67b4bfc37a86aa82e2381f78cb5

PKG_MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>
PKG_LICENSE:=BSD-3-Clause

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-nemea-pytrap
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=NEMEA
  TITLE:=Python extension of the NEMEA project
  URL:=https://github.com/CESNET/Nemea-Framework
  DEPENDS:=+python3 +nemea-framework +libpthread
  VARIANT:=python3
endef

define Package/python3-nemea-pytrap/description
  The pytrap module is a native Python extension that
  allows for writing NEMEA modules in Python.
endef

$(eval $(call Py3Package,python3-nemea-pytrap))
$(eval $(call BuildPackage,python3-nemea-pytrap))
$(eval $(call BuildPackage,python3-nemea-pytrap-src))
