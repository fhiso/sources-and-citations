---
title: A microformat for creators' names
date: 15 April 2016
...
# A microformat for creators' names

[*Editorial note &mdash;* This is an **early draft** of material
intended to go in a Citation Elements standard.  Text in square
brackets (such as this paragraph) is not intended to form a normative
part of any eventual standard.  Such text is labelled as an example,
note, or editorial note.  Editoral notes are used to record outstanding
issues, or points where there is no consensus, and will be resolved and
removed for the final standard.  Examples and notes may be retained in
the standard.]

This standard defines a *class* for storing the name of an 
creator [or an ordered list of creators] of a genealogical source in a
*citation element*.  The word "creator" is used rather than "author"
so as also to include editors, compilers, painters and stonemasons.  The
format is designed to accommodate names conforming to a wide range of
cultural norms, not just Western ones; however it does not aim to cover
all variants of names, just those that might reasonably be expected to
appear in a genealogical citation.  [*Example &mdash;* The style guides
used in the humanities rarely require the conversion of authors' given
names to initials, and this format does not provide a reliable means of
doing it, nor even of identifying which the given names are.]

It is explicitly not a goal of this microformat to allow the storage of
additional data on creators, such as their email addresses, phone
numbers, or academic affiliations.


## Basics

[*Editorial note &mdash;* This section will likely form part of a
general introduction to the completed standard.]

The key words *must*, *must not*, *required*, *shall*, *shall not*,
*should*, *should not*, *recommended*,  *may*, and *optional* in this
standard are to be interpreted as described in [[RFC
2119](http://tools.ietf.org/html/rfc2119)].

The grammar given here uses the same EBNF notation as
[[XML](https://www.w3.org/TR/xml11/)], except that grammar symbols always
have initial capital letters.  Conforming applications *must not*
generate data not conforming to the syntax given here, but
non-conforming values *may* be accepted and processed by a conforming
application in an implementation-defined manner.

**Characters** are specified by reference [ISO/IEC 10646], without
regard to the character encoding.  In this standard *characters* may be
identified in the text by their four- or five-digit hexadecimal
character number prefixed with "U+".  [*Note &mdash;* This does not
preclude serialisation in a non-Unicode encoding, so long as the
serialisation defines how characters in that encoding corresponds to
Unicode characters.]

*Characters* *must* match the `Char` production from 
[[XML](https://www.w3.org/TR/xml11/)].   [*Note &mdash;* This includes
all code points except the null character, surrogates (which are
reserved for encodings such as UTF-16 and not characters in their own
right), and the invalid characters U+FFFE and U+FFFF.]  

    Char  ::=  [#1-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]

The value of a *citation element* is a **string**, defined as a sequence
*characters*.  &#x5B;*Note &mdash;* This definition is indentical to the
definition of the `xs:string` datatype defined in 
[[XSD Pt2](https://www.w3.org/TR/xmlschema11-2/)], 
used in many XML and Semantic Web technologies.]

*Characters* matching the `RestrictedChar` production from
[[XML](https://www.w3.org/TR/xml11/)] *should not* appear in
*strings*, and applications *may* process such characters in an
implementation-defined manner or reject *strings* containing them.

    RestrictedChar  ::=  [#x1-#x8] | [#xB-#xC] | [#xE-#x1F] 
                           | [#x7F-#x84] | [#x86-#x9F]

[*Note &mdash;* This includes all C0 and C1 control characters except
tab (U+0009), line feed (U+000A), carriage return (U+000D) and next line
(U+0085).]  [*Example &mdash;* As applications can process C1 control
characters in an implementation-defined manner, they can opt to handle
Windows-1252 quotation in data masquerading as Unicode.]

**Whitespace** is defined as a sequence of one or more space
*characters*, carriage returns, line feeds, or tabs.  It matches the
production `S` from [[XML](https://www.w3.org/TR/xml11/)].

    S  ::=  (#x20 | #x9 | #xD | #xA)+

**Whitespace normalisation** is the process of discarding any leading
or trailing *whitespace*, and replacing other *whitespace* with a single
space (U+0020) *character*.  &#x5B;*Note &mdash;* This definition is
identical to that in [[XML](https://www.w3.org/TR/xml11/)].]  Many
*citation element* values are *whitespace-normalised* before being
processed, and in such elements, the production `S` collapses to a
single space (U+0020).

In the event of a difference between the definitions of the `Char`,
`RestrictedChar` and `S` productions given here and those in 
[[XML](https://www.w3.org/TR/xml11/)], the definitions in the latest
edition of XML 1.1 specification are applicable.

## List types

[*Editorial note &mdash;* FHISO has deferred a decision on whether a
list of creators' names should be encoded in a single element value.
This section defines a reusable format which can be used for any
list-valued elements, should it be decided that list-valued elements
should be encoded in a *string*.]

This section defines a general pattern that can be used for serialising
an ordered list of one or more items into a *citation element* value by
separating them with a `ListSeparator` of a repeated ampersand (U+0026).

    ListSeparator  ::=  S '&&' S

[*Editorial note &mdash;* There is not yet consensus on the choice of
`ListSeparator`, both in terms of the punctuator and whether surrounding
whitespace should be required.]

By convention in this standard, the grammar production for such a list
is the name of the individual item's production suffixed by `List`.  <a
id="CreatorsNameList"></a>The `CreatorsNameList` production follows this
convention:

    CreatorsNameList  ::=  CreatorsName ( ListSeparator CreatorsName )*

Applications *should* *whitespace-normalise* any `CreatorsNameList` value
before processing or serialising it.  [*Note &mdash;* this is only
*recommended* and not *required* to allow for the possibility that an
application might process an third-party *citation element* without
knowing that its value is a `CreatorsNameList`.] The *class name* for
the *class* of values encoding a list of the names of the creators of a
genealogical source that matches this production is:

    http://terms.fhiso.org/type/CreatorsNameList

[*Example &mdash;* A charter jointly written, at least nominally, by
William III and Mary II could be described using a `CreatorsNameList`
of "`William III && Mary II`".]

## Name variants

A `CreatorsName` contains four separate variants of a name.

1.  The *sort data* used to order a list of names, and which is never
    displayed.
2.  The *bibliographic version* of the name to display in a
    bibliography sorted by author.
3.  The *short version* that may be used in subsequent references to
    that author's work.
4.  The *natural version*, giving the full name as it is normally
    written in a first reference.

The **natural version** of the creator's name is generally the name in
whatever form it is given in the work.  It is normal for any titles or
post-nominals to be dropped unless they are necessary to distinguish two
people of the same name, but the `CreatorsName` format does not enforce
that.  [*Example &mdash;* The *natural version* of the name is British
medievalist David Dumville is "`David Dumville`".  The quotation marks
do not form part of the syntax.]

The **bibliographic version** of a name is normally produced by
reordering the *natural version* of the name to bring the most
significant parts to the front, and inserting commas, typically to mark
where the *natural version*'s order was disturbed.  The intended format
is the one commonly used in bibliographies and indexes which aims to
appear logical when sorted; nevertheless, this standard does not
require a specific choice of *bibliographic version* format.  [*Example
&mdash;* The *bibliographic version* of the name of Greek historian
Maria Nystazopoulou-Pelekidou would is "`Νυσταζοπούλου-Πελεκίδου,
Μαρία`", if written in Greek.] 

The **sort data** will usually be the same as the *bibliographic
version*, but in some cultures the correct sorting of names requires
information that is not normally displayed.  For Japanese names, the
*sort data* will commonly be an entirely separate version of the name
written in a kana, as names are sorted base on pronunciation, not their
kanji spelling.  [*Example &mdash;* The Japanese given names Akiko,
Junko and Kiyoko are all spelt using the same sequence of kanji
characters, 淳子, however they are sorted based on their pronunciation
which can be expressed using hiragana or katakana characters.  In the
case of the name Akiko, this is represented あきこ or アキコ,
respectively, and one of these should be used as the *sort data*.  In
reality most modern Japanese people have a family name as well as a
given name.]  

The **short version** of the name is typically just the main component
of the name, as used in a formal or academic context to refer to a
person who has already been referred to.  For Western names this is
normally the surname, but in cultures where the norm is for people to
have given name and a patronymic, this would be the given name.  The
*short version* *should not* be used to encode arbitrary shortened forms
of names, such as versions with initials in place of given names, or
diminutive forms of names.  [*Example &mdash;* The *short version* of
the name of Icelandic historian Örnólfur Þorsson would be "`Örnólfur`";
Þorsson is a patronymic derived from his father's name, Þor.]

[*Note &mdash;* Not all style guides make use of all four variants.
Some bibliographies do not sort entries by author, in which case the
*sort data* is not used; not all style guides say that second and
subsequent references to an author should use the *short version*; and
sometimes the *bibliographic version* is used for all references.]

## The name format

The general format for a `CreatorsName` allows the inclusion of between
one and four name variants, represented by `Name` in the grammar
production below.  The four `Name`s are, in order, the *sort data*, the
*bibliographic version*, the *short version* and the *natural version*;
all except the *bibliographic version* are optional.  

    CreatorsName  ::=  ( Name S '@' S )? Name 
                         ( S '|' ( S Name )? ( S '|' S Name )? )?

### Default sort data

If *sort data* is present, it precedes the *bibliographic version*, and
is separated from it by an `@` *character* (U+0040).  If the *sort data*
is not explicitly given in the `CreatorsName`, it defaults to the
*bibliographic version*.  [*Example &mdash;* "`Homer`" and "`Homer @
Homer`" are treated identically; the omited *sort data* in the former
has been written explicitly in the latter.  Japanese names will normally
need the *sort data* giving explicitly.  Emperor Meiji might be
represented "`めいじてんのう @ 明治天皇`", where the first part gives
the pronunciation of Meiji-tennō in hiragana.] 

Because the *sort data* is the leading substring of the `CreatorsName`,
and if omitted defaults to the *bibliographic version* which would then
be the leading substring (and cannot be omitted), a collation algorithm
applied to the whole `CreatorsName` would normally do the same as if
applied to just the *sort data*.  [*Note &mdash;* This is not guaranteed
to be true of every collation order.  French is traditionalled sorted
initially by ignoring accents, and only considering accents if the
text is otherwise equal.  This could result in ther ordering being
determined by data outside the *sort data* instead of the diacritics
within the *sort data*.  An application sorting French in this manner
might not be able to apply the collation algorithm directly to the full
`CreatorsName`.]

### Default short version

If the *short version* is present, if comes immediately after the
*bibliographic version*, and is separated from it by a `|` *character*
(U+007C).  [*Example &mdash;* Chinese genealogist Kong Deyong (孔德庸)
has the family name Kong (孔) which would be normal *short version* of
his name.  Serialised as a `CreatorsName`, he might be written "`Kong
Deyong | Kong`" if transliterated into the Latin script, or "`孔德庸 |
孔`" in Chinese characters.]

If the *short version* is not explicitly given in the `CreatorsName`, it
defaults to a substring of the *bibliographic version*.  If the
*bibliographic version* contains no comma (U+002C), then the *short
version* defaults to the whole *bibliographic version*.  If a comma
is present, the *short version* defaults to the *whitespace normalised*
substring up to but excluding the first comma.  [*Example &mdash;*
French genealogist Christian Settipani might be written in a
`CreatorsName` as "`Settipani, Christian`".  This lacks an explicit
*short version*, which defaults to "`Settipani`", the substring up to
the first comma.  This could have been written explicitly as
"`Settipani, Christian | Settipani`".]

### Default natural version

If the *natural version* is present, it comes immediately after the
*short version*, separated by a `|` *character* (U+007C); if the *short
version* was omitted, then it follows the *bibliographic version*
separated by two `|` *characters* with a space between them.  [*Example
&mdash;* The `CreatorsName` "`Renell, James, Major | | Major James
Renell`" contains both a *bibliographic version* and a *natural
version*; the *short version* (which would have been between the two `|`
*characters*) has been omitted and correctly defaults to "`Renell`", the
substring of the *bibliographic version* up to the first comma .]

If the *natural version* is not explicitly given in the `CreatorsName`,
it defaults to a value determined from the *bibliographic version* as
follows.  

If the *bibliographic version* contains no comma (U+002C), then the
*natural version* defaults to the *bibliographic version*.  [*Example
&mdash;* In many East Asian cultures, names are naturally written in a
bibliographic form.  Burmese historian Kyaw Thet could simply be
encoded as "`Kyaw Thet`" in a `CreatorsName`; the omitted *natural
version* defaults to the *bibliographic version* as it contains no
comma.]

If the *bibliographic version* contains precisely one comma, the
*natural version* defaults to the *whitespace-normalised* *string*
created by concatenting the substring of the *bibliographic version*
after the comma, a space (U+0020), and the substring before the comma.
[*Example &mdash;* Spanish genealogist Rodrigo Méndez Silva, whose
family names are Méndez Silva, could be represented in a `CreatorsName`
as "`Méndez Silva, Rodrigo`".  Not only Western names invert the
*natural version* to form the *bibliographic version*.  Andalusian 
historian Said al-Andalusi (<span dir="rtl">صاعد الأندلسي</span>) 
may be stored "`al-Andalusī, Ṣā‘id`" in the Latin script; or 
untransliterated, showing the characters in memory order, 
&#x202D;"`ا`&zwnj;`ل`&zwnj;<!-- 
-->`أ`&zwnj;`ن`&zwnj;`د`&zwnj;`ل`&zwnj;`س`&zwnj;`ي`<!-- 
-->`,`&nbsp;`ص`&zwnj;`ا`&zwnj;`ع`&zwnj;`د`"&#x202C;.]

If the *bibliographic version* contains more than one comma, the
*natural version* defaults to the  *whitespace-normalised* *string*
created by concatenting the substring of the *bibliographic version*
between the first and second commas, a space (U+0020), the substring
before the first comma, and the substring from (and including) the
second comma to the end of the *string*.  [*Example &mdash;* The
`CreatorsName` string "`Moriarty, G. Andrews, Jr.`" contains no explicit 
*natural version*.  The default is formed by concatenating the text 
between the commas ("`G. Andrews`"), a space ("&nbsp;"), the text 
before the first comma ("`Moriarty`"), and the text from the second 
comma to the end ("`, Jr.`").  This results in the correct *natural
version*: "`G. Andrews Moriarty, Jr.`".]

## Escaping characters

[*Editorial note &mdash;* There is not yet clear consensus for this
particular escape syntax.]

A `Name` (used to represent any of the four name variants) is a sequence of 
*characters* or *escape characters* which does not begin or end with
*whitespace*.

    Name              ::=  NameChar ( ( NameChar | S )* NameChar )?
    
    NameChar          ::=  ( Char - ( S | ReservedNameChar ) ) | EscapedChar 

The *characters* `&`, `@` and `|` have specific purposes in a
`CreatorsNameList`.  If a name naturally contains one of these
*characters*, or any other character matching the `ReservedNameChar`
production, it *must* be escaped.  [*Note &mdash;* The *characters* `!`,
`#` and `$` are assigned no purpose in this standard, but are reserved
for future use.  The *characters* `{` and `}` are used in this standard,
but not in a context that would require them to be escaped elsewhere;
nevertheless, this standard requires them to be escaped to allow
additional future use of them.]

    ReservedNameChar  ::=  '!' | '#' | '$' | '%' | '&' | '@' | '{' | '|' | '}'

The `%` *character* (U+0025) introduces an **escaped character**, after
which the hexadecimal number of the character in [ISO/IEC 10646] is
given in braces (U+007B and U+007D).  The *character* number given
*should* be for a *character* that matches the `Char` production, and
applications *may* reject the string if it does not.  *Escaped
characters* *may* be used to represent any character, not just those
matching `ReservedNameChar`, but this is *not recommended*; applications
*may* replace any unnecessary escapes with the unescaped *character*.
    
    EscapedChar  ::=  '%' '{' [0-9A-Fa-f]+ '}'

[*Example &mdash;*  The *characters* `!` and `|` are used to write click
consonants in a number of Southern African languages.  Properly these are
written using *characters* U+01C3 and U+01C0, respectively, but these
are missing in many fonts and hard to enter on many keyboards; the
similar-looking ASCII character U+0021 and U+007C are often substituted.
Thus the name of Namibian chief ǃNanseb gaib ǀGâbemab might be written
"`%{21}Nanseb gaib %{7C}Gâbemab`".]

    
If a name naturally contains a comma, the defaulting rules listed above
may yield incorrect results.  In these cases the explicit forms of those
name parts *should* be given.  [*Editorial note &mdash;* This standard
does not current state whether defaulting acts on the escaped or
unescaped *bibliographic version*.  It is therefore as-yet undefined
whether an *escaped character*, `%{2C}`, can hide a comma from the
defaulting rules.]

## Stylistic recommendations

This section gives recommendations on how to use the `CreatorsName` for
maximum interoperability.  [*Editorial note &mdash;* These
recommendations are based on best practice in citations, but are only
guidelines, so may not belong in the main part of the standard.]

It is *recommended* that diacritics are preserved in all name variants,
including the *sort data*.  &#x5B;*Example &mdash;* The *short verison* of
former Polish president Lech Wałęsa's name should be "`Wałęsa`" and not
"`Walesa`".  If desired, an application can strip the diacritics when
formatting a citation, but it is not generally possible for an
application to restore lost diacritics.  Algorithms such as the Unicode
Collation Algorithm [[UTS 10](http://unicode.org/reports/tr10/)] can
handle the sorting of Unicode data according to the requirements of
various locales.]

It is *recommended* that titles and post-nominals be dropped from the
authors of published sources unless they are necessary to distinguish
two people of the same name.  [*Example &mdash;*  The *natural version*
of the name of Sir George John Armytage, Bart., FSA, would normally be
written "`George John Armytage`".  However were one of Princess Michael
of Kent's historical books being cited, the *bibliographical version* of
her name might be given as "`Michael, of Kent, Princess`": simply
putting "`Michael`" (or "`Marie`") would be ambiguous, and as a member
of the British Royal Family she does not normally use a surname.]

If initials or other abbreviations are given, it is *recommended* that 
they *should* be be formatted with a period (U+002E) and a space
(U+0020) after each initial or abbreviation, unless followed by another
punctuation mark or the end of the string, in which case the space
*should* be omitted.  The non-breaking space *character* (U+00A0) *should
not* be used to separate initials.  [*Example &mdash;* The *natural
version* of the name of historian A J P Taylor would be written "`A. J.
P. Taylor`", and the *bibliographic version* of the name of US Supreme
Court justice Lewis F Powell Jr is "`Powell, Lewis F., Jr.`".  Note the
period after "Jr", even though some style guides say it is not needed as
the last letter of "junior" has not been omitted.  How these are
presented in a formatted citation is beyond the scope of this standard,
so an application formatting a citation to Taylor's work would be free
not to print the periods or spaces.]

When a name contains a single element that is written as two words, but
logically a single, indivisible entity, a non-breaking space *character*
(U+00A0) *may* be used to separate them.  [*Example &mdash;* In
English, St&nbsp;John, and less commonly other saints, can be used as a
given names or surnames.  Garter King of Arms, Sir Henry St&nbsp;George the
younger is an example.  He might be represented in a
`CreatorsName` as "`St.%{A0}George, Henry, the younger`"; the suffix
"the younger" is retained to disambiguate him with his father who had
the same name and had also been Garter King of Arms.  When formatting a
citation, applications are not required to honour the non-breaking
space.]

If additional detail has been added to the author's name that is was not
present in a published source, it is *recommended* that square brackets
(U+005B and U+005D) are used to enclose the additional content.
[*Example &mdash;* English reference work *The Complete Peerage*
identifies its author only by his initials, G&nbsp;E&nbsp;C; however his
identity is well known and his `CreatorsName` could be written
"`C[okayne], G. E.`".]

If it considered desirable to include the original form of a
transliterated name, it is *recommended* that they are placed after the
name in parentheses (U+0028 and U+0029). [*Example &mdash;* Japanese
names lose information when transliterated as many names can be written
in kanji in different ways.  "`Akiko, of Mikasa, Princess (彬子女王)`"
shows that Akiko is spelt 彬子 rather than, say, 淳子.]  [*Note &mdash;*
No special treatment is given to parentheses when determining the
default *natural version* from the *bibliographic version*, so it is
generally necessary to give the *natural version* explicitly.]

### Surname particles

In this section, a **surname particle** refers to a short word that may
appear before the main part of surname, and that may or may not be
regarded as part of the surname.  [*Example &mdash;* The word "de" used
in French, Dutch, Spanish and Italian is an example, as is the German
"von", and the Arabic prefix "al-" (<span dir="rtl">ال</span>).] <!--
--> [*Note &mdash;* This is not intended as a rigorous definition.]

It is *recommended* that *surname particles* are written in lower case
in the *bibliographic version* if that is the author's preference or the
convention in that culture, even if they appear at the start of a
string.  [*Example &mdash;* The *bibliographic version* of the former
French president's name would be written "`de Gaulle, Charles`", but the
French author would be "`La Fontaine, Jean de`".  This because it is
conventional in French to capitalise "La" but not "de".] 

The process for determining whether a *surname particle* should be put
in front of the surname or after the given name in the *bibliographic
version* is complicated and culture-specific, and outside the scope of
this standard.  It is the responsibility of the party entering the data
to determine the correct form.  [*Note &mdash;* Two people with the same
name might properly have different *bibliographic versions* if they live
in different countries, so the correct *bibliographic version* cannot be
determined algorithmically from the *natural version* of the name.]

*Sort data* *should not* be used to suppress *surname particles* for the
purpose of sorting.  [*Note &mdash;* As this standard does not specify
what collation algorithm applications should use, they are free to
identify and ignore leading *surname particles* in the *bibliographic
version* if local conventions or house style so dictates.  There is no
consensus on exactly what words are *surname particles*, and this
standard provides no definitive means of identifying them; an
application wishing to ignore *surname particles* would need to use a
heuristic to identify them.]

## References

### Normative references

[ISO/IEC 10646]
:   International Organization for Standardization. *ISO/IEC
    10646-1:2014. Information technology &mdash; Universal Coded
    Character Set (UCS).*

[RFC 2119]
:   Internet Engineering Task Force. *RFC 2119: Key words for use in
    RFCs to Indicate Requirement Levels.* See 
    <http://tools.ietf.org/html/rfc2119>

[XML 1.1]
:   World Wide Web Consortium. *Extensible Markup Language (XML) 1.1.*
    W3C Recommendation. See <https://www.w3.org/TR/xml11/>

### Other references

[UTS 10]
:   The Unicode Consortium. *UTS 10: Unicode Collation Algorithm.*
    Unicode Technical Standard.  See <http://unicode.org/reports/tr10/>

[XSD Pt2]
:   World Wide Web Consortium. *W3C XML Schema Definition Language (XSD)
    1.1 Part 2: Datatypes*.  W3C Recommendation.  See
    <https://www.w3.org/TR/xmlschema11-2/>
