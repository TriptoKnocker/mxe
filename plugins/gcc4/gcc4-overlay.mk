# This file is part of MXE. See LICENSE.md for licensing information.

# This plugin is needed in case of issues with GCC 5.4.0:
# https://github.com/mxe/mxe/pull/1541#issuecomment-274035553

PKG             := cloog
$(PKG)_VERSION  := 0.18.1
$(PKG)_CHECKSUM := 02500a4edd14875f94fe84cbeda4290425cb0c1c2474c6f75d75a303d64b4196
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://www.bastoul.net/cloog/pages/download/$($(PKG)_FILE)
$(PKG)_URL_2    := ftp://gcc.gnu.org/pub/gcc/infrastructure/$($(PKG)_FILE)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

PKG             := isl
$(PKG)_VERSION  := 0.12.2
$(PKG)_CHECKSUM := f4b3dbee9712850006e44f0db2103441ab3d13b406f77996d1df19ee89d11fb4
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://isl.gforge.inria.fr/$($(PKG)_FILE)
$(PKG)_URL_2    := ftp://gcc.gnu.org/pub/gcc/infrastructure/$($(PKG)_FILE)

PKG             := gcc
$(PKG)_VERSION  := 4.9.4
$(PKG)_CHECKSUM := 6c11d292cd01b294f9f84c9a59c230d80e9e4a47e5c6355f046bb36d4f358092
$(PKG)_SUBDIR   := gcc-$($(PKG)_VERSION)
$(PKG)_FILE     := gcc-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://ftp.gnu.org/pub/gnu/gcc/gcc-$($(PKG)_VERSION)/$($(PKG)_FILE)
