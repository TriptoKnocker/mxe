# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := g3log
$(PKG)_WEBSITE  := https://github.com/KjellKod/g3log
$(PKG)_DESCR    := Asynchronous, crash-safe logger.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.3.2
$(PKG)_CHECKSUM := 0ed1983654fdd8268e051274904128709c3d9df8234acf7916e9015199b0b247
$(PKG)_GH_CONF  := KjellKod/g3log/releases/latest
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_BUILD_TYPE=Debug \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)/malt/g3logd-$($(PKG)_VERSION)' \
        -DG3_SHARED_LIB=$(CMAKE_SHARED_BOOL) \
        -DCHANGE_G3LOG_DEBUG_TO_DBUG=ON \
        -DENABLE_FATAL_SIGNALHANDLING=ON
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' VERBOSE=1
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # no bin dir is made for the shared library
    mkdir -p '$(PREFIX)/$(TARGET)/malt/g3logd-$($(PKG)_VERSION)/bin'
    cp '$(BUILD_DIR)'/*.dll '$(PREFIX)/$(TARGET)/malt/g3logd-$($(PKG)_VERSION)/bin'
    cp '$(BUILD_DIR)'/*.exe '$(PREFIX)/$(TARGET)/malt/g3logd-$($(PKG)_VERSION)/bin'
endef

