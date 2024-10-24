FONTS = Novela-Regular.otf \
        NovelaDisplay-Regular.otf \
        NovelaDisplay-Italic.otf

TTXFILES = $(patsubst %.otf,%.ttx,$(FONTS))
PATCHTARGETS = $(patsubst %.otf,%-patched.ttx,$(FONTS))
MFONTS = $(patsubst %,modified/%,$(FONTS))

.PHONY: default ttx patch clean

# This target creates the modified .otf files in the modified directory
default: ttx patch $(MFONTS)

# This target extracts fonts to be modified into TTX format
ttx: $(TTXFILES)
	@echo $(PATCHTARGETS)

# This target patches the .ttx files
patch: $(PATCHTARGETS)
	echo $(PATCHTARGETS)

clean:
	rm -rf *.ttx modified


# Rules to create .ttx files from .otf files
%.ttx: %.otf
	ttx -o $@ $<

NovelaDisplay-Regular.ttx: Novela-DisplayRegular.otf
	ttx -o $@ $<

NovelaDisplay-Italic.ttx: Novela-DisplayItalic.otf
	ttx -o $@ $<

# Rule to patch .ttx files
%-patched.ttx: %.patch %.ttx
	patch -p0 < $<
	mv $(word 2,$^) $@

# Rule to create .otf files from .ttx files
modified/%.otf: %-patched.ttx
	mkdir -p modified
	ttx -o $@ $<
