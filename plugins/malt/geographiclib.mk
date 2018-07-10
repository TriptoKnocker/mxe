# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := geographiclib
$(PKG)_WEBSITE  := https://geographiclib.sourceforge.io/
$(PKG)_DESCR    := A library for geographic projections
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.49
$(PKG)_CHECKSUM := aec0ab52b6b9c9445d9d0a77e3af52257e21d6e74e94d8c2cb8fa6f11815ee2b
$(PKG)_SUBDIR   := GeographicLib-$($(PKG)_VERSION)
$(PKG)_FILE     := GeographicLib-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/geographiclib/distrib/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/geographiclib/files/distrib/' | \
    $(SED) -n 's,.*GeographicLib-\([0-9.]\+\).tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    mkdir '$(SOURCE_DIR)/build'
    cd '$(SOURCE_DIR)/build' && '$(TARGET)-cmake' .. \
        $(if $(BUILD_SHARED), -DGEOGRAPHICLIB_LIB_TYPE=SHARED, -DGEOGRAPHICLIB_LIB_TYPE=STATIC)
    $(MAKE) -C '$(SOURCE_DIR)/build' -j $(JOBS)
    $(MAKE) -C '$(SOURCE_DIR)/build' -j 1 install/strip

    # remove the unnecessary deployables
    rm -f '$(PREFIX)/$(TARGET)/bin/CartConvert.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/ConicProj.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/GeoConvert.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/GeodSolve.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/GeodesicProj.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/GeoidEval.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/Gravity.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/MagneticField.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/Planimeter.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/TransverseMercatorProj.exe'
    rm -f '$(PREFIX)/$(TARGET)/bin/RhumbSolve.exe'
    rm -f '$(PREFIX)/$(TARGET)'/cmake/geographiclib*
    rm -f '$(PREFIX)/$(TARGET)/doc/html/index.html'
    rm -f '$(PREFIX)/$(TARGET)/doc/html/LICENSE.txt'
    rm -f '$(PREFIX)/$(TARGET)/doc/html/utilities.html'
    rm -rf '$(PREFIX)/$(TARGET)/matlab/geographiclib'
    rm -rf '$(PREFIX)/$(TARGET)/matlab/geographiclib-legacy'
    rm -rf '$(PREFIX)/$(TARGET)/node_modules/geographiclib'
    rm -rf '$(PREFIX)/$(TARGET)/python/geographiclib'
    rm -f '$(PREFIX)/$(TARGET)/python/setup.py'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/CartConvert.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/ConicProj.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/GeoConvert.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/GeodSolve.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/GeodesicProj.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/GeoidEval.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/Gravity.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/MagneticField.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/Planimeter.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/RhumbSolve.1'
    rm -f '$(PREFIX)/$(TARGET)/share/man/man1/TransverseMercatorProj.1'

    # remove the potentially blank directories
    cd '$(PREFIX)/$(TARGET)' && rmdir cmake -p --ignore-fail-on-non-empty
    cd '$(PREFIX)/$(TARGET)' && rmdir doc/html -p --ignore-fail-on-non-empty
    cd '$(PREFIX)/$(TARGET)' && rmdir matlab -p --ignore-fail-on-non-empty
    cd '$(PREFIX)/$(TARGET)' && rmdir node_modules -p --ignore-fail-on-non-empty
    cd '$(PREFIX)/$(TARGET)' && rmdir python -p --ignore-fail-on-non-empty
    cd '$(PREFIX)/$(TARGET)' && rmdir share/man/man1 -p --ignore-fail-on-non-empty

    # build the test (5551.76km is the output on success)
    '$(TARGET)-g++' \
        -W -Wall -Werror -pedantic -ansi \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-geographiclib.exe' \
        `'$(TARGET)-pkg-config' --static --cflags --libs geographiclib`
endef
