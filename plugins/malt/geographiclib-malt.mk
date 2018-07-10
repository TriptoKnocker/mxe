# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := geographiclib-malt
$(PKG)_IGNORE    = $(geographiclib_IGNORE)
$(PKG)_VERSION   = $(geographiclib_VERSION)
$(PKG)_CHECKSUM  = $(geographiclib_CHECKSUM)
$(PKG)_SUBDIR    = $(geographiclib_SUBDIR)
$(PKG)_FILE      = $(geographiclib_FILE)
$(PKG)_URL       = $(geographiclib_URL)
$(PKG)_URL_2     = $(geographiclib_URL_2)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    echo $(geographiclib_VERSION)
endef

define $(PKG)_BUILD
    mkdir '$(1)/build'
    cd '$(1)/build' && '$(TARGET)-cmake' .. \
        $(if $(BUILD_SHARED), -DGEOGRAPHICLIB_LIB_TYPE=SHARED, -DGEOGRAPHICLIB_LIB_TYPE=STATIC) \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)/malt/geographiclib-$($(PKG)_VERSION)'
    $(MAKE) -C '$(1)/build' -j $(JOBS)
    $(MAKE) -C '$(1)/build' -j 1 install/strip
endef
