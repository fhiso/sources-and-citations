Regular Expressions
-------------------

The goal of this document is to defined a "least-common denominator" for regular expressions.
In particular, it aims to define a subset of common regular expression dialects that can be accepted by most regular expression engines
with at most a preprocessing regular expression replacement to adjust syntax.

A regular expression is a string defining a **language**, or set of strings.
A regular expression is said to **match** a string if and only if that string is in the regular expression's **language**.


Regular Expression
:   A **regular expression** consists of one or more *branches*.
    Between each *branch* is a single U+007C `|` character.
    
        regExp ::= branch ( '|' branch )*
    
    The language of a *regular expression* is the union of the languages of its *branches*.
    
Branch
:   A **branch** consists of one or more *pieces*.
    The *pieces* of a *branch* appear adjacent to one another with no intervening characters.
    
        branch ::= piece piece*
    
    A *branch* matches a string if and only if it consists of a prefix that matches the first *piece* of the *branch*
    and the remainder of the string matches the remaining *pieces*.

Piece
:   A **piece** consists of an *atom*, possibly followed by a **quantifier**.

        piece ::= atom quantifier?
        quantifier ::= [?*+] | ( '{' quantity '}' )`
        quantity ::= quantRange | quantMin | QuantExact
        quantRange ::= QuantExact ',' QuantExact
        quantMin ::= QuantExact ','
        QuantExact ::= 0 | [1-9] [0-9]*

    The language of a *piece* depends on the *quantifier* used.
    If S is an *atom* then
    
    | Piece      | Language                                                                  |
    |------------|---------------------------------------------------------------------------|
    | S          | *L*(S)                                                                    |
    | S `?`      | the empty string, and all strings in *L*(S)                               |
    | S `*`      | all concatenations of zero or more strings in *L*(S)                      |
    | S `+`      | all concatenations of one or more strings in *L*(S)                       |
    | S `{n,m}`  | all concatenations of at least *n* and no more than *m* strings in *L*(S) |
    | S `{n}`    | all concatenations of exactly *n* strings in *L*(S)                       |
    | S `{n,}`   | all concatenations of at least *n* strings in *L*(S)                      |

{.note} The above omits `{,n}`, which some regex dialects allow as a shorthand for `{0,n}`.

{.note} The above omits the lazy quantifiers `*?`, `+?`, etc., which some dialects allow to select between derivations of a particular string.

{.note} The above prohibits `{02,12}` and other leading zeros in quantities.


Atom
:   An **atom** is either a *normal character*, an *escaped character*, a *character class*, or a parenthesized *regular expression*.

        atom ::= NormalChar | escapedChar | charClass | '(' regExp ')'

    The language of an atom that is a parenthesized *regular expression* is the language of that *regular expression*
    Otherwise, the language of an atom is the same as it case.

Normal Character
:   A **normal character** is any *character* that is not a *metacharacter* or a *banned character*.

    The **metacharacters** are '`.`', '`\`', '`?`', '`*`', '`+`', '`{`', '`}`', '`(`', '`)`', '`|`', '`[`', and '`]`'.

    The **banned characters** are '`^`', '`$`', '`&`', '`/`', and the escapable control characters U+0000, U+0009, U+000A, and U+000D.

{.note} The above requires metacharacters not appear as normal characters unescaped. Some dialects are more permissive, allowing e.g. `}` to appear unescaped, but that is prohibited in this specification.

{.note} The banned characters have special meaning in some regular expression dialects.

{.ednote} It is not clear that the set of banned characters is the right set. Do we need to add other control characters?

Escaped Character
:   An **escaped character** is a U+005C `\` followed by a single character from the table below.
    It represents the single character listed below.
    
    | Escaped Character | Represents               |
    |-------------------|--------------------------|
    | `\0` | U+0000 (null) |
    | `\t` | U+0009 (tab) |
    | `\n` | U+000A (line feed) |
    | `\r` | U+000D (carriage return) |
    | `\.` | `.` |
    | `\\` | `\` |
    | `\?` | `?` |
    | `\*` | `*` |
    | `\+` | `+` |
    | `\{` | `{` |
    | `\}` | `}` |
    | `\(` | `(` |
    | `\)` | `)` |
    | `\|` | `|` |
    | `\[` | `[` |
    | `\]` | `]` |
    | `\^` | `^` |
    | `\$` | `$` |
    | `\&` | `&` |
    | `\-` | `-` |
    | `\/` | `/` |
    
{.note} The above list of escapes is smaller than many other dialects; the goal is to only include escapes all dialects respect. Some engines will require reformatting these; for example basic POSIX regular expressions interchange the meaning of `\(` and `(`.

{.note} Not all single-character escapes must be escaped in all situations. `-` may appear unescaped in an atom, and many others may appear unescaped in a character class.  However, all may be escaped anywhere.

{.note ...}
Code-point escapes (e.g., `\x{2F2E}` for `⼮`) are not provided in this specification because they are not supported in some common regular expression engines such as POSIX and XML. Instead, unicode should be expressed in the same encoding used by the strings being checked for membership in a regular expression's language.

If the chosen engine is byte- rather than code-point-oriented, care should be made that (a) quantifiers bind to characters, not bytes; and (b) character class ranges are correctly handled.
Binding can be achieved by adding parentheses around each multi-byte character; how to achieve character class ranges is not known in general by the authors of this specification.
{/}


Character Class
:   A **character class** is either a *positive character class*, a *negative character class*, or a *wildcard*.

        charClass ::= posCharClass | negCharClass | wildcard

Positive Character Class
:   A **positive character class** is a set of one or more *character ranges* within brackets.

        posCharClass ::= '[' charRange+ ']'
        
    A string matches a *positive character class* if it contains only a single character and that character is within at least one of the ranges.

Character Range
:   A **character range** is either a single *class character*
    or two *class characters* separated by a U+002D `-`.
    
        charRange ::= classChar | classChar '-' classChar
    
    If a character range has two *class characters* the second MUST NOT have a numerically lesser code point than the first.
    
    A character is within a single-character *character range* if it is that character.
    A character is within a two-character *character range* if its code point is ≥ the first character's code point and ≤ the second character's code point.

Class Character
:   A **class character** is either an *escaped character* or a single character that is neither a *class metachracter* nor a *banned character*.

    The **class metacharacters** are '`.`', '`\`', '`-`', '`|`', '`[`', and '`]`'.

Negative Character Class
:   A **negative character class** is a set of one or more *character ranges*, preceeded by U+005E `^`, within brackets.

        negCharClass ::= '[^` charRange+ ']'
    
    A string matches a *positive character class* if it contains only a single character and that character is not within any of the ranges.

Wildcard
:   A **wildcard** is represented as U+002E `.`.
    
        wildcard ::= '.'
    
    The language of a *wildcard* is the set of all single-character strings.

{.note} The above definition includes new line characters in the langauge of `.`. When using an engine that does not do so, replace all `.` with something else, such as `(.|[\r\n])`, `(.|\s)`, or `[\s\S]`. Which one works depends on the engine in question.


Dialect Guide
-------------

{.note} This entire section is non-normative.

{.ednote} This section is incomplete, and mostly added to as a sanity-check to see if engines I use can handle these regexs. It should probably either be removed or completed.

Following are some suggestions for making regular expressions in the above dialect work with various regular expression engines.

C++11 std::regex
:   Use the `ECMAScript` variety and `regex_match` (not `regex_search`).
    Replace non-escaped `.` with `(.|\s)`.
    Proper use of `\0` is not yet known.

C++ boost::regex
:   Use the `ECMAScript` variety.
    How to ensure full match not known.
    Proper use of `\0` is not yet known.

ECMAScript
:   Surround expression with `^(`...`)$`.
    Replace non-escaped `.` with `(.|\s)`.
    Leave `\0` as is.

Java
:   Surround expression with `^(?s`...`)$`.
    Proper use of `\0` is not yet known.

.NET
:   Use the `RegexOptions.Multiline` option or replace non-escaped `.` with `(.|\n)`.
    Surround expression with `^(`...`)$`.
    Proper use of `\0` is not yet known.

Perl
:   Use `m/^(`...`)$/s`. 
    Proper use of `\0` is not yet known.


PCRE
:   Use the `PCRE_UTF8` option.
    Surround expression with `^(`...`)$`.
    Proper use of `\0` is not yet known.

PCRE2
:   Use the `PCRE2_UTF` and `PCRE2_DOTALL` options.
    Replace `\0` with `\x{0}`.
    Surround expression with `^(`...`)$`.

PHP
:   Surround expression with `/^(`...`)$/us` with the `preg_`... functions.
    Proper use of `\0` is not yet known.

POSIX
:   Requires extensive modifications.
    Basic mode swaps what gets escaped and what does not.
    Things that do not require escaping may forbid escaping and require pre-processing to strip `\`s.

Python
:   Use the `re.DOTALL` option.
    In Python 3.4 and later, use the `fullmatch` function; otherwise use `match` and append a `$` to the expression.
    Leave `\0` as is.

Ruby
:   Surround expression with `/\A(`...`)\Z$/m`.
    Proper use of `\0` is not yet known.
    
XML
:   Replace `.` with `[\s\S]`.
    Proper use of `\0` is not yet known.


Comments
--------

The above dialect is a regular language (does not include back references).
It does not have named or general category classes (`[:alphanum:]`, `\pL`, etc.).
It does not define capturing groups, and thus does not need or support lazy quantifiers.
It does not have partial-string matching, and thus doe not need to worry about the difference in `(a|an)` vs `(an|a)`.
