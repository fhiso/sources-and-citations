### A JSON serialisation

{.ednote} There has been little discussion, and therefore no consensus
has been established, on whether to include a serialisation format in
this standard.  The principal motivation in providing one is to provide
an easy way of providing example data in this standard.  For this
purpose, a JSON syntax is more compact than an XML one.

This section defines a JSON serialisation of *citation element sets*.
Support for it is *optional*; even if an application wishes to support
serialisation to JSON, it may opt to do it differently.

A *citation element name* *shall* be serialised as a JSON string (per §7
of [[RFC 7159](http://tools.ietf.org/html/rfc7159)]) containing the
*citation element name*.

A *citation element value* which is a *string* *shall* be serialised as
a JSON string; a *citation element value* which is a *list* *shall* be
serialised as a JSON array of strings (per §5 of [[RFC
7159](http://tools.ietf.org/html/rfc7159)]).

{.example}  A book title would be serialised `"Royal Ancestry"` as the
`title` *citation element* is single-valued.  Its author would be
serialised `[ "Richardson, Douglas" ]` as the `creators-name` *citation
element* is list-valued.

The serialised *citation element value* *shall* be wrapped in an JSON
object (per §4 of [[RFC 7159](http://tools.ietf.org/html/rfc7159)])
comprising two members: one named `value` or `list` (depending on
whether the *citation element* is *single-valued* or *list-valued*) whose
value is the serialised *citation element value*, the other named `lang`
whose value is the *language tag* as a JSON string.  If the *language
tag* is omitted, either the `lang` member may be omitted or it may be
explicitly set to `null`.

{.example ...}  The wrapped versions of book title and author from the
previous example are: 

    { "value": "Royal Ancestry", "lang": null }
    { "list": [ "Richardson, Douglas" ] }

In this example, the former explicitly sets the `lang` to `null`, while
the latter does so implicitly.  Both are acceptable.  {/}

A *citation element set* is serialised as a JSON object, with each
distinct *citation element name* serialised as the JSON member name.  If
the *citation element name* is declared not to allow *language tags*,
then the JSON member value is the serialised *citation element value*;
if *language tags* are allowed, then the JSON member value is a JSON
array containing the wrapped version of every *citation element value*
from a *citation element* with the current *citation element name*.

{.example ...}  A simple *citation element set* containing just the
title and author of *Royal Ancestry* would be:

    { "http://terms.fhiso.org/sources/title":
        [ { "value": "Royal Ancestry" } ],
      "http://terms.fhiso.org/sources/creators-name":
        [ { "list": [ "Richardson, Douglas" ] } ] }

For an example demonstrating transliteration, consider
the title and author of the book *Η Γενεαλογία των Κομνηνών*:

    { "http://terms.fhiso.org/sources/title": 
        [ { "value": "Η Γενεαλογία των Κομνηνών" },
          { "value": "Hē Genealogia tōn Komnēnōn", "lang": "el-Latn" } ],
      "http://terms.fhiso.org/sources/creators-name":
        [ { "list": [ "Βαρζος, Κωνσταντίνος" ] },
          { "list": [ "Varzos, Konstantinos" ], "lang": "el-Latn" } ] }
{/}

{.note ...}  The syntax has deliberately been chosen to be compatible
with [[JSON-LD](https://www.w3.org/TR/json-ld/)].  To parse it as
JSON-LD, the following `@context` must be available to the parser.:

    "@context": { "value": "@value", "lang": "@language", 
                  "list": "@list" }

As this syntax is valid JSON-LD, this defines a conversion to
RDF using the algorithm set out in §10 of [[JSON-LD
API](https://www.w3.org/TR/json-ld-api/)].  {/}

{.ednote}  The combination of *language tags* and *list-valued*
*citation elements* means that the serialisation cannot take advantage
of JSON-LD's compact list representation by setting `@container` to
`@list`.  This is the reason why separate `value` and `list` keywords
are need in the serialisation proposed here.  If a simplification is
possible, it would be beneficial.


### List-flattening formats

It is anticipated that some adopters may need to serialise *citation
element sets* in a **list-flattening format** that does not allow a
*list* of one *string* to be distinguished from a single *string*.  

{.example ...} An application may wish to serialise *citation element
sets* as XML in a format with one element per *string* value, such as
follows:

    <elements>
      <element name="http://terms.fhiso.org/sources/title"
               value="[Eirene?], First Wife of Emperor Isaakios II" />
      <element name="http://terms.fhiso.org/sources/creators-name"
               value="Stone, Don C." />
      <element name="http://terms.fhiso.org/sources/creators-name"
               value="Owens, Charles R." />
    </elements>

In such a serialisation, there's no way of telling from the data that
the `creators-name` *citation element* is *list-valued*.  It can be
determined empirically when more than one author is given (as in this
example), but when only a single `creators-name` is given, the
serialisation gives no indication of whether a `creators-name` is
*list-valued* or *single-valued*.  This format is therefore
*list-flattening*. {/}

*List-flattening formats* are permitted by this standard; however, if
application uses such a format, it *must* ensure that the serialised
data includes a *citation element declaration* for every *extension
citation element* used in the data.  For consistency, it is
*recommended* that *citation element declarations* are also given for
*citation elements* defined by this standard.  *Citation element
declarations* *may* be included in non-*list-flattening formats* too.

{.note} This is essential to ensure that an application can convert data
from a *list-flattening format* to a non-*list-flattening format*, even
if unknown *extension citation elements* are present.  As these *must
not* be discarded, the data cannot be processed without a *citation
element declaration*.

## References

[JSON-LD]
:   W3C (World Wide Web Consortium).  *JSON-LD 1.0 &mdash;  A JSON-based
    Serialization for Linked Data.*  Manu Sporny, Gregg Kellogg and
    Markus Lanthaler, eds., 2014.  W3C Recommendation.  (See
    <https://www.w3.org/TR/json-ld/>.)

[JSON-LD API]
:   W3C (World Wide Web Consortium).  *JSON-LD 1.0 Processing Algorithms
    and API.*  Manu Sporny, Gregg Kellogg and Markus Lanthaler, eds.,
    2014.  W3C Recommendation.  (See
    <https://www.w3.org/TR/json-ld-api/>.)

[RFC 7159]
:   IETF (Internet Engineering Task Force).  *The JavaScript Object
    Notation (JSON) Data Interchange Format*  Tim Bray, ed., 2014.
    (See <http://tools.ietf.org/html/rfc7159>.)


