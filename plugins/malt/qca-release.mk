# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qca-release
$(PKG)_IGNORE   := $(qca_IGNORE)
$(PKG)_VERSION  := $(qca_VERSION)
$(PKG)_CHECKSUM := $(qca_CHECKSUM)
$(PKG)_FILE     := $(qca_FILE)
$(PKG)_URL      := $(qca_URL)
$(PKG)_DEPS     := cc qtbase

define $(PKG)_UPDATE
    echo $(qca_VERSION)
endef

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,qca,$(SOURCE_DIR))
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)qca-$($(PKG)_VERSION)' \
        -DCMAKE_BUILD_TYPE=release \
        -DBUILD_TESTS=OFF \
        -DBUILD_TOOLS=OFF \
        -DUSE_RELATIVE_PATHS=OFF \
        -DBUILD_PLUGINS="auto" \
        -DINSTALL_PKGCONFIG=ON \
        -DQCA_MAN_INSTALL_DIR="$(BUILD_DIR)/null"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

