# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := protobuf-malt
$(PKG)_IGNORE    = $(protobuf_IGNORE)
$(PKG)_VERSION   = $(protobuf_VERSION)
$(PKG)_CHECKSUM  = $(protobuf_CHECKSUM)
$(PKG)_SUBDIR    = $(protobuf_SUBDIR)
$(PKG)_FILE      = $(protobuf_FILE)
$(PKG)_URL       = $(protobuf_URL)
$(PKG)_DEPS      := $(protobuf_DEPS)
$(PKG)_TARGETS   = $(protobuf_TARGETS)
$(PKG)_DEPS_$(BUILD) := googlemock googletest libtool

define $(PKG)_UPDATE
    echo $(protobuf_VERSION)
endef

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,googlemock,$(SOURCE_DIR))
    cd '$(SOURCE_DIR)' && mv '$(googlemock_SUBDIR)' gmock
    $(call PREPARE_PKG_SOURCE,googletest,$(SOURCE_DIR))
    cd '$(SOURCE_DIR)' && mv '$(googletest_SUBDIR)' gmock/gtest
    cd '$(SOURCE_DIR)' && ./autogen.sh

    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)'/configure \
        $(MXE_CONFIGURE_OPTS) \
        --prefix='$(PREFIX)/$(TARGET)/malt/protobuf-$($(PKG)_VERSION)' \
        $(if $(BUILD_CROSS), \
            --with-zlib \
            --with-protoc='$(PREFIX)/$(BUILD)/bin/protoc' \
        )
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

