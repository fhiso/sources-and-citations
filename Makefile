ROOT=..

all:	citation-elements-vocabulary.pdf creators-name.pdf

%.pdf: %.md
	$(MAKE) -C $(ROOT)/website -f pandoc.mk $(ROOT)/sources-and-citations/$@
