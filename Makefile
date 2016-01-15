SHELL=/bin/bash

TOP := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

CLANG=/opt/irods-externals/clang3.7-0/bin/clang
CLANGPP=/opt/irods-externals/clang3.7-0/bin/clang++
BOOST_ROOT=/opt/irods-externals/boost1.59.0-0

#DEBUG_SYMBOLS=" -g"
#VERBOSE="-v"

all: libre-v8.so

PHONY: all install depot_tools uninstall clean distclean

# from http://stackoverflow.com/questions/24817747/building-v8-with-clang-and-emitting-llvm-ir
export CXX="$(CLANGPP)"
export CXX_host="$(CLANGPP)"
export LINK="$(CLANGPP)"
export LINK_host="$(CLANGPP)"
export CC="$(CLANG)"
export CC_host="$(CLANG)"
export GYP_DEFINES="clang=1"
export CFLAGS="-fPIC$(DEBUG_SYMBOLS)"
export CXXFLAGS="-fPIC$(DEBUG_SYMBOLS)"

depot_tools:
	git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

$(TOP)/v8: depot_tools
	$(TOP)/depot_tools/fetch v8 ; \
		$(TOP)/depot_tools/gclient sync ; \
		cd $(TOP)/v8 ; \
		git checkout 4.9.300 ; \
		cd $(TOP) ; \
		${TOP}/depot_tools/gclient sync

v8: $(TOP)/v8
	$(MAKE) -C v8 -j31 native

libre-v8.so: v8 libre-v8.cpp
	$(CLANG) $(VERBOSE) -fPIC -shared -std=c++11 -I$(TOP)/v8 -I$(BOOST_ROOT)/include libre-v8.cpp -o libre-v8.so -Wl,--start-group $(TOP)/v8/out/native/obj.target/{tools/gyp/libv8_{base,libbase,snapshot,libplatform},third_party/icu/libicu{uc,i18n,data}}.a -Wl,--end-group -lrt -ldl -pthread$(DEBUG_SYMBOLS)


-include /etc/irods/service_account.config
OWNERSHIP=$(strip $(IRODS_SERVICE_ACCOUNT_NAME)):$(strip $(IRODS_SERVICE_GROUP_NAME))

install: libre-v8.so
	sudo cp $(TOP)/libre-v8.so /var/lib/irods/plugins/re/
	sudo chown $(OWNERSHIP) /var/lib/irods/plugins/re/libre-v8.so

uninstall:
	sudo rm /var/lib/irods/plugins/re/libre-v8.so

clean:
	rm -f libre-v8.so

distclean: clean
	rm -rf $(TOP)/depot_tools
	rm -rf $(TOP)/v8
