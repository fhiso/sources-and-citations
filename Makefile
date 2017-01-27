# This Makefile is here for convenience.  The website build system does 
# not use it, and instead invokes pandoc.mk directly.

ROOT    := ..

SOURCES := citation-elements-vocabulary.md creators-name.md

all:	pdf
pdf:	$(SOURCES:%.md=%.pdf)
html:	$(SOURCES:%.md=%.html)

clean:
	rm -f $(SOURCES:%.md=%.pdf) $(SOURCES:%.md=%.html)

MAKEWEB := $(MAKE) -C $(ROOT)/website -f pandoc.mk

%.pdf: %.md
	$(MAKEWEB) $(ROOT)/sources-and-citations/$@

%.html: %.md
	$(MAKEWEB) $(ROOT)/sources-and-citations/$@
