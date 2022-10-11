## TEXT FIELDS FOR CHARACTER SETS

#### Indexable for searching

### Used for indexing, ordering by:

- `CHAR(n)` uses the whole `n` space for the string (best used if all strings are of the same length). for hashes, ISPN, country codes.
- `VARCHAR(n)` variable space with a limit of `n`. best if you knows how much space the text will probably need, like titles or usernames or whatever.

### Don't index using this, maybe a LIKE statement using a table scan

`TEXT` you just don't know how much space you need, best for html pages, paragraphs.

## BINARY FIELDS (BLOBS) NOT HAVING CHARACTER SETS

- Character (8-32 bits of info depending on charset)
- Byte (just 8 bits of info)
  - `BYTEA(n)` up to 255 bytes
- Small Images

_Not indexed or sorted._

---

## NUMERIC FIELDS

### Integers

- `SMALLINT` -32k => 32k
- `INTEGER` 2billion
- `BIGINT` 10^18

### Floating Points

- `REAL` (32bit-10^38) 7 digits of precision after the point
- `DOUBLE PRECISION` (64bit-10^308) 14 digits of precision after the point
- `NUMERIC(accuracy_digits, decimal_digits_after_fps)` specify the accuracy digits and how many digits you want after the floating point. **BEST FOR MONEY (104,53$)**

---

## AUTO_INCREMENT FIELDS

- `TIMESTAMP` date and time 64 bits
- `DATE` date
- `TIME` time

`NOW()` is a function to get current time.

`DEFAULT` for default values.
