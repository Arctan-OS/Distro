REPO_BASE_LINK ?= https://github.com/Arctan-OS

ARC_ROOT := $(shell pwd)
ARC_PRODUCT := $(ARC_ROOT)/Arctan.iso

export ARC_ROOT
export ARC_PRODUCT

BSP ?= GRUB
ARCH ?= x86-64
LIBC ?= mlibc
SCHED ?= rr
COM ?=
DEBUG ?=
CORES ?= $(shell echo $$(($(shell nproc) / 2)))
MAKEFLAGS += -j$(CORES)

ARC_OPT_ARCH := x86_64
ARC_DEF_ARCH := -DARC_TARGET_ARCH_X86_64
ifeq ($(ARCH), ARM)
# x86-64 does not need to be accoutned for, as it is the
# default. Currently there is no support for other architectures
# so this is just left blank as a place holder for future reference
endif

export ARC_OPT_ARCH
export ARC_DEF_ARCH

ARC_OPT_SCHED := RR
ARC_DEF_SCHED := -DARC_TARGET_SCHED_RR
ifeq ($(SCHED), MLFQ)
	ARC_OPT_SCHED := MLFQ
	ARC_DEF_SCHED := -DARC_TARGET_SCHED_MLFQ
endif

export ARC_OPT_SCHED
export ARC_DEF_SCHED

ARC_OPT_COM := $(COM)
ARC_DEF_COM := -DARC_COM_PORT=$(ARC_OPT_COM)

export ARC_OPT_COM
export ARC_DEF_COM

ARC_OPT_DEBUG := $(DEBUG)
ifeq ($(shell echo $(DEBUG) | tr A-Z a-z),yes)
	ARC_DEF_DEBUG := -DARC_DEBUG_ENABLE
endif

export ARC_OPT_DEBUG
export ARC_DEF_DEBUG

ARC_SYSROOT := $(ARC_ROOT)/sysroot
ARC_INITRAMFS := $(ARC_ROOT)/initramfs
ARC_TOOLCHAIN_BUILD := $(ARC_ROOT)/toolchain-build
ARC_TOOLCHAIN_HOST := $(ARC_ROOT)/toolchain-host
ARC_VOLATILE := $(ARC_ROOT)/volatile
ARC_BUILD_SUPPORT := $(ARC_ROOT)/build-support
ARC_INCLUDE_DIRS := -I$(ARC_ROOT)/include -I$(ARC_SYSROOT)/include

export ARC_SYSROOT
export ARC_INITRAMFS
export ARC_TOOLCHAIN_BUILD
export ARC_TOOLCHAIN_HOST
export ARC_VOLATILE
export ARC_BUILD_SUPPORT
export ARC_INCLUDE_DIRS

OS_TRIPLET := $(ARC_OPT_ARCH)-pc-arctan-$(LIBC)
ARC_BUILD_PREFIX := $(ARC_SYSROOT)/usr/cross
ARC_HOST_PREFIX := $(ARC_SYSROOT)/usr

export OS_TRIPLET
export ARC_BUILD_PREFIX
export ARC_HOST_PREFIX

PATH := $(ARC_BUILD_PREFIX)/bin:$(PATH)
CFLAGS=-O2 -pipe -fstack-clash-protection
CXXFLAGS=$(CFLAGS) -Wp,-D_GLIBCXX_ASSERTIONS
LDFLAGS=-Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now
ARC_SET_BUILD_COMPILER_ENV_FLAGS := CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
ARC_SET_TARGET_COMPILER_ENV_FLAGS := CFLAGS_FOR_TARGET="$(CFLAGS)" CXXFLAGS_FOR_TARGET="$(CXXFLAGS)"

export CFLAGS
export CXXFLAGS
export LDFLAGS
export ARC_SET_COMPILER_ENV_FLAGS
export ARC_SET_TARGET_COMPILER_ENV_FLAGS

INITRAMFS_IMAGE := $(ARC_VOLATILE)/initramfs.cpio
LIVE_ENV_IMAGE := $(ARC_VOLATILE)/live_env.cpio

QEMUFLAGS := -M q35,smm=off -m 4G -boot d -cdrom $(ARC_PRODUCT) -serial mon:stdio \
	     -enable-kvm -cpu qemu64 -smp 4  \
	     -drive file=test_disk.img,if=none,id=NVME1 \
	     -device nvme,drive=NVME1,serial=nvme-1 \
	     -d int,cpu_reset

# Set these exports for the many Makefiles in $(ARC_TOOLCHAIN_BUILD)
# and $(ARC_TOOLCHAIN_HOST) such that they can interface with some of
# the build support utilities (like $(ARC_BUILD_SUPPORT)/tar_helper.sh)
export ARC_VERSION
export ARC_NAME
export ARC_SOURCE_DIR
export ARC_TAR
export ARC_MIRROR

.PHONY: all
all:
ifeq ($(BSP),)
	echo "No bootstrapper specified"
	exit 1
endif

ifeq ($(wildcard ../Kernel),)
	git clone $(REPO_BASE_LINK)/Kernel ../Kernel --depth 1
	cd ../Kernel && git submodule update --init
endif

ifeq ($(wildcard ../Userspace),)
	git clone $(REPO_BASE_LINK)/Userspace ../Userspace --depth 1
	cd ../Userspace && git submodule update --init
endif

ifeq ($(wildcard ../BSP-$(BSP)),)
	git clone $(REPO_BASE_LINK)/BSP-$(BSP) ../BSP-$(BSP) --depth 1
	cd ../BSP-$(BSP) && git submodule update --init
endif

	rm -f $(ARC_PRODUCT) $(INITRAMFS_IMAGE)
	mkdir -p $(ARC_INITRAMFS) $(ARC_SYSROOT) $(ARC_VOLATILE) \
		 $(ARC_HOST_PREFIX)/bin \
		 $(ARC_HOST_PREFIX)/include \
		 $(ARC_HOST_PREFIX)/lib \
		 $(ARC_HOST_PREFIX)/share

	ln -sfT $(ARC_HOST_PREFIX)/bin     $(ARC_SYSROOT)/bin
	ln -sfT $(ARC_HOST_PREFIX)/bin     $(ARC_SYSROOT)/sbin
	ln -sfT $(ARC_HOST_PREFIX)/include $(ARC_SYSROOT)/include
	ln -sfT $(ARC_HOST_PREFIX)/lib     $(ARC_SYSROOT)/lib
	ln -sfT $(ARC_HOST_PREFIX)/lib     $(ARC_SYSROOT)/lib64

# Make the build machine's toolchain under $(ARC_BUILD)
	$(MAKE) -C $(ARC_TOOLCHAIN_BUILD)
# Put together the host machine's toolchain and other dependencies under $(ARC_HOST)
	$(MAKE) -C $(ARC_TOOLCHAIN_HOST)
# Put together the ISO using the toolchain
	CC=$(OS_TRIPLET)-gcc LD=$(OS_TRIPLET)-ld STRIP="$(OS_TRIPLET)-strip -v" $(MAKE) $(ARC_PRODUCT)

$(ARC_PRODUCT):
# Do the big things
	bear --output ../Kernel/compile_commands.json -- $(MAKE) -C ../Kernel all
	bear --output ../Userspace/compile_commands.json -- $(MAKE) -C ../Userspace all

# Construct the initramfs
	cd $(ARC_INITRAMFS) && find . | cpio -o > $(INITRAMFS_IMAGE)
	cd $(ARC_SYSROOT) && find . | cpio -o > $(LIVE_ENV_IMAGE)

	bear --output ../BSP-$(BSP)/compile_commands.json -- $(MAKE) -C ../BSP-$(BSP) all

.PHONY: clean
clean: prepare-rebuild
	$(MAKE) -C ../Kernel clean
	$(MAKE) -C ../Userspace clean
	$(MAKE) -C ../BSP-$(BSP) clean
	find . -type f -name "*.tar.gz" -delete

.PHONY: prepare-rebuild
prepare-rebuild:
	rm -rf $(ARC_SYSROOT) $(ARC_VOLATILE) $(ARC_PRODUCT)
	find . -type f -name "build.complete" -delete
	find $(ARC_TOOLCHAIN_HOST)/  -depth -type d -name "*-src" -exec rm -rf "{}" \; -or -name "build" -type d -exec rm -rf "{}" \;
	find $(ARC_TOOLCHAIN_BUILD)/ -depth -type d -name "*-src" -exec rm -rf "{}" \; -or -name "build" -type d -exec rm -rf "{}" \;

.PHONY: run
run: $(ARC_PRODUCT)
	qemu-system-x86_64 $(QEMUFLAGS)
