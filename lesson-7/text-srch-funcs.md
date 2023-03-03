# TEXT SEARCH FUNCTIONS

- `to_tsvector('english','<a sentenct>')` >> returns a list of lower-case stem keywords with their positions without stop-words from the document
- `to_tsquery('english','a word')` >> returns the stem of a couple words, if they are stop-words they will be omitted
- `@@` >> returns bool, if a ts-query is in a ts-vector

```sql
SELECT to_tsquery(
    'english',
    'Teach | teaches | teaching | and | the | if'
  );

SELECT to_tsquery('english', 'teaching') @@
  to_tsvector('english', 'UMSI also teaches Python and also SQL'); -- t
```

```sql
CREATE TABLE docs (id SERIAL, doc TEXT, PRIMARY KEY(id));

INSERT INTO docs (doc) VALUES
('This is SQL and Python and other fun teaching stuff'),
('More people should learn SQL from UMSI'),
('UMSI also teaches Python and also SQL');

INSERT INTO docs (doc)
SELECT 'Neon ' || generate_series(10000, 20000);

CREATE INDEX gin1 ON docs USING gin(to_tsvector('english', doc)); -- better than splitting into an array

EXPLAIN analyze SELECT id, doc FROM docs WHERE
    to_tsquery('english', 'learn') @@ to_tsvector('english', doc);
```

- there are a lost of `WHERE` operators that you could use
- you could use a lot more gin types other than `array_ops`

```sql
SELECT am.amname AS index_method, opc.opcname AS opclass_name
    FROM pg_am am, pg_opclass opc
    WHERE opc.opcmethod = am.oid
    ORDER BY index_method, opclass_name;
```
