PRODUCT := Arctan.iso

REPO_BASE_LINK ?= https://github.com/Arctan-OS
LOCAL_KERNEL_DIR ?=
LOCAL_BSP_DIR ?=
QEMUFLAGS := -M q35,smm=off -m 4G -cdrom $(PRODUCT) -debugcon stdio -enable-kvm -cpu qemu64 -d cpu_reset -smp 4

ARC_ROOT := $(shell pwd)
export ARC_ROOT

ARCH ?=

ifeq ($(ARCH), x86-64)
	ARC_TARGET_ARCH := -DARC_TARGET_ARCH_X86_64
else
# Default to x86-64
	ARC_TARGET_ARCH := -DARC_TARGET_ARCH_X86_64
endif

export ARC_TARGET_ARCH

INITRAMFS := $(ARC_ROOT)/initramfs.cpio

.PHONY: all
all:
	rm -f $(PRODUCT) $(INITRAMFS)

	$(MAKE) $(PRODUCT)

$(PRODUCT):
	$(MAKE) distro

.PHONY: distro
distro: kernel
# Do everything else

# Construct the initramfs
	cd ./initramfs/ && find . | cpio -o > $(INITRAMFS)

# Do the two big things
	make -C volatile/kernel
	make -C volatile/bootstrap

.PHONY: clean
	rm -f $(INITRAMFS)

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
