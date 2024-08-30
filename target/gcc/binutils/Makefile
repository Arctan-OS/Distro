VERSION := 2.43
NAME := binutils-$(VERSION)
TAR := $(NAME).tar.gz
MIRROR := https://ftp.gnu.org/gnu/binutils/$(TAR)

COMPLETE := build.complete

$(COMPLETE): $(TAR)

$(TAR):
	curl -o $(TAR) $(MIRROR)
	tar -xf $(TAR) --strip-components=1 -C ../$(GCC_NAME)
