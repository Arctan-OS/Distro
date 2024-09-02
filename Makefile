REPO_BASE_LINK ?= https://github.com/Arctan-OS
LOCAL_KERNEL_DIR ?=
LOCAL_BSP_DIR ?=
QEMUFLAGS := -M q35,smm=off -m 4G -cdrom $(PRODUCT) -debugcon stdio -enable-kvm -cpu qemu64 -d cpu_reset -smp 4

ARC_PRODUCT := Arctan.iso

export ARC_PRODUCT

ARC_ROOT := $(shell pwd)

export ARC_ROOT

ARC_BUILD := $(ARC_ROOT)/build/

export ARC_BUILD

ARC_HOST := $(ARC_ROOT)/host/

export ARC_HOST

ARC_INITRAMFS := $(ARC_ROOT)/initramfs/

export ARC_INITRAMFS

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

MAKEFLAGS += -j$(( $(shell nproc) / 2 ))

PATH := $(ARC_BUILD)/usr/bin:$(PATH)

export PATH

.PHONY: all
all:
	rm -f $(ARC_PRODUCT) $(INITRAMFS_IMAGE)
	rm -rf $(ARC_INITRAMFS)
	mkdir -p $(ARC_INITRAMFS) $(ARC_BUILD) $(ARC_HOST) $(ARC_VOLATILE)

# Make the build machine's toolchain under $(ARC_BUILD)
	$(MAKE) -C $(ARC_TOOLCHAIN_BUILD)
# Put together the host machine's toolchain and other dependencies under $(ARC_HOST)
	$(MAKE) -C $(ARC_TOOLCHAIN_HOST)
# Put together the ISO using the toolchain
#	$(MAKE) $(ARC_PRODUCT)

$(ARC_PRODUCT):
	$(MAKE) distro

.PHONY: distro
distro: kernel
# Construct the initramfs
	cp -r $(ARC_INITRAMFS_CONSTANT)/* $(ARC_INITRAMFS)
	cp -r $(ARC_INITRAMFS_CONSTANT)/* $(ARC_INITRAMFS)
	cd $(ARC_INITRAMFS) && find . | cpio -o > $(INITRAMFS_IMAGE)

# Do the two big things
	$(MAKE) -C volatile/kernel
	$(MAKE) -C volatile/bootstrap

.PHONY: clean
clean:
	rm -f $(INITRAMFS_IMAGE)
	rm -rf $(ARC_INITRAMFS) $(ARC_BUILD) $(ARC_HOST)  $(ARC_VOLATILE)
	find . -type f -name "*.tar.gz" -or -name "*.complete" -delete

.PHONY: prepare-rebuild
prepare-rebuild:
	rm -f $(INITRAMFS_IMAGE)
	rm -rf $(ARC_INITRAMFS) $(ARC_BUILD) $(ARC_HOST)
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
