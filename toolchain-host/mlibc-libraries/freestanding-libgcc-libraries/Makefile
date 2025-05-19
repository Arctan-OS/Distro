ARC_REPO := https://github.com/osdev0/libgcc-binaries
ARC_VERSION := 4da90dd39fd861e73c5da83358015cfcf8b03fea
ARC_NAME := libgcc-binaries-$(ARC_VERSION)
ARC_TAR := $(ARC_NAME).tar.gz
ARC_MIRROR := $(ARC_REPO)/archive/$(ARC_VERSION).tar.gz

$(ARC_TAR):
	rm -rf libgcc-bin
	curl -o $(ARC_TAR) -L $(ARC_MIRROR)
	tar -xf $(ARC_TAR)
	mv $(ARC_NAME) libgcc-bin
