ARCTAN_PORTS_HOME := $(ARCTAN_INITRAMFS)/ports/

export ARCTAN_PORTS_HOME

.PHONY: all
all:
	make -C mlibc
	make -C arctan-kernel

.PHONY: clean
clean:
	make -C mlibc clean
	make -C arctan-kernel clean
