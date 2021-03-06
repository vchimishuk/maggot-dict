.PHONY: all install uninstall clean

PYTHON := python
BOOTSTRAP := MaggotDict.pretzel.bootstrap

all: maggot-dict-cli

# compile as zip file
maggot-dict-cli-zip: maggot-dict-cli.py MaggotDict
	@zip -qr9 maggot-dict-cli.zip MaggotDict __main__.py
	@echo '#!/usr/bin/env python' > maggot-dict-cli
	@cat maggot-dict-cli.zip >> maggot-dict-cli
	@rm maggot-dict-cli.zip
	@chmod 775 maggot-dict-cli

# compile with bootstrap
maggot-dict-cli: maggot-dict-cli.py MaggotDict
	@$(PYTHON) -m$(BOOTSTRAP) -m$< MaggotDict > $@
	@chmod 775 $@

install: all
	@install -m775 -D maggot-dict-cli \
		$(DESTDIR)/usr/bin/maggot-dict-cli
	@install -m775 -D maggot-dict-cli.completion \
		$(DESTDIR)/usr/share/bash-completion/completions/maggot-dict-cli

uninstall:
	@test -f $(DESTDIR)/usr/bin/maggot-dict-cli && \
		  rm $(DESTDIR)/usr/bin/maggot-dict-cli || true
	@test -f $(DESTDIR)/usr/share/bash-completion/completions/maggot-dict-cli && \
		  rm $(DESTDIR)/usr/share/bash-completion/completions/maggot-dict-cli || true

clean:
	@test -f maggot-dict-cli && rm maggot-dict-cli || true

# vim: nu ft=make columns=120 :
