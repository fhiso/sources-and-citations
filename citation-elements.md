Citation Elements
=================

*This document contains a list of elements that we expect to need,
together with notes of items where consensus has been achieved, and
outstanding issues to be discussed.*

## `author-name`

### Multiple authors

Should we have multiple instances of the element, one per
author, or just one field containing a list of authors?  Related to
that, how do we ensure that the authors remain in the correct order?
(Per FHISO's [technical strategy paper](http://tech.fhiso.org/strategy), 
"meaning should only be associated with the order of values if it is
tolerable for the information encoded by the order to be lost".)
Three options are:

1.  Have one field per author, and accept that we can only *recommend*
and not *require* that the order of authors is preserved.
2.  Have one field per author, but recommend or require an ordinal
prefix (e.g. `[1] Thomas Woodcock`).
3.  Have one field listing all authors with some convenient separator,
such as an ampersand.

If (3) is chosen, the element would need renaming, perhaps to
`authors-name`, or perhaps to `author-name-list` adopting a convention
that all list elements are so named.  There is a further suggestion that
the list elements should have a common syntax.

### Format

What format should the name be in?  Style guides impose different
formats when the name is used in different contexts.  In particular, our
format needs to include or allow the generation of:

1.  *Sort data.*  Some cultures require particles like "de" or "al" be
ignored when sorting.  In Japanese, sorting requires a kana (hiragana or
katakana), as opposed to the normal kanji rendering of a name.  It is
not displayed.
2.  *Bibliographic format.*  This is the format used when displaying a list
of citations ordered by author.  For Western names typically brings
the surname to the front, e.g. `Woodcock, Thomas`; in many Asian
cultures, the natural ordering is right.
3.  *Natural format.*  This is the format in which the name would normally
be written.  Reference footnotes normally use this.
4.  *Abbreviated format.*  This is the format in which second and
subsequent references to a name would normally be written.  For Western
names it would normally be just the surname.  

Commonly the sort data and the bibliographic format are identical and
the abbreviated format is a leading substring of the bibliographic
format, but neither is invariably true.

Is there a requirement to support conversion to initials?  Humanities
citation styles seldom require require only an author's initials, but
scientific papers commonly do.


There is no consensus on whether the author name should be encoded in
natural order (e.g. `John Stuart Mills`), whether the surname or other
principal part should be identified (e.g. `John Stuart /Mills/`), or
whether the name should be permuted into bibliographic order (e.g.
`Mills, John Stuart`).

There is no consensus on whether there should be a general
"creator-name" element, or several more specific elements such as "

editor-name
-----------

creator-role
------------

* author, editor, compiler
* translator?

title
-----

* For a book, this is it's formal title, including any subtitle.

short-title
-----------

* We cannot algorithmically generate a short version of a title from the
  full title.
* In the common case where the title is fairly short, this can default
  to the value of the title element.

publisher-name
--------------

* For books, this is the name of the publishing house.

publication-year
----------------

* Or should it be a publication date?

publication-place-name
----------------------

* Not a full address.  
* May be a need for state or country, in which case is it bottom-up or
  top-down?

locator
-------

* Page number.
* May be generalised to a location-within-source element.
