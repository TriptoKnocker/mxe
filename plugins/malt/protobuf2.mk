# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := protobuf2
$(PKG)_ACTUAL   := protobuf
$(PKG)_WEBSITE  := https://github.com/google/protobuf
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.6.1
$(PKG)_CHECKSUM := 2667b7cda4a6bc8a09e5463adf3b5984e08d94e72338277affa8594d8b6e5cd1
$(PKG)_SUBDIR   := $($(PKG)_ACTUAL)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_ACTUAL)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/google/$($(PKG)_ACTUAL)/archive/v$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc googletest zlib $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) := googletest zlib

define $(PKG)_UPDATE
    echo 'This version of protobuf will remain at 2.6.1'
endef

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,googletest,$(SOURCE_DIR))
    cd '$(SOURCE_DIR)' && mv googletest-release-$(googletest_VERSION)/ gtest
    # First step: Build for host system in order to create "protoc" binary.
    cd '$(SOURCE_DIR)' && ./autogen.sh && ./configure \
        --disable-shared
    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)'
    cp '$(SOURCE_DIR)/src/protoc' '$(PREFIX)/bin/$(TARGET)-protoc'
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 distclean
    # Second step: Build for target system.
    cd '$(SOURCE_DIR)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --prefix='$(PREFIX)/$(TARGET)/malt/protobuf-2.6.1' \
        --with-zlib \
        --with-protoc='$(PREFIX)/bin/$(TARGET)-protoc'
    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 install
endef
