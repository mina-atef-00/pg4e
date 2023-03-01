# BLOCKS & DBS

- column types take different spaces
- rows are stored in blocks, when you `select` it doesn't looks for rows but blocks stored on disk and reads it in memory.
- best block size is around 8kiBs
- indexes reduce the number of blocks you have to read in memory reducing the time greatly compared to sequential scans.

---

<br>

# INDEXES

- basically indexes give you a hint on the location of a row inside a block, so you wont have to sequentially look up through them. plus they're much smaller than the actual data so you can lookup even faster.

## Index Types

### Forward normal ones

- You give a logical key to the index, it gives you the row containing that key.

- **btree**
  - default one
- **brin**
  - mostly exclusive to PG
  - like python lists
  - smaller & faster than btrees
  - but more useful when the data is mostly sorted like dates and sequence ids
- **hash**
  - they fast af, exact lookups though

### Inverse weird ones

- You give a query to the index, it gives you a list of all rows matching it.
- best used when searching text with a few words, like in search engines.

- **GIN**
  - generalized inverted indexes
  - multiple vals in a column
- **GiST**
  - generalized search tree
- **SP-GiST**
  - best used with location data like long/lat
