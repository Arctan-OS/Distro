REPO_BASE_LINK ?= https://github.com/Arctan-OS
LOCAL_KERNEL_DIR ?=
LOCAL_BSP_DIR ?=

ARC_PRODUCT := Arctan.iso

export ARC_PRODUCT

QEMUFLAGS := -M q35,smm=off -m 4G -cdrom $(ARC_PRODUCT) -debugcon stdio -enable-kvm -cpu qemu64 -d cpu_reset -smp 4

ARC_ROOT := $(shell pwd)

export ARC_ROOT

ARC_SYSROOT := $(ARC_ROOT)/sysroot/

export ARC_SYSROOT

ARC_INITRAMFS_CONSTANT := $(ARC_ROOT)/initramfs-constant/

ARC_TOOLCHAIN_BUILD := $(ARC_ROOT)/toolchain-build/

export ARC_TOOLCHAIN_BUILD

ARC_TOOLCHAIN_HOST := $(ARC_ROOT)/toolchain-host/

export ARC_TOOLCHAIN_HOST

ARC_VOLATILE := $(ARC_ROOT)/volatile/

export ARC_VOLATILE

OS_TRIPLET := x86_64-pc-arctan-mlibc

export OS_TRIPLET

ARCH ?=

ifeq ($(ARCH), x86-64)
	ARC_TARGET_ARCH := -DARC_TARGET_ARCH_X86_64
else
# Default to x86-64
	ARC_TARGET_ARCH := -DARC_TARGET_ARCH_X86_64
endif

export ARC_TARGET_ARCH

INITRAMFS_IMAGE := $(ARC_ROOT)/initramfs.cpio

MAKEFLAGS += -j12
#$(( $(shell nproc) / 2 ))

PREFIX := /usr/

export PREFIX

PATH := $(ARC_SYSROOT)/$(PREFIX)/local/bin:$(PATH)

export PATH

CFLAGS=-O2 -pipe -fstack-clash-protection

export CFLAGS

CXXFLAGS=$(CFLAGS) -Wp,-D_GLIBCXX_ASSERTIONS

export CXXFLAGS

LDFLAGS=-Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now

export LDFLAGS

ARC_SET_BUILD_COMPILER_ENV_FLAGS := CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"

export ARC_SET_COMPILER_ENV_FLAGS

ARC_SET_TARGET_COMPILER_ENV_FLAGS := CFLAGS_FOR_TARGET="$(CFLAGS)" CXXFLAGS_FOR_TARGET="$(CXXFLAGS)"

export ARC_SET_TARGET_COMPILER_ENV_FLAGS

.PHONY: all
all:
	rm -f $(ARC_PRODUCT) $(INITRAMFS_IMAGE)
	mkdir -p $(ARC_INITRAMFS) $(ARC_SYSROOT) $(ARC_VOLATILE)
	mkdir -p $(ARC_SYSROOT)/$(PREFIX)/bin $(ARC_SYSROOT)/$(PREFIX)/include $(ARC_SYSROOT)/$(PREFIX)/lib

	ln -sfT $(ARC_SYSROOT)/$(PREFIX)/bin $(ARC_SYSROOT)/bin
	ln -sfT $(ARC_SYSROOT)/$(PREFIX)/bin $(ARC_SYSROOT)/sbin
	ln -sfT $(ARC_SYSROOT)/$(PREFIX)/include $(ARC_SYSROOT)/include
	ln -sfT $(ARC_SYSROOT)/$(PREFIX)/lib $(ARC_SYSROOT)/lib
	ln -sfT $(ARC_SYSROOT)/$(PREFIX)/lib $(ARC_SYSROOT)/lib64

# Make the build machine's toolchain under $(ARC_BUILD)
	$(MAKE) -C $(ARC_TOOLCHAIN_BUILD)
# Put together the host machine's toolchain and other dependencies under $(ARC_HOST)
	$(MAKE) -C $(ARC_TOOLCHAIN_HOST)
# Put together the ISO using the toolchain
	CC=$(OS_TRIPLET)-gcc LD=$(OS_TRIPLET)-ld $(MAKE) $(ARC_PRODUCT)

$(ARC_PRODUCT):
	$(MAKE) distro

.PHONY: distro
distro: kernel
# Construct the initramfs
	cp -r $(ARC_INITRAMFS_CONSTANT)/* $(ARC_SYSROOT)
	cd $(ARC_SYSROOT) && find . | cpio -o > $(INITRAMFS_IMAGE)

# Do the two big things
	$(MAKE) -C volatile/kernel
	$(MAKE) -C volatile/bootstrap

.PHONY: clean
clean:
	rm -f $(INITRAMFS_IMAGE)
	rm -rf $(ARC_INITRAMFS) $(ARC_SYSROOT) $(ARC_VOLATILE)
	find . -type f -name "*.tar.gz" -delete -or -name "*.complete" -delete

.PHONY: prepare-rebuild
prepare-rebuild:
	rm -f $(INITRAMFS_IMAGE)
	rm -rf $(ARC_INITRAMFS) $(ARC_SYSROOT)
	find . -type f -name "build.complete" -delete

.PHONY: run
run: $(ARC_PRODUCT)
	qemu-system-x86_64 $(QEMUFLAGS)

# Bootstrappers
# MB2
.PHONY: mb2
mb2:
	mkdir -p $(ARC_VOLATILE)/bootstrap
	rm -rf $(ARC_VOLATILE)/bootstrap
ifeq ($(LOCAL_BSP_DIR),)
	git clone $(REPO_BASE_LINK)/MB2BSP $(ARC_VOLATILE)/bootstrap/
else
	cp -r $(LOCAL_BSP_DIR) $(ARC_VOLATILE)/bootstrap/
endif
# /MB2

# LBP
.PHONY: lbp
lbp:
	mkdir -p $(ARC_VOLATILE)/bootstrap
	rm -rf $(ARC_VOLATILE)/bootstrap
ifeq ($(LOCAL_BSP_DIR),)
	git clone $(REPO_BASE_LINK)/LBPBSP $(ARC_VOLATILE)/bootstrap/
else
	cp -r $(LOCAL_BSP_DIR) $(ARC_VOLATILE)/bootstrap/
endif
# /LBP

.PHONY: kernel
kernel:
	mkdir -p $(ARC_VOLATILE)
	rm -rf $(ARC_VOLATILE)/kernel
ifeq ($(LOCAL_KERNEL_DIR),)
	git clone $(REPO_BASE_LINK)/Kernel $(ARC_VOLATILE)/kernel/
else
	cp -r $(LOCAL_KERNEL_DIR) ./volatile/kernel/
endif
