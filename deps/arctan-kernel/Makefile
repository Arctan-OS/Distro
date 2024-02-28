.PHONY: all
all: clean
ifeq ($(LOCAL_KERNEL_DIR),)
	git clone https://github.com/awewsomegamer/Arctan-Kernel
	make -C Arctan-Kernel
	cp Arctan-Kernel/bootstrap/bootstrap.elf $(ARC_ROOT)
	cp Arctan-Kernel/kernel/kernel.elf $(ARC_ROOT)
else
	make -C $(LOCAL_KERNEL_DIR)
	cp $(LOCAL_KERNEL_DIR)/bootstrap/bootstrap.elf $(ARC_ROOT)
	cp $(LOCAL_KERNEL_DIR)/kernel/kernel.elf $(ARC_ROOT)
endif

.PHONY: clean
clean:
	rm -rf Arctan-Kernel
