# TSC meeting 2017-01-26

Present: Luther, Richard, Tony

We have several potentially-parallel directions in which to move:

-   Handle outstanding issues (marked `.ednote` in the markdown source)

-   Create introductory text, as either one or several documents, including examples

-   Create example bindings to existing models
    -   Selected GEDCOM and GEDCOM-X as first-priority example bindings (quite different so if bind to both can likely bind elsewhere too)
    -   GEDCOM binding depends on GEDCOM extension standard, noted below

-   Create a proposed standard for GEDCOM extensions
    -   A proposal for adding extension tags is found in [CFPS 37](http://tech.fhiso.org/cfps/files/cfps37.pdf)
    -   Also need a way to identify structure inside existing tags with no imposed structure in the GEDCOM standard
        -   Must be contextual: some tag names are used to mean different things in different contexts (e.g., the `NAME` tag can be either a structure or a text element and can name people, products, or repositories)
        -   Adding a tag to the `HEAD` might work; see, e.g., json-ld's `@context` and event-gedcom's schema

To facilitate preliminary technical work without the hubbub of `tsc-public`, it is proposed that we create a `technical-work` mailing list to facilitate discussions not easily handled via github.

A follow-up meeting was set for 2017-02-16 14:00Z
