VERSION := 5.2
TAR := bash-$(VERSION).tar.gz
MIRROR := https://ftp.gnu.org/gnu/bash/$(TAR)
COMPLETE := bash-$(VERSION)/$(TAR).complete

$(COMPLETE): $(TAR)
	tar -xf $(TAR)

	cd bash-5.2 && ./configure $(AC_FLAGS)
	make -C bash-5.2 install DESTDIR=$(DESTDIR)

	touch $(COMPLETE)

$(TAR):
	curl -o $(TAR) $(MIRROR)
