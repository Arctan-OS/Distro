REPO_BASE_LINK ?= https://github.com/awewsomegamer
LOCAL_KERNEL_DIR ?=
LOCAL_BSP_DIR ?=
QEMUFLAGS := -M q35,smm=off -m 4G -cdrom Arctan.iso -debugcon stdio -s

.PHONY: all
all:
	rm -f Arctan.iso
	$(MAKE) Arctan.iso

.PHONY: Arctan.iso
Arctan.iso: jinx kernel	
	# Put initramfs together
	cd initramfs/ && find . -type f | cpio -o > ../initramfs.cpio

	$(MAKE) distro
	
.PHONY: kernel
kernel:
	rm -rf kernel/
	rm -f builds/kernel.built builds/kernel.packaged builds/kernel.regenerated
ifeq ($(LOCAL_KERNEL_DIR),)
	git clone $(REPO_BASE_LINK)/Arctan-Kernel ./kernel/
else
	cp -r $(LOCAL_KERNEL_DIR) ./kernel/
endif
	rm -rf ./kernel/.git/

.PHONY: grub
grub:
	rm -rf bootstrap/
	rm -f builds/bootstrap.built builds/bootstrap.packaged
ifeq ($(LOCAL_BSP_DIR),)
	git clone $(REPO_BASE_LINK)/Arctan-MB2BSP ./bootstrap/
else
	cp -r $(LOCAL_BSP_DIR) ./bootstrap/
endif
	rm -rf ./bootstrap/.git/

jinx:
	curl -O https://raw.githubusercontent.com/mintsuki/jinx/trunk/jinx
	chmod +x jinx

.PHONY: distro
distro:
	./jinx build-all

.PHONY: clean
clean:
	rm -rf iso
	./jinx clean

.PHONY: run
run: all
	qemu-system-x86_64 -enable-kvm -cpu qemu64 -d cpu_reset $(QEMUFLAGS)