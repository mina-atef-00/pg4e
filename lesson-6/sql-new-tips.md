- you can select from different unrelated tables, you can give em table and column names without as, tables that you know u give em as alias

```sql
INSERT INTO docs_gin (doc_id, keyword) (
  SELECT DISTINCT
    id,
    s.keyword AS keyword
  FROM
    docs AS D,
    unnest(string_to_array(lower(D.doc), ' ')) s(keyword)
  WHERE
    s.keyword NOT IN (
      SELECT word FROM stop_words
    )
  ORDER BY id;
)
```

- there's nullish coalescing in sql, returns first not null.

```sql
SELECT COALESCE(NULL, NULL, 'umsi');
```

- `where something = ANY({'bro','man'})` is like `where something in {'bro','man'}`
