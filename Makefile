PRODUCT := Arctan.iso

REPO_BASE_LINK ?= https://github.com/Arctan-OS
LOCAL_KERNEL_DIR ?=
LOCAL_BSP_DIR ?=
QEMUFLAGS := -M q35,smm=off -m 4G -cdrom $(PRODUCT) -debugcon stdio -s

.PHONY: all
all:
	rm -f $(PRODUCT)
	$(MAKE) $(PRODUCT)

$(PRODUCT): jinx kernel
	rm -f builds/bootstrap.built builds/bootstrap.packaged	
	rm -f builds/kernel.built builds/kernel.packaged builds/kernel.regenerated

	$(MAKE) distro

.PHONY: kernel
kernel:
	rm -rf kernel/ builds/kernel/
ifeq ($(LOCAL_KERNEL_DIR),)
	git clone $(REPO_BASE_LINK)/Kernel ./kernel/
else
	cp -r $(LOCAL_KERNEL_DIR) ./kernel/
endif

.PHONY: mb2
mb2:
	rm -rf bootstrap/ builds/bootstrap/
ifeq ($(LOCAL_BSP_DIR),)
	git clone $(REPO_BASE_LINK)/MB2BSP ./bootstrap/
else
	cp -r $(LOCAL_BSP_DIR) ./bootstrap/
endif

.PHONY: lbp
lbp:
	rm -rf bootstrap/ builds/bootstrap/
ifeq ($(LOCAL_BSP_DIR),)
	git clone $(REPO_BASE_LINK)/LBPBSP ./bootstrap/
else
	cp -r $(LOCAL_BSP_DIR) ./bootstrap/
endif

jinx:
	curl -O https://raw.githubusercontent.com/mintsuki/jinx/trunk/jinx
	chmod +x jinx

.PHONY: distro
distro:
	rm -rf ./kernel/.git/
	rm -rf ./bootstrap/.git/

	./jinx build-all

.PHONY: clean
clean:
	rm -rf iso
	./jinx clean

.PHONY: run
run: $(PRODUCT)
	qemu-system-x86_64 -enable-kvm -cpu qemu64 -d cpu_reset $(QEMUFLAGS)
