---
title: A citation elements vocabulary
date: 24 May 2017
numbersections: true
...
# A citation elements vocabulary

{.ednote} This is an **exploratory draft** of material intended to form
part of a FHISO Citation Elements standard.  This document is not
endorsed by the FHISO membership, and may be updated, replaced or
obsoleted by other documents at any time. 

## `creatorName` and sub-elements

------           -----------------------------------------------
Name             `http://terms.fhiso.org/sources/creatorName`     
Range            `http://terms.fhiso.org/sources/AgentName`
Cardinality      multi-valued
Translatability  translatable
Super-element    *none*
------           -----------------------------------------------

In the definition of this element and its *sub-elements*, the word
**agent** is used to mean a person, organisation, or other entity
capable of independent or autonomous action.

{.note} An "other entity capable of independent or autonomous action" 
might include sufficiently sophisticated software, such as computer
translation software.

{.note} This definition of an *agent* is aligned to the `Agent` class in
[[FOAF](http://xmlns.com/foaf/spec/)].

The `creatorName` element contains name of an agent who created or
contributed to the creation of the *source*.  Many *sub-elements* are
provided for many specific types of creator, and where appropriate these
are preferred to the `creatorName` *super-element*.

{.note} Many of the following *sub-elements* have similar or even
overlapping meanings, and there may be several plausible choices to
describe a particular creator.  Where possible, the description the
creators used to describe themselves should be followed.

### Sub-elements of `creatorName`

`http://terms.fhiso.org/sources/abstratorName`
:   The `abstractorName` element contains the name of an *agent*
    responsible or jointly responsible for creating abstract of another
    *source* &mdash; a shortened versioned containing all the important
    detail.

`http://terms.fhiso.org/sources/artistName`
:   The `abstractorName` element contains the name of an *agent*
    responsible or jointly responsible for 

`http://terms.fhiso.org/sources/authorName`
:   The `authorName` element contains the name of an *agent* responsible
    or jointly responsible for creating a significant portion of
    original content in a written *source*.  

{.note} The `authorName` element should also be used to describe the creator
of a written *source*

`http://terms.fhiso.org/sources/compilerName`
:   The `compilerName` element contains the name of an *agent*
    responsible or jointly responsible for creating a *source* by
    compiling content from many other *sources*.

`http://terms.fhiso.org/sources/composerName`
:   The `composerName` element contains the name of an *agent*
    responsible or jointly responsible for creating a *source* which is
    a piece of music.

{.note} The `composerName` element has been included largely for
compatibility with
[[CSL](//docs.citationstyles.org/en/stable/specification.html)] and
other vocabularies that have such a role.  It is not anticipated that it
will be used much.

`http://terms.fhiso.org/sources/directorName`
:   The `directorName` element contains the name of an *agent*
    responsible for directing the production of a film or other audio
    or visual *source*.

`http://terms.fhiso.org/sources/editorName`
:   The `editorName` element contains the name of an *agent* responsible
    or jointly responsible for selecting, preparing or editing the
    content of a *source*.

`http://terms.fhiso.org/sources/editorTranslatorName`
:   The `editorTranslatorName` element contains the name of an *agent* 
    reponsible or jointly reponsible for the translation of a *source*
    from another language or languages, and who was also had a major
    role in selecting or preparing the choice of material for
    translation.

{.note} The `editorTranslatorName` element has been included largely for
compatibility with
[[CSL](//docs.citationstyles.org/en/stable/specification.html)].  It
combines the roles of the `editorName` and `translatorName` elements,
and should only be used when the editorial aspect is significant.
Usually the `translatorName` element is more appropriate.

`http://terms.fhiso.org/sources/editorialDirectorName`
:   The `editorialDirectorName` element contains the name of an *agent*
    responsible or jointly responsible for the overall vision and
    editorial policies applied across a large number of a publisher's
    publications.

{.note}  The `editorialDirectorName` element has been included 
solely for compatibility with
[[CSL](//docs.citationstyles.org/en/stable/specification.html)].  Few if any
style guides include it.

`http://terms.fhiso.org/sources/illustratorName`
:   The `illustratorName` element contains the name of an *agent*
    responsible or jointly responsible for illustrating a written or
    visual *source*.

`http://terms.fhiso.org/sources/indexerName`
:   The `indexerName` element contains the name of an *agent*
    responsible or jointly responsible for creating a *source* which is
    primarily an index of one or more other *sources*.

`http://terms.fhios.org/sources/intervieweeName`
:   The `intervieweeName` element contains the name of a person who is
    a subject of an interview, and where the *source* is a transcript,
    recording or other representation of that interview.

`http://terms.fhiso.org/sources/interviewerName`
:   The `interviewerName` element contains the name of an agent responsible
    or jointly responsible for asking questions during an interview, and
    where the *source* is a transcript, recording or other representation
    of that interview.  A *citation element set* containing an
    `interviewerName` *should* normally also contain one or more
    `intervieweeName` *citation elements* identifying who was being
    interviewed.

`http://terms.fhiso.org/sources/transcriberName`
:   The `transcriberName` element contains the name of an *agent*
    responsible or jointly responsible for creating a written *source*
    which is primarily a verbatim or near-verbatim transcription of one
    or a small number other *sources*.

{.ednote} This definition needs to be clearer on the distinction between
compilation and transcription.

`http://terms.fhiso.org/sources/translatorName`
:   The `translatorName` element contains the name of an *agent*
    reponsible or jointly reponsible for the translation of a *source*
    from another language or languages.
    
{.ednote ...}  This list of sub-elements is somewhat based on the list
of roles in
[[CSL](//docs.citationstyles.org/en/stable/specification.html)].  No
decision has yet been taken on whether complete harmonisation is
desirable.

CSL's `collection-editor` and `container-author` have been omitted
pending a decision on how to deal with more general matters with
containment.

CSL's `original-author` and `reviewed-author` have been omitted, as it
is FHISO's current intention to store translations and reviews using
layers.

No use cases have been found to warrant the inclusion of CSL's
`editorial-director`.  Applications converting it to FHISO *citation
elements* should treat it as `editor` or `collection-editor`, or drop
it. 
{/}



## References

### Normative references

[ISO 10646]
:   ISO (International Organization for Standardization).  *ISO/IEC
    10646:2014. Information technology &mdash; Universal Coded Character
    Set (UCS).*  2014.

[ISO 15924]
:   ISO (International Organization for Standardization).  *ISO
    15924:2004.  Codes for the representation of names of scripts.*
    2004.

[ISO 639-1]
:   ISO (International Organization for Standardization).  *ISO
    639-1:2002.  Codes for the representation of names of languages
    &mdash; Part 1: Alpha-2 code*.  2002.

[ISO 639-2]
:   ISO (International Organization for Standardization).  *ISO
    639-2:1998.  Codes for the representation of names of languages
    &mdash; Part 2: Alpha-3 code*.  1998.  (See
    <http://www.loc.gov/standards/iso639-2/>.)

[RFC 2119]
:   IETF (Internet Engineering Task Force).  *RFC 2119:  Key words for
    use in RFCs to Indicate Requirement Levels.*  Scott Bradner, 1997.
    (See <http://tools.ietf.org/html/rfc2119>.)

[RFC 3987]
:   IETF (Internet Engineering Task Force).  *RFC 3987:
    Internationalized Resource Identifiers (IRIs).*  Martin Duerst and
    Michel Suignard, 2005. (See <http://tools.ietf.org/html/rfc3987>.)

[RFC 5646]
:   IETF (Internet Engineering Task Force).  *RFC 5646:
    Tags for Identifying Languages.*  Addison Phillips and Mark Davis,
    eds., 2009.  (See <http://tools.ietf.org/html/rfc5646>.)

[RFC 7230]
:   IETF (Internet Engineering Task Force).  *RFC 7230:  Hypertext
    Transfer Protocol (HTTP/1.1): Message Syntax and Routing.*  Roy
    Fieldind and Julian Reschke, eds., 2014.  (See
    <http://tools.ietf.org/html/rfc7230>.)

[RFC 7231]
:   IETF (Internet Engineering Task Force).  *RFC 7231:  Hypertext
    Transfer Protocol (HTTP/1.1): Semantics and Content.*  Roy
    Fieldind and Julian Reschke, eds., 2014.  (See
    <http://tools.ietf.org/html/rfc7231>.)

[UAX 15]
:   The Unicode Consortium.  "Unicode Standard Annex 15: Unicode
    Normalization Forms" in *The Unicode Standard, Version 8.0.0.*
    Mark Davis and Ken Whistler, eds., 2015.  (See
    <http://unicode.org/reports/tr15/>.)

[XML]
:   W3C (World Wide Web Consortium). *Extensible Markup Language (XML) 1.1*, 
    2nd edition.  Tim Bray, Jean Paoli, C. M. Sperberg-McQueen, Eve
    Maler, François Yergeau, and John Cowan eds., 2006.  W3C
    Recommendation.  (See <https://www.w3.org/TR/xml11/>.)

### Other references

[Chicago]
:   *The Chicago Manual of Style*, 16th ed.  Chicago: University of
    Chicago Press, 2010.

[CSL]
:   Zelle, Rintze M.  *Citation Style Language 1.0.1 Specification*.  2015.
    (See <http://docs.citationstyles.org/en/stable/specification.html>.)

[FOAF]
:   Brickley, Dan and Libby Miller.  *FOAF Vocabulary Specification
    0.99*.  2014.  (See <http://xmlns.com/foaf/spec/>.)

[JSON-LD]
:   W3C (World Wide Web Consortium).  *JSON-LD 1.0 &mdash;  A JSON-based
    Serialization for Linked Data.*  Manu Sporny, Gregg Kellogg and
    Markus Lanthaler, eds., 2014.  W3C Recommendation.  (See
    <https://www.w3.org/TR/json-ld/>.)

[Linked Data]
:   Heath, Tom and Christian Bizer.  *Linked Data: Evolving the Web into
    a Global Data Space*, 1st edition.  Morgan & Claypool, 2011.
    (See <http://linkeddatabook.com/editions/1.0/>.)

[RFC 7159]
:   IETF (Internet Engineering Task Force).  *The JavaScript Object
    Notation (JSON) Data Interchange Format*  Tim Bray, ed., 2014.
    (See <http://tools.ietf.org/html/rfc7159>.)

[SWBP XSD DT]
:   W3C (World Wide Web Consortium). *XML Schema Datatypes in RDF and OWL*.
    Jeremy J. Carroll and Jeff Z. Pan, 2006.
    W3C Working Group.  See <https://www.w3.org/TR/swbp-xsch-datatypes/>.

[XML Names]
:   W3 (World Wide Web Consortium). *Namespaces in XML 1.1*, 2nd edition.
    Tim Bray, Dave Hollander, Andrew Layman and Richard Tobin, eds., 2006.  
    W3C Recommendation.  See <https://www.w3.org/TR/xml-names11/>.

[XSD Pt2]
:   W3 (World Wide Web Consortium). *W3C XML Schema Definition Language (XSD)
    1.1 Part 2: Datatypes*.  W3C Recommendation.  See
    <https://www.w3.org/TR/xmlschema11-2/>

