default: display modified/Novela-Regular.otf

display: modified/NovelaDisplay-Regular.otf modified/NovelaDisplay-Italic.otf

modified:
	mkdir -p modified

modified/NovelaDisplay-Regular.otf: modified
	ttx Novela-DisplayRegular.otf -o NovelaDisplay-Regular.ttx # note the name change
	patch -p0 < display_regular.patch
	ttx NovelaDisplay-Regular.ttx -d modified

modified/NovelaDisplay-Italic.otf: modified
	ttx Novela-DisplayItalic.otf -o NovelaDisplay-Italic.ttx # note the name change
	patch -p0 < display_italic.patch
	ttx NovelaDisplay-Italic.ttx -d modified

modified/Novela-Regular.otf: modified
	ttx Novela-Regular.otf
	patch -p0 < regular.patch
	ttx Novela-Regular.ttx -d modified

clean:
	rm -rf *.ttx modified

