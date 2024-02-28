ARC_ROOT := $(shell pwd)
PRODUCT := $(ARC_ROOT)/Arctan
WEBSERVER := http://awewsomegaming.net/Files/tar/

export ARC_ROOT
export PRODUCT
export WEBSERVER

ARCTAN_HOME := $(shell pwd)
ARCTAN_INITRAMFS := $(ARCTAN_HOME)/initramfs/

export ARCTAN_HOME
export ARCTAN_INITRAMFS

LOCAL_KERNEL_DIR ?=
export LOCAL_KERNEL_DIR

.PHONY: all
all: deps
	mkdir -p iso/boot/grub

	# Put initramfs together
	cd initramfs/ && find . -type f | cpio -o > ../iso/boot/initramfs.cpio

	# Copy various important things to grub directory
	cp -u kernel.elf iso/boot
	cp bootstrap.elf iso/boot
	cp grub.cfg iso/boot/grub

	# Create ISO
	grub-mkrescue -o $(PRODUCT).iso iso


.PHONY: deps
deps:
	make -C deps

CPPFLAG_E9HACK :=
CPPFLAG_DEBUG :=
QEMUFLAGS := -M q35,smm=off -m 4G -cdrom $(PRODUCT).iso -debugcon stdio -s

export CPPFLAG_E9HACK
export CPPFLAG_DEBUG

debug: CPPFLAG_DEBUG = -DARC_DEBUG_ENABLE
debug: e9hack

e9hack: CPPFLAG_E9HACK = -DARC_E9HACK_ENABLE
e9hack: all

.PHONY: run
run: all
	qemu-system-x86_64 -enable-kvm -cpu qemu64 -d cpu_reset $(QEMUFLAGS)

.PHONY: clean
clean:
	make -C deps clean
	rm -rf iso *.iso kernel.elf bootstrap.elf