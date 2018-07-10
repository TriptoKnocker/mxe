# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cppzmq
$(PKG)_WEBSITE  := https://github.com/zeromq/cppzmq
$(PKG)_DESCR    := C++ binding for 0MQ
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.2.3
$(PKG)_CHECKSUM := 3e6b57bf49115f4ae893b1ff7848ead7267013087dc7be1ab27636a97144d373
$(PKG)_GH_CONF  := zeromq/cppzmq/tags,v
$(PKG)_DEPS     := cc libzmq

define $(PKG)_BUILD
    # install the headers only
    $(INSTALL) -m644 '$(SOURCE_DIR)'/zmq*.hpp '$(PREFIX)/$(TARGET)/include'

    # test cmake
    mkdir '$(BUILD_DIR).test-cmake'
    cd '$(BUILD_DIR).test-cmake' && '$(TARGET)-cmake' \
        -DPKG=$(PKG) \
        -DPKG_VERSION=$($(PKG)_VERSION) \
        '$(PWD)/src/cmake/test'
    $(MAKE) -C '$(BUILD_DIR).test-cmake' -j 1 install
endef
