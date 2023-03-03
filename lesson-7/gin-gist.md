# GIN, GIST INDEXES

- You always need to decide whether the table will be read heavy or write heavy when creating indexes
- gin, gist indexes want to know the data type
- `<@` means an array is contained within another array

## GIN

- general case inverted index for text search
- uses more space
- better for reading than writing
- try to create the index after inserting the data

```sql
create table docs (id serial primary key, doc text);


INSERT INTO docs (doc) VALUES
('This is SQL and Python and other fun teaching stuff'),
('More people should learn SQL from UMSI'),
('UMSI also teaches Python and also SQL');

create index gin1 on docs using gin(string_to_array(doc,' ') array_ops);
-- the index is breaking the document into an array

INSERT INTO docs (doc)
SELECT 'Neon ' || generate_series(10000, 20000);

explain analyze select id, doc from docs where '{learn}' <@ string_to_array(doc, ' ');
```

## GIST

- uses hashing
- might produce false matches
- smaller index table
- better for writing than reading
