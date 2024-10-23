This repository contains instructions for modifying [Novela] to be used with [Typst].

# Issues

Novela as it comes from [atipo] has a few issues when being used with Typst.

## Styles

Typst cannot distinguish font styles "Regular" and "Display Regular".  If you run `typst fonts --variants`, you'll find duplicate entries for Novela with *Typst* Style (italics) **Normal** Weight **400** and Stretch **1000**.  This is because Novela sees the *OTF* styles **Regular** and **Display Regular** as having the same properties.

> Novela
> - Style: Italic, Weight: 900, Stretch: FontStretch(1000)
> - Style: Normal, Weight: 600, Stretch: FontStretch(1000)
> - Style: Normal, Weight: 900, Stretch: FontStretch(1000)
> - Style: Italic, Weight: 600, Stretch: FontStretch(1000)
> - Style: Italic, Weight: 400, Stretch: FontStretch(1000)
> - Style: Normal, Weight: 700, Stretch: FontStretch(1000)
> - Style: Italic, Weight: 700, Stretch: FontStretch(1000)
> - Style: Italic, Weight: 400, Stretch: FontStretch(1000)
> - Style: Normal, Weight: 400, Stretch: FontStretch(1000)
> - Style: Normal, Weight: 400, Stretch: FontStretch(1000)
> - Style: Italic, Weight: 400, Stretch: FontStretch(1000)

This can lead to Typst using **Display Regular** instead of **Regular** when it's uncalled for.  Typst may address [issue #2098](https://github.com/typst/typst/issues/2098) at some point to make this correction unnecessary.

## Ornaments

Novela comes with three ornaments (fleuron001.ornm, fleuron002.ornm, and fleuron003.ornm), but they are unassociated with any Unicode value.  This makes them impossible to use as long as [issue #4393](https://github.com/typst/typst/issues/4393) is unresolved.

This can be confirmed with `otfinfo -u` and `otfinfo -g` from `lcdf-typetools`.


# Modifying the Font

We can modify the fonts as follows.  We can move *Display Regular* and *Display Italic* into their own font family called *Novela Display*. Note that with this change, any other files which use a *Display* style of Novela may need to be change to use the *Regular* or *Italic* style of *Novela Display*.

Second, we can associate the fleurons with Unicode values.  I chose 0x273E, 0x273F, and 0x2740.  There was nothing there, so this has no side effect.

## Procedure

To modify the font you must have:

* make (Tested with GNU)
* [FontTools]

FontTools comes with a program called `ttx` that can convert `.otf` files to `.ttx` which is XML.  This XML can be modified to make corrections needed to address the above issues.  Then the `.ttx` files can be converted back into `.otf` files.  The Makefile automates this process.

    git clone git@github.com:cskeeters/novela-typst.git
    cd novela-typst
    cp ~/Downloads/Novela-Complete-Desktop/* .
    make

After this is complete, three modified files will be located in a sub-folder named `modified`.

If you have already installed the font, you need to remove the following styles:

* Regular
* Display Regular
* Display Italic

Then install the modified versions.


# Testing

You should be able to confirm that the changes worked in Typst by examining the output of the following Typst code.

```typst
= Display Regular
#text(font:"Novela")[ABC] (Should have lower contrast strokes than the line below)

#text(font:"Novela Display")[ABC]

= Display Italic

#text(font:"Novela", style:"italic")[ABC] (Should have lower contrast strokes than the line below)

#text(font:"Novela Display", style:"italic")[ABC]

= Ornaments

#text(font:"Novela")[✾✿❀]

= Ornaments in Display Fonts

#text(font:"Novela Display")[✾✿❀]

#text(font:"Novela Display", style: "italic")[✾✿❀]
```

[atipo]: https://www.atipofoundry.com/
[FontTools]: https://github.com/fonttools/fonttools
[Novela]: https://www.atipofoundry.com/fonts/novela
[Typst]: https://github.com/typst/typst
