---
title: CSL Extensions for Family History
...

The Citation Style Language (CSL) is [an open source project](https://citationstyles.org/) to help automate the formatting of citations in scholarly publications.
Relevant documents include

- The [CSL Specification](https://docs.citationstyles.org/en/stable/specification.html) which focuses on how to specify formatting, while also listing components of citations.
- [Machine-readable definitions](https://github.com/citation-style-language/schema/tree/v1.0.1), notably including `csl-data` for defining citation data in both [JSON](https://raw.githubusercontent.com/citation-style-language/schema/v1.0.1/csl-data.json) and [XML](https://raw.githubusercontent.com/citation-style-language/schema/v1.0.1/csl-data.rnc)
    - aside: the JSON name-variable type has properties not in the corresponding XML
- URIs for some CSL variables are defined in the [CSL Ontology](https://citationstyles.org/ontology/).
- The [citeproc-js](https://github.com/Juris-M/citeproc-js) project defines [a JSON format](https://citeproc-js.readthedocs.io/en/latest/csl-json/markup.html) for `csl-data`.

CSL is missing some components needed for use in family history.

# Missing Terms

[CSL's list of terms](https://docs.citationstyles.org/en/stable/specification.html#appendix-ii-terms) does not have the following (and possibly others)

- microfilm
- microfiche
- monument/grave marker
- deed
- birth/marriage/death license
- court filing
- court proceedings/ruling
- latitude / longitude

# Layering

CSL has some layering built-in: in particular, the layering common in academic publications (article in issue in journal, etc). It does this with special terms for each detail about each layer of the supported set. That is not extensible to the much more rich layering common in family history citations.

## Layering in citations

1. Add another datatype (in addition to CSL's three "Standard", "Date", and "Name"): "XRef"
    
    - I expect we can re-use the [cite-item structure](https://citeproc-js.readthedocs.io/en/latest/csl-json/markup.html#cite-items) for values of this type

2. Add a set of verbs with XRref values, such as
    - transcript-of
    - index-of
    - image-of
    - cites
    - part-of
    - ...

## Layering in style definitions

We'll need to define how style files use XRef components; how to do so TBD


# Embedding in GEDCOM

- `_CSLSOUR` has to be a record because we need them to point to each other
- Substructures of `_CSLSOUR` are unordered
- We could add all verbs from CSL, but that would (a) be roughly a hundred new tags and (b) mean a new version of the tags would be needed with every CSL update
- We could add one tag for each value type, with subordinate `TYPE` fields naming the appropriate CSL variable name

    ````gedstruct
    n @XREF:_CSLSOUR@ _CSLSOUR  {1:1}
    +1 _DVAR <CslDate>          {0:M}
    +2 TYPE <Enum>              {1:1}
    +1 _TVAR <Text>             {0:M}
    +2 TYPE <Enum>              {1:1}
    +1 _NVAR                    {0:M}
    +2 _CSLNAME                 {0:M}
    +3 _NAMEPART <Text>         {0:M}
    +4 TYPE <Enum>              {1:1}
    +1 _SOUR @<XREF:_CSLSOUR>@  {0:M}
    +2 TYPE <Enum>              {1:1}
    ````
    
    Allowable type enums are
    
    - _DVAR.TYPE: any "Date Variable" from CSL Specification Appendix IV - Variables
    - _TVAR.TYPE: any "Standard Variable" (including "Number Variable") from CSL Specification Appendix IV - Variables
    - _NVAR.TYPE: any "Name Variable" from CSL Specification Appendix IV - Variables
    - _NAMEPART.TYPE:
        - SURN -- csl's "family"
        - GIVN -- csl's "given"
        - NSFX -- csl's "suffix"
        - _DROPPING_PARTICLE
        - _NON_DROPPING_PARTICLE
        - _LITERAL
        - possibly others, like "_CSL_JSON_NAME" and "_FHISO_CREATOR_NAME"?

- CSL dates are mostly a subset of GEDCOM dates, but also include four seasons. We can probably express them as a new datatype that uses mostly GEDCOM's date ABNF

    ````abnf
    CslDate = cslOneDate
            / FROM cslOneDate TO cslOneDate
            / ABT cslOneDate
    cslOneDate = [[day D] month D] year [D epoch]
               / season D year
    season = %s"Q1" / %s"Q2" / %s"Q3" / %s"Q4"
    ````

- CSL names are compatible with neither [FHISO's creator's name draft](https://fhiso.org/TR/creators-name) nor [GEDOCM's personal name datatype](https://gedcom.io/specifications/FamilySearchGEDCOMv7.html#personal-name), so that will likely require a new set of structures to represent names

# Embedding in GEDOCM-X

Presumably the [XML input format](https://raw.githubusercontent.com/citation-style-language/schema/v1.0.1/csl-data.rnc) could be used as-is in GEDOM-X, with appropriate extensions to add layering to it.
