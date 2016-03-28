An informal effort to document progress being made on tsc-public.

# Apparent Decisions

-   Authors will be stored in some form of ordered list; the details have not been determined
-   Each author will be stored in a use-case-based microformat (unless another better option is designed)

# Authors

-   We need to support a list of authors, but have not determined how to represent that list
    -   We do not intend to support unordered sets of authors
    -   We do not support requiring support for multiple properties with the same key but distinct values
    -   We have not decided between two implementation options for a specification:
        -   spec says "list of" and leaves the implementation to the serialization format
        -   spec defines a list microformat

-   We need to support more than a simple string for each author
    -   Identified use-cases:
        -   Long-form in-text display (the name as it appears in full in the native language)
        -   Short-form in-text display (an abbreviated form, often a family name)
        -   Sorted display form (e.g., "surname, given")
        -   Sort-by internal form (e.g., in Japanese this is hiragana not katakana; surname prefixes excluded; etc)
    -   Two options have been discussed:
        -   A microformat based on name parts (family name, prefix, title, etc)
        -   A microformat based on the identified use cases
    -   Informal polling sided for use-case-based (5 of 6 participating) with 1 vote "we need another option"


# Potential vocabulary items

This is far from complete, just what we've mentioned, and in no particular order or organization

-   accessed-by
-   accessed-date
-   archive-name (archive)
-   archive-address
-   author-name (author)
-   chapter
-   closure-status
-   compiler-name (compiler)
-   creator-name
-   creator-role
-   database-name
-   database-url
-   description
-   edition
-   editor-name (editor)
-   entry-date
-   entry-name
-   entry-url
-   foramt
-   held-by
-   indexer
-   legal-status
-   location-type
-   location-value
-   number
-   page-set
-   person
-   publication-date
-   publication-title
-   publisher-address
-   publisher-name
-   reference
-   section
-   section
-   specific-item
-   sub-entry
-   title
-   transcriber
-   translator
-   URL
-   volume
-   where-within-source
-   *X*-number for publisher-defined *X*
