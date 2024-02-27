ARCTAN_HOME := $(shell pwd)
ARCTAN_INITRAMFS := $(ARCTAN_HOME)/initramfs/

export ARCTAN_HOME
export ARCTAN_INITRAMFS

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

