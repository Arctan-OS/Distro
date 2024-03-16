LOCAL_KERNEL_DIR ?=
QEMUFLAGS := -M q35,smm=off -m 4G -cdrom Arctan.iso -debugcon stdio -s

KERNEL_REGEN ?= 0

.PHONY: all
all:
	rm -f Arctan.iso
	rm -rf kernel
	$(MAKE) Arctan.iso

.PHONY: Arctan.iso
Arctan.iso:
	$(MAKE) distro

	mkdir -p iso/boot/grub

	# Put initramfs together
	cd initramfs/ && find . -type f | cpio -o > ../iso/boot/initramfs.cpio

	# Copy various important things to grub directory
	cp -u kernel/kernel/kernel.elf iso/boot
	cp kernel/bootstrap/bootstrap.elf iso/boot
	cp grub.cfg iso/boot/grub

	# Create ISO
	grub-mkrescue -o Arctan.iso iso

.PHONY: kernel
kernel:
	rm -f builds/kernel.built builds/kernel.packaged
ifeq ($(LOCAL_KERNEL_DIR),)
	git clone https://github.com/awewsomegamer/Arctan-Kernel ./kernel
else
	cp -r $(LOCAL_KERNEL_DIR) ./kernel/
endif
ifeq ($(KERNEL_REGEN),1)
	./jinx regenerate kernel
endif

.PHONY: jinx
jinx:
	curl -O https://raw.githubusercontent.com/mintsuki/jinx/trunk/jinx
	chmod +x jinx

.PHONY: distro
distro: jinx kernel
	./jinx build-all

.PHONY: clean
clean:
	./jinx clean

.PHONY: run
run: all
	qemu-system-x86_64 -enable-kvm -cpu qemu64 -d cpu_reset $(QEMUFLAGS)
