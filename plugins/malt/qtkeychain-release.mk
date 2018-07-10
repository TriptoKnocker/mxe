# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qtkeychain-release
$(PKG)_IGNORE   := $(qtkeychain_IGNORE)
$(PKG)_VERSION  := $(qtkeychain_VERSION)
$(PKG)_CHECKSUM := $(qtkeychain_CHECKSUM)
$(PKG)_FILE     := $(qtkeychain_FILE)
$(PKG)_URL      := $(qtkeychain_URL)
$(PKG)_DEPS     := cc qttools

define $(PKG)_UPDATE
    echo $(qtkeychain_VERSION)
endef

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,qtkeychain,$(SOURCE_DIR))
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)qtkeychain-$($(PKG)_VERSION)' \
        -DCMAKE_BUILD_TYPE=release \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)/malt/qtkeychain-$($(PKG)_VERSION)' \
        $(if $(BUILD_STATIC),-DQTKEYCHAIN_STATIC=ON)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
