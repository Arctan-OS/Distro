REPO := https://github.com/osdev0/libgcc-binaries
COMMIT := 4da90dd39fd861e73c5da83358015cfcf8b03fea
NAME := libgcc-binaries-$(COMMIT)
TAR := $(NAME).tar.gz
MIRROR := $(REPO)/archive/$(COMMIT).tar.gz

$(TAR):
	rm -rf libgcc-bin
	curl -o $(TAR) -L $(MIRROR)
	tar -xf $(TAR)
	mv $(NAME) libgcc-bin
