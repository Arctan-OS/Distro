AC_FLAGS := \
		--target=$(OS_TRIPLET) \
		--prefix=$(ARC_BUILD_PREFIX) \
		--with-sysroot=$(ARC_SYSROOT) \
		--disable-nls \
		--disable-werror

export AC_FLAGS

all:
	$(MAKE) -C $(ARC_TOOLCHAIN_HOST)/mlibc-headers
	$(MAKE) -C autoconf
	$(MAKE) -C autoconf-2.69
	$(MAKE) -C automake
	$(MAKE) -C libtool
	$(MAKE) -C gcc
