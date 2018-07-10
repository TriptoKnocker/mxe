# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libzmq-malt
$(PKG)_IGNORE    = $(libzmq_IGNORE)
$(PKG)_VERSION   = $(libzmq_VERSION)
$(PKG)_CHECKSUM  = $(libzmq_CHECKSUM)
$(PKG)_SUBDIR    = $(libzmq_SUBDIR)
$(PKG)_FILE      = $(libzmq_FILE)
$(PKG)_PATCHES   = $(realpath $(sort $(wildcard $(addsuffix /zmq-[0-9]*.patch, $(TOP_DIR)/src))))
$(PKG)_URL       = $(libzmq_URL)
$(PKG)_URL_2     = $(libzmq_URL_2)
$(PKG)_DEPS     := cc libsodium

define $(PKG)_UPDATE
    echo $(libzmq_VERSION)
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && ./autogen.sh
    cd '$(SOURCE_DIR)' && ./configure --with-libsodium \
    $(MXE_CONFIGURE_OPTS) \
    --prefix='$(PREFIX)/$(TARGET)/malt/zmq-4.2.5'
    $(MAKE) -C '$(SOURCE_DIR)' -j $(JOBS)
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 $(INSTALL_STRIP_LIB)
endef
