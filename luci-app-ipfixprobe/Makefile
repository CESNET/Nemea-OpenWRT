#
# Copyright (C) 2019 CESNET
#
# You may redistribute this program and/or modify it under the terms of
# the GNU General Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ipfixprobe
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-ipfixprobe
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=IPFIX exporter profiles
	URL:=https://github.com/CESNET/NEMEA-OpenWrt
	MAINTAINER:=Tomas Cejka <cejkat@cesnet.cz>
	DEPENDS:=+ipfixprobe +luci-base +luci-compat
endef

define Package/luci-app-ipfixprobe/description
	This package allows you to configure and inspect IPFIX exporter ipfixprobe using LuCI.
endef

define Build/Compile
endef

define Package/luci-app-ipfixprobe/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	$(CP) ./luasrc/* $(1)/usr/lib/lua/luci
endef

$(eval $(call BuildPackage,luci-app-ipfixprobe))

