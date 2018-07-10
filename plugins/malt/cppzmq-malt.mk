# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cppzmq-malt
$(PKG)_IGNORE    = $(cppzmq_IGNORE)
$(PKG)_VERSION   = $(cppzmq_VERSION)
$(PKG)_CHECKSUM  = $(cppzmq_CHECKSUM)
$(PKG)_SUBDIR    = $(cppzmq_SUBDIR)
$(PKG)_FILE      = $(cppzmq_FILE)
$(PKG)_URL       = $(cppzmq_URL)
$(PKG)_URL_2     = $(cppzmq_URL_2)
$(PKG)_DEPS     := cc libzmq-malt

define $(PKG)_UPDATE
    echo $(cppzmq_VERSION)
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && cp -rf zmq.hpp '$(PREFIX)/$(TARGET)/malt/zmq-4.2.5/include/'
    cd '$(SOURCE_DIR)' && cp -rf zmq_addon.hpp '$(PREFIX)/$(TARGET)/malt/zmq-4.2.5/include/'
endef
