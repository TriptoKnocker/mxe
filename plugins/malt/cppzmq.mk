# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cppzmq
$(PKG)_WEBSITE  := http://zeromq.org/
$(PKG)_DESCR    := C++ bindings for libzmq
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.2.3
$(PKG)_CHECKSUM := 3e6b57bf49115f4ae893b1ff7848ead7267013087dc7be1ab27636a97144d373
$(PKG)_GH_CONF  := zeromq/cppzmq/tags,v
$(PKG)_DEPS     := cc libzmq

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && cp -rf zmq.hpp '$(PREFIX)/$(TARGET)/include/'
    cd '$(SOURCE_DIR)' && cp -rf zmq_addon.hpp '$(PREFIX)/$(TARGET)/include/'
endef
