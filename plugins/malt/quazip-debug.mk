# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := quazip-debug
$(PKG)_IGNORE    = $(quazip_IGNORE)
$(PKG)_VERSION   = $(quazip_VERSION)
$(PKG)_CHECKSUM  = $(quazip_CHECKSUM)
$(PKG)_SUBDIR    = $(quazip_SUBDIR)
$(PKG)_FILE      = $(quazip_FILE)
$(PKG)_PATCHES   = $(realpath $(sort $(wildcard $(addsuffix /quazip-[0-9]*.patch, $(TOP_DIR)/src))))
$(PKG)_URL       = $(quazip_URL)
$(PKG)_URL_2     = $(quazip_URL_2)
$(PKG)_DEPS     := cc qtbase

define $(PKG)_UPDATE
    echo $(quazip_VERSION)
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake' '$(SOURCE_DIR)' \
        'static:CONFIG += staticlib' \
        PREFIX=$(PREFIX)/$(TARGET)/malt/quazip-$($(PKG)_VERSION) \
        -after \
        'win32:LIBS_PRIVATE += -lz' \
        'CONFIG -= dll' \
        'CONFIG += create_prl no_install_prl create_pc' \
        'QMAKE_PKGCONFIG_DESTDIR = pkgconfig' \
        'static:QMAKE_PKGCONFIG_CFLAGS += -DQUAZIP_STATIC' \
        'DESTDIR = ' \
        'DLLDESTDIR = ' \
        'win32:dlltarget.path = $(PREFIX)/$(TARGET)/malt/quazip-$($(PKG)_VERSION)/bin' \
        'target.path = $(PREFIX)/$(TARGET)/malt/quazip-$($(PKG)_VERSION)/lib'  \
        '!static:win32:target.CONFIG = no_dll' \
        'win32:INSTALLS += dlltarget' \
        'INSTALLS += target headers'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

#    '$(TARGET)-g++' \
#        -W -Wall -Werror -std=c++11 -pedantic \
#        '$(TOP_DIR)/src/$(PKG)-test.cpp' \
#        -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG)-pkgconfig.exe' \
#        `'$(TARGET)-pkg-config' quazip --cflags --libs`
endef
