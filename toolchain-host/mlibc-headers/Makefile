REPO := https://github.com/managarm/mlibc
COMMIT := 0e63cc9b3d49f678bf330ee9d71d2eee6c1716e1
NAME := mlibc-$(COMMIT)
TAR := $(NAME).tar.gz
MIRROR := $(REPO)/archive/$(COMMIT).tar.gz

MESON_FLAGS := --reconfigure --cross-file $(ARC_BUILD_SUPPORT)/meson.cross --prefix=$(ARC_HOST_PREFIX) \
		-Ddisable_crypt_option=true -Ddisable_iconv_option=true -Ddisable_intl_option=true \
		--buildtype=debugoptimized -Ddefault_library=both \
		build

NINJA_FLAGS := -C build

COMPLETE := mlibc-src/build.complete

$(COMPLETE): $(TAR)
	rm -rf mlibc-src/build
	mkdir mlibc-src/build

	cd mlibc-src && $(ARC_SET_COMPILER_ENV_FLAGS) meson setup $(MESON_FLAGS) -Dheaders_only=true
	meson install -C mlibc-src/build

	touch $(COMPLETE)

$(TAR):
	rm -rf mlibc-src
	curl -o $(TAR) -L $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) mlibc-src
	cd mlibc-src && patch -p1 < ../mlibc.patch
