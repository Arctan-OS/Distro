REPO_BASE_LINK ?= https://github.com/Arctan-OS
ARC_BSP :=

ARC_PRODUCT := Arctan.iso

export ARC_PRODUCT

QEMUFLAGS := -M q35,smm=off -m 4G -boot d -cdrom $(ARC_PRODUCT) -debugcon stdio -enable-kvm -cpu qemu64 -d cpu_reset -smp 4  \
	     -drive file=test_disk.img,if=none,id=NVME1 \
	     -device nvme,drive=NVME1,serial=nvme-1

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

KARCH_TARGET := arch-x86-64

ifeq ($(ARCH), x86-64)
	ARC_TARGET_ARCH := -DARC_TARGET_ARCH_X86_64
	KARCH_TARGET := arch-x86-64
else
# Default to x86-64
	ARC_TARGET_ARCH := -DARC_TARGET_ARCH_X86_64
endif

export ARC_TARGET_ARCH

INITRAMFS_IMAGE := $(ARC_VOLATILE)/initramfs.cpio

LIVE_ENV_IMAGE := $(ARC_VOLATILE)/live_env.cpio

MAKEFLAGS += -j$(($(shell nproc) / 2))

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
	mkdir -p $(ARC_INITRAMFS) $(ARC_SYSROOT)
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
	mkdir -p $(ARC_ROOT)/volatile
	$(MAKE) distro

.PHONY: distro
distro: userspace
ifeq ($(ARC_BSP),)
	echo "No bootstrapper specified"
	exit 1
endif

# Do the big things
	$(MAKE) -C ../Kernel all $(KARCH_TARGET)
	$(MAKE) -C ../Userspace all $(KARCH_TARGET)

# Construct the initramfs
	cd $(ARC_INITRAMFS_CONSTANT) && find . | cpio -o > $(INITRAMFS_IMAGE)
	cd $(ARC_SYSROOT) && find . | cpio -o > $(LIVE_ENV_IMAGE)

	if [ ! -d "../$(ARC_BSP)BSP" ]; then \
		git clone $(REPO_BASE_LINK)/$(ARC_BSP)BSP ../$(ARC_BSP)BSP; \
		cd ../$(ARC_BSP)BSP && git submodule update --init --recursive; \
	fi
	$(MAKE) -C ../$(ARC_BSP)BSP all

.PHONY: clean
clean:
	rm -rf $(ARC_SYSROOT) $(ARC_VOLATILE)
	find . -type f -name "*.tar.gz" -delete -or -name "*.complete" -delete

.PHONY: prepare-rebuild
prepare-rebuild:
	rm -rf $(ARC_SYSROOT) $(ARC_VOLATILE)
	find . -type f -name "build.complete" -delete

.PHONY: run
run: $(ARC_PRODUCT)
	qemu-system-x86_64 $(QEMUFLAGS)

# Bootstrappers
# MB2
.PHONY: mb2
mb2:
# /MB2

.PHONY: kernel
kernel:
	if [ ! -d "../Kernel" ]; then \
		git clone $(REPO_BASE_LINK)/Kernel ../Kernel; \
		cd ../Kernel && git submodule update --init --recursive; \
	fi

.PHONY: userspace
userspace: kernel
	if [ ! -d "../Userspace" ]; then \
		git clone $(REPO_BASE_LINK)/Userspace ../Userspace; \
		cd ../Userspace && git submodule update --init --recursive; \
	fi
