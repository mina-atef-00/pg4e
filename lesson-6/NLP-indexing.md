# NATURAL LANGUAGE PROCESSING INDEXING

- We need to make use of NL characteristics to make indexes smaller and faster.

## Stop words

- words like `is, this, and`, propositions, pronouns.
- vary by languages.
- **they should be ignored when querying**.
- they don't have any special meaning, don't help with the search.


## Stemming

- words like `teaching, teacher` come from the stem `teach`.
- making a stem table and making queries using it makes the index size much smaller.
