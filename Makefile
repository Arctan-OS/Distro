PRODUCT := Arctan.iso

REPO_BASE_LINK ?= https://github.com/Arctan-OS
LOCAL_KERNEL_DIR ?=
LOCAL_BSP_DIR ?=
QEMUFLAGS := -M q35,smm=off -m 4G -cdrom $(PRODUCT) -debugcon stdio -s

ARC_ROOT := $(shell pwd)
export ARC_ROOT

INITRAMFS := $(ARC_ROOT)/initramfs.cpio

.PHONY: all
all:
	rm -f $(PRODUCT) $(INITRAMFS)

	$(MAKE) $(PRODUCT)

$(PRODUCT): kernel
	$(MAKE) distro

.PHONY: distro
distro:
	rm -rf ./kernel/.git/
	rm -rf ./bootstrap/.git/
	
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
	qemu-system-x86_64 -enable-kvm -cpu qemu64 -d cpu_reset $(QEMUFLAGS)

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
