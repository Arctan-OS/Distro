# Installed on build machine:
#  help2man - autoconf
#  inetutils - autoconf `hostname`
# uname -r: 6.19.6-arch1-1

ARC_ROOT := $(PWD)
export ARC_ROOT

ARC_PRODUCT := $(ARC_ROOT)/Arctan.iso

BOB_VERSION := 2f744555e5db013bd293c86d5dd0f523d4a9ae38
BOB_URL := https://raw.githubusercontent.com/Arctan-OS/bob/$(BOB_VERSION)/bob.sh
BOB := $(ARC_ROOT)/bob-$(BOB_VERSION).sh

BOB_ROOT := $(ARC_ROOT)
BOB_MAKEFILE_NAME := arc.mk

export BOB_ROOT
export BOB_MAKEFILE_NAME

QEMUFLAGS := -M q35,smm=off -m 32M -boot d -cdrom $(ARC_PRODUCT) \
	     -enable-kvm -cpu qemu64,+la57,+pcid -smp 4  \
	     -drive file=test_disk.img,if=none,id=NVME1 \
	     -device nvme,drive=NVME1,serial=nvme-1 \
	     -d int,cpu_reset -no-reboot -no-shutdown \
	     -serial stdio \
#	     -trace "pci_nvme_*"

CORES ?= $(shell echo $$(($(shell nproc) / 2)))
MAKEFLAGS += -j$(CORES)
export MAKEFLAGS

##############################################
#                 Options                    #
##############################################
BSP   ?= GRUB
ARCH  ?= x86-64
LIBC  ?= mlibc
CONV  ?= sysv
SCHED ?= rr
COM   ?= 0x3F8
DEBUG ?= no

ARC_OPT_ARCH := x86_64
ARC_DEF_ARCH := -DARC_TARGET_ARCH_X86_64
ifeq ($(ARCH), ARM)
# x86-64 does not need to be accoutned for, as it is the
# default. Currently there is no support for other architectures
# so this is just left blank as a place holder for future reference
endif

export ARC_OPT_ARCH
export ARC_DEF_ARCH

ARC_OPT_CONV := SYSV
ARC_DEF_CONV := -DARC_TARGET_CONV_SYSV
# Placeholder convention
ifeq ($(CONV), AAA)
	ARC_OPT_CONV := 3A
	ARC_DEF_CONV := -DARC_TARGET_CONV_3A
endif

export ARC_OPT_CONV
export ARC_DEF_CONV

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
##############################################

##############################################
#               Executables                  #
##############################################
BEAR  ?= bear
CD    ?= cd
CHMOD ?= chmod
CP    ?= cp
CURL  ?= curl
ECHO  ?= echo
EXIT  ?= exit
FIND  ?= find
GIT   ?= git
LN    ?= ln
MESON ?= meson
MKDIR ?= mkdir
MV    ?= mv
QEMU  ?= qemu-system-$(ARC_OPT_ARCH)
RM    ?= rm
TAR   ?= tar
TOUCH ?= touch

export BEAR
export CD
export CHMOD
export CP
export CURL
export ECHO
export EXIT
export FIND
export GIT
export LN
export MESON
export MKDIR
export MV
export QEMU
export RM
export TAR
export TOUCH
##############################################

##############################################
#        Internal Paths, Variables           #
##############################################

ARC_SYSROOT       := $(ARC_ROOT)/sysroot
ARC_INITRAMFS     := $(ARC_ROOT)/initramfs
ARC_VOLATILE      := $(ARC_ROOT)/volatile
ARC_BUILD_SUPPORT := $(ARC_ROOT)/build-support

export ARC_SYSROOT
export ARC_INITRAMFS
export ARC_VOLATILE
export ARC_BUILD_SUPPORT

OS_TRIPLET        := $(ARC_OPT_ARCH)-pc-arctan-$(LIBC)
ARC_BUILD_PREFIX  := $(ARC_SYSROOT)/usr/cross
ARC_HOST_PREFIX   := $(ARC_SYSROOT)/usr

export OS_TRIPLET
export ARC_BUILD_PREFIX
export ARC_HOST_PREFIX

# TODO: Stop duplication of the first element in path
PATH                              := $(ARC_BUILD_PREFIX)/bin:$(PATH)
CFLAGS                            := -O2 -pipe -fstack-clash-protection
CXXFLAGS                          := $(CFLAGS) -Wp,-D_GLIBCXX_ASSERTIONS
LDFLAGS                           := -Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now
ARC_SET_BUILD_COMPILER_ENV_FLAGS  := CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"
ARC_SET_TARGET_COMPILER_ENV_FLAGS := CFLAGS_FOR_TARGET="$(CFLAGS)" CXXFLAGS_FOR_TARGET="$(CXXFLAGS)"
ARC_INCLUDE_DIRS                  := -I$(ARC_ROOT)/include -I$(ARC_SYSROOT)/include

export CFLAGS
export CXXFLAGS
export LDFLAGS
export ARC_SET_COMPILER_ENV_FLAGS
export ARC_SET_TARGET_COMPILER_ENV_FLAGS
export ARC_INCLUDE_DIRS

INITRAMFS_IMAGE := $(ARC_VOLATILE)/initramfs.cpio
LIVE_ENV_IMAGE  := $(ARC_VOLATILE)/live_env.cpio

ARC_PRODUCT_ENV_FLAGS := CC=$(OS_TRIPLET)-gcc LD=$(OS_TRIPLET)-ld STRIP="$(OS_TRIPLET)-strip -v"
##############################################

$(BOB):
	$(CURL) -o $(BOB) $(BOB_URL)
	$(CHMOD) +x $(BOB)

.PHONY: all
all: $(ARC_SYSROOT)
	$(RM) -f $(ARC_PRODUCT) $(INITRAMFS_IMAGE)
	$(MAKE) $(ARC_PRODUCT)

$(ARC_PRODUCT): $(BOB)
	$(BOB) build Arctan.iso
	$(MV) $(ARC_INITRAMFS)/userspace.elf $(ARC_VOLATILE)

$(ARC_SYSROOT):
	$(MKDIR) -p $(ARC_SYSROOT)             \
		    $(ARC_VOLATILE)            \
		    $(ARC_INITRAMFS)           \
		    $(ARC_HOST_PREFIX)/bin     \
		    $(ARC_HOST_PREFIX)/include \
		    $(ARC_HOST_PREFIX)/lib     \
		    $(ARC_HOST_PREFIX)/share

	$(LN) -sfT $(ARC_HOST_PREFIX)/bin     $(ARC_SYSROOT)/bin
	$(LN) -sfT $(ARC_HOST_PREFIX)/bin     $(ARC_SYSROOT)/sbin
	$(LN) -sfT $(ARC_HOST_PREFIX)/include $(ARC_SYSROOT)/include
	$(LN) -sfT $(ARC_HOST_PREFIX)/lib     $(ARC_SYSROOT)/lib
	$(LN) -sfT $(ARC_HOST_PREFIX)/lib     $(ARC_SYSROOT)/lib64

.PHONY: clean-all
clean-all: $(BOB)
	$(RM) -rf $(ARC_SYSROOT) $(ARC_VOLATILE)
	$(BOB) clean all

.PHONY: rebuild-all
rebuild-all: $(BOB)
	$(RM) -rf $(ARC_SYSROOT) $(ARC_VOLATILE)
	$(BOB) rebuild all
	$(MV) $(ARC_INITRAMFS)/userspace.elf $(ARC_VOLATILE)

TARGET ?=

.PHONY: clean
clean: $(BOB)
	$(BOB) clean $(TARGET)

.PHONY: rebuild
rebuild: $(BOB)
	$(BOB) rebuild $(TARGET)

.PHONY: mkpatch
mkpatch: $(BOB)
	$(BOB) mkpatch $(TARGET)

.PHONY: run
run: $(ARC_PRODUCT)
	$(QEMU) $(QEMUFLAGS)

.PHONY: drun
drun: $(ARC_PRODUCT)
	$(QEMU) $(QEMUFLAGS) -s -S
