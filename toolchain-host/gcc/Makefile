AC_EXTRA_FLAGS := \
		--with-sysroot \
		--enable-languages=c,c++,lto \
		--enable-shared \
		--enable-host-shared \
		--disable-multilib \
		--enable-initfini-array \
		--with-gmp-include=$(ARC_HOST)/include --with-gmp-lib=$(ARC_HOST)/lib \
		--with-mpc-include=$(ARC_HOST)/include --with-mpc-lib=$(ARC_HOST)/lib

COMPLETE := build.complete



$(COMPLETE):


	$(MAKE) -C binutils

	$(MAKE) -C gmp
	$(MAKE) -C mpfr
	$(MAKE) -C mpc

	rm -rf build
	mkdir build

# To build GCC libstdc++-v3
# The way to compile this library is a mystery to me
#	cd build && $(AC_CFLAGS) $(ARC_TOOLCHAIN_BUILD)/gcc/gcc-src/configure $(AC_FLAGS) $(AC_EXTRA_FLAGS)
#	$(MAKE) -C build all-gcc all-target-libgcc
#	$(MAKE) -C build install-gcc install-target-libgcc
#	touch $(COMPLETE)
