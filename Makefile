REPO_BASE_LINK ?= https://github.com/Arctan-OS

ARC_PRODUCT := Arctan.iso
QEMUFLAGS := -M q35,smm=off -m 4G -boot d -cdrom $(ARC_PRODUCT) -debugcon stdio -enable-kvm -cpu qemu64 -d cpu_reset -smp 4  \
	     -drive file=test_disk.img,if=none,id=NVME1 \
	     -device nvme,drive=NVME1,serial=nvme-1

ARC_ROOT := $(shell pwd)



BSP ?= MB2
ARCH ?= x86-64
LIBC ?= mlibc
SCHED ?= rr

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

ARC_SYSROOT := $(ARC_ROOT)/sysroot/
ARC_INITRAMFS_CONSTANT := $(ARC_ROOT)/initramfs-constant/
ARC_TOOLCHAIN_BUILD := $(ARC_ROOT)/toolchain-build/
ARC_TOOLCHAIN_HOST := $(ARC_ROOT)/toolchain-host/
ARC_VOLATILE := $(ARC_ROOT)/volatile/
OS_TRIPLET := $(ARC_OPT_ARCH)-pc-arctan-$(LIBC)
INITRAMFS_IMAGE := $(ARC_VOLATILE)/initramfs.cpio
LIVE_ENV_IMAGE := $(ARC_VOLATILE)/live_env.cpio
MAKEFLAGS += -j$(($(shell nproc) / 2))
PREFIX := /usr/
PATH := $(ARC_SYSROOT)/$(PREFIX)/local/bin:$(PATH)
CFLAGS=-O2 -pipe -fstack-clash-protection
CXXFLAGS=$(CFLAGS) -Wp,-D_GLIBCXX_ASSERTIONS
LDFLAGS=-Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now
ARC_SET_BUILD_COMPILER_ENV_FLAGS := CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
ARC_SET_TARGET_COMPILER_ENV_FLAGS := CFLAGS_FOR_TARGET="$(CFLAGS)" CXXFLAGS_FOR_TARGET="$(CXXFLAGS)"

export ARC_SYSROOT
export ARC_TOOLCHAIN_BUILD
export ARC_TOOLCHAIN_HOST
export ARC_VOLATILE
export OS_TRIPLET
export ARC_ROOT
export ARC_PRODUCT
export PREFIX
export CFLAGS
export CXXFLAGS
export LDFLAGS
export ARC_SET_COMPILER_ENV_FLAGS
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
ifeq ($(BSP),)
	echo "No bootstrapper specified"
	exit 1
endif

# Do the big things
	$(MAKE) -C ../Kernel all
	$(MAKE) -C ../Userspace all

# Construct the initramfs
	cd $(ARC_INITRAMFS_CONSTANT) && find . | cpio -o > $(INITRAMFS_IMAGE)
	cd $(ARC_SYSROOT) && find . | cpio -o > $(LIVE_ENV_IMAGE)

	if [ ! -d "../$(BSP)BSP" ]; then \
		git clone $(REPO_BASE_LINK)/$(BSP)BSP ../$(BSP)BSP; \
		cd ../$(BSP)BSP && git submodule update --init --recursive; \
	fi
	$(MAKE) -C ../$(BSP)BSP all

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
