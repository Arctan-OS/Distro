PREFIX_DIR := $(ARCTAN_INITRAMFS)/

MESON_FLAGS :=  --reconfigure --cross-file arctan_crossfile.txt --prefix=$(PREFIX_DIR) \
				--sysconfdir=/etc --localstatedir=/var --libdir=lib --sbindir=bin --buildtype=release -Ddefault_library=shared \
				--buildtype=debugoptimized -Ddefault_library=both \
				-Ddisable_ansi_option=false -Ddisable_crypt_option=true -Ddisable_posix_option=false -Ddisable_linux_option=true \
				-Ddisable_iconv_option=true -Ddisable_intl_option=true -Ddisable_glibc_option=false -Ddisable_bsd_option=false \
				-Ddisable_libgcc_dependency=false

MESON_BUILD_DIR := build

.PHONY: all
all: clean
	$(shell curl -O $(WEBSERVER)/mlibc.tar)
	$(shell curl -O $(WEBSERVER)/mlibc.tar.sha256)
	$(shell sha256sum -c mlibc.tar.sha256 > /dev/null)
	$(shell tar --extract -f mlibc.tar)
	
	cp arctan_crossfile.txt mlibc/
	cd mlibc/ && git apply ../mlibc_arctan.patch

	# Build library files
	cd mlibc/ && meson setup $(MESON_BUILD_DIR) $(MESON_FLAGS) -Dmlibc_no_headers=true
	meson install -C $(shell pwd)/mlibc/$(MESON_BUILD_DIR)

	# Build headers
	cd mlibc/ && meson setup $(MESON_BUILD_DIR) $(MESON_FLAGS) -Dmlibc_no_headers=false
	meson install -C $(shell pwd)/mlibc/$(MESON_BUILD_DIR)
	
	rm -rf mlibc.* mlibc/

.PHONY: clean
clean:
	rm -rf mlibc.* mlibc/
