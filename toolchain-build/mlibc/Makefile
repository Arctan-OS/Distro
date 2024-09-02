REPO := https://github.com/managarm/mlibc
COMMIT := 67e11fa83ed3606edd1b76c927bd3303d7c87ab9
NAME := mlibc-$(COMMIT)
TAR := $(NAME).tar.gz
MIRROR := $(REPO)/archive/$(COMMIT).tar.gz

MESON_FLAGS := --reconfigure --cross-file $(ARC_ROOT)/build-support/cross.txt --prefix=$(PREFIX) \
		 -Ddisable_crypt_option=true -Ddisable_iconv_option=true -Ddisable_intl_option=true \
		--buildtype=debugoptimized -Ddefault_library=both \
		--libdir=usr/lib --bindir=usr/bin --includedir=usr/include \
		build

NINJA_FLAGS := -C build

COMPLETE := mlibc-src/build.complete

$(COMPLETE): $(TAR)
	rm -rf mlibc-src/build
	mkdir mlibc-src/build

	cd mlibc-src && meson setup $(MESON_FLAGS) -Dheaders_only=true
	DESTDIR=$(ARC_SYSROOT) meson install -C mlibc-src/build

	rm -rf mlibc-src/build
	mkdir mlibc-src/build

	cd mlibc-src && meson setup $(MESON_FLAGS) -Dmlibc_no_headers=true
	DESTDIR=$(ARC_SYSROOT) meson install -C mlibc-src/build

	touch $(COMPLETE)

$(TAR):
	rm -rf mlibc-src
	curl -o $(TAR) -L $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) mlibc-src
	cd mlibc-src && patch -p1 < ../mlibc.patch
