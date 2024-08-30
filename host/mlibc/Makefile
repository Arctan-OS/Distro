REPO := https://github.com/managarm/mlibc
MESON_FLAGS := --reconfigure --cross-file $(ARC_ROOT)/build-support/cross.txt --prefix=$(PREFIX) \
		 -Ddisable_crypt_option=true -Ddisable_iconv_option=true -Ddisable_intl_option=true \
		--buildtype=debugoptimized -Ddefault_library=both \
		--libdir=usr/lib --bindir=usr/bin --includedir=usr/include \
		build

NINJA_FLAGS := -j8 -C build
RCOMPLETE := mlibc/repo.complete
COMPLETE := mlibc/build.complete

$(COMPLETE): $(RCOMPLETE)
	rm -rf mlibc/build
	mkdir mlibc/build

	cd mlibc && meson setup $(MESON_FLAGS) -Dheaders_only=true
	DESTDIR=$(DESTDIR) meson install -C mlibc/build

	rm -rf mlibc/build
	mkdir mlibc/build

	cd mlibc && meson setup $(MESON_FLAGS) -Dmlibc_no_headers=true
	DESTDIR=$(DESTDIR) meson install -C mlibc/build

	touch $(COMPLETE)

$(RCOMPLETE):
	git clone $(REPO)
	cd mlibc && git apply ../mlibc.patch
	touch $(RCOMPLETE)
