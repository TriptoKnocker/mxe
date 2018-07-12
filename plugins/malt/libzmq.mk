# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libzmq
$(PKG)_WEBSITE  := http://zeromq.org/
$(PKG)_DESCR    := Distributed Messaging
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.2.3
$(PKG)_CHECKSUM := b428c6cdf1df4b5cdcb3a6727c6ece85c7fb05d7907c532566a115b4dda113a8
$(PKG)_GH_CONF  := zeromq/libzmq/tags,v
$(PKG)_DEPS     := cc libsodium

define $(PKG)_BUILD
    cd '$(1)' && ./autogen.sh
    cd '$(1)' && ./configure --with-libsodium \
    $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(SOURCE_DIR)' -j $(JOBS)
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 $(INSTALL_STRIP_LIB)

    '$(TARGET)-g++' \
        -W -Wall -Werror -pedantic \
        '$(1)/tests/test_many_sockets.cpp' -o '$(PREFIX)/$(TARGET)/bin/test-libzmq.exe' \
        `'$(TARGET)-pkg-config' --static --cflags --libs libzmq` -lsodium -lws2_32 -liphlpapi
endef

