# This Makefile is here for convenience.  The website build system does 
# not use it, and instead invokes pandoc.mk directly.

SOURCES := citation-elements-vocabulary.md creators-name.md
include ../website/run-pandoc.mk
