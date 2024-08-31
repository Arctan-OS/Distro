PRODUCT := Arctan.iso

REPO_BASE_LINK ?= https://github.com/Arctan-OS
LOCAL_KERNEL_DIR ?=
LOCAL_BSP_DIR ?=
QEMUFLAGS := -M q35,smm=off -m 4G -cdrom $(PRODUCT) -debugcon stdio -enable-kvm -cpu qemu64 -d cpu_reset -smp 4

ARC_ROOT := $(shell pwd)
export ARC_ROOT
ARC_INITRAMFS := $(ARC_ROOT)/initramfs/
export ARC_INITRAMFS
ARC_TOOLCHAIN := $(ARC_ROOT)/toolchain/
export ARC_TOOLCHAIN

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

INITRAMFS := $(ARC_ROOT)/initramfs.cpio

MAKEFLAGS += -j$$( ($(nproc) / 2 ))

.PHONY: all
all:
	rm -f $(PRODUCT) $(INITRAMFS)
	rm -rf $(ARC_INITRAMFS)
	mkdir -p $(ARC_INITRAMFS) $(ARC_TOOLCHAIN)

# Make the host's toolchain under $(ARC_TOOLCHAIN)
	$(MAKE) -C host
# Put together the target's toolchain and other dependencies under $(ARC_INITRAMFS)
	$(MAKE) -C target CC=$(ARC_TOOLCHAIN)/bin/$(OS_TRIPLET)-gcc LD=$(ARC_TOOLCHAIN)/bin/$(OS_TRIPLET)-ld
# Put togeth the ISO
	$(MAKE) $(PRODUCT) CC=$(ARC_TOOLCHAIN)/bin/$(OS_TRIPLET)-gcc LD=$(ARC_TOOLCHAIN)/bin/$(OS_TRIPLET)-ld

$(PRODUCT):
	$(MAKE) distro

.PHONY: distro
distro: kernel
# Construct the initramfs
	cp -r ./constant/* ./initramfs/
	cd ./initramfs/ && find . | cpio -o > $(INITRAMFS)

# Do the two big things
	make -C volatile/kernel
	make -C volatile/bootstrap

.PHONY: clean
clean:
	rm -f $(INITRAMFS)
	rm -rf $(ARC_INITRAMFS) $(ARC_TOOLCHAIN)
	find . -type f -name "*.tar.gz" -or -name "*.complete" -delete

.PHONY: prepare-rebuild
prepare-rebuild:
	rm -f $(INITRAMFS)
	rm -rf $(ARC_INITRAMFS) $(ARC_TOOLCHAIN)
	find . -type f -name "build.complete" -delete

.PHONY: run
run: $(PRODUCT)
	qemu-system-x86_64 $(QEMUFLAGS)

# Bootstrappers
# MB2
.PHONY: mb2
mb2:
	rm -rf ./volatile/bootstrap
ifeq ($(LOCAL_BSP_DIR),)
	git clone $(REPO_BASE_LINK)/MB2BSP ./volatile/bootstrap/
else
	cp -r $(LOCAL_BSP_DIR) ./volatile/bootstrap/
endif
# /MB2

# LBP
.PHONY: lbp
lbp:
	rm -rf ./volatile/bootstrap
ifeq ($(LOCAL_BSP_DIR),)
	git clone $(REPO_BASE_LINK)/LBPBSP ./volatile/bootstrap/
else
	cp -r $(LOCAL_BSP_DIR) ./volatile/bootstrap/
endif
# /LBP

.PHONY: kernel
kernel:
	rm -rf ./volatile/kernel
ifeq ($(LOCAL_KERNEL_DIR),)
	git clone $(REPO_BASE_LINK)/Kernel ./volatile/kernel/
else
	cp -r $(LOCAL_KERNEL_DIR) ./volatile/kernel/
endif
