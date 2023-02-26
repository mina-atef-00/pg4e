#TEXT FUNCTIONS

## Where clause operators

- `LIKE (case-sensitive)| ILIKE (not case sensitive) | NOT LIKE | NOT ILIKE` >> wild card searches, full table scans
- `SIMILAR TO | NOT SIMILAR TO` >> similar to like but can use regex
- `= > < <= BETWEEN` >> fastest operators esp. if there are indices on the text columns.
- `IN` >> `WHERE 5 IN (1,2,3,4,5)`

## Text Manipulation

- `lower() | upper()`

## Other Ones

- `char_length('jose')` >> 4
- `position('om' in 'thomas')` >> 3
- `substring('thomas' from 2 for 3)` >> 'hom'
