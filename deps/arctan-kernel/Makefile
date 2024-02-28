.PHONY: all
all: clean
ifeq ($(ARC_LOCAL_BUILD), 0)
	git clone https://github.com/awewsomegamer/Arctan-Kernel
	make -C Arctan-Kernel
	cp Arctan-Kernel/bootstrap/bootstrap.elf $(ARC_ROOT)
	cp Arctan-Kernel/kernel/kernel.elf $(ARC_ROOT)
else
	make -C $(ARC_ROOT)/../Arctan-Kernel
	cp $(ARC_ROOT)/../Arctan-Kernel/bootstrap/bootstrap.elf $(ARC_ROOT)
	cp $(ARC_ROOT)/../Arctan-Kernel/kernel/kernel.elf $(ARC_ROOT)
endif

.PHONY: clean
clean:
	rm -rf Arctan-Kernel
