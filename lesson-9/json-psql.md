# Structured Data in PostgreSQL

## HSTORE

- stores key, value pairs
- doesn't support structured data
- you could use indexes on them and they're pretty fast

```sql
select 'a=>1,b=>2'::hstore;
-- "a"=>"1", "b"=>"2"
```

## JSON

- basically a `TEXT` column with some extra features

## JSONB

- Json-Better
- new type, stores parsed json
- makes indexing better

```sql
CREATE TABLE IF NOT EXISTS jtrack (id SERIAL, body JSONB);
\copy jtrack (body) FROM 'lesson-9/library.jstxt' WITH CSV QUOTE E'\x01' DELIMITER E'\x02';
```

- You can put 🔥 indexes there

```sql
CREATE INDEX jtrack_btree ON jtrack USING BTREE ((body->>'name')); -- when searching for values in the name key
CREATE INDEX jtrack_artist_btree ON jtrack USING BTREE ((body->>'artist')); -- when searching for values in the artist key
CREATE INDEX jtrack_gin ON jtrack USING gin (body); -- when searching for the keys themselves
CREATE INDEX jtrack_gin_path_ops ON jtrack USING gin (body jsonb_path_ops); -- helps with @> operators
```

- Selecting

```sql
select (body->>'count')::int -- choose the count value & convert it to int
from jtrack
where body->>'name' = 'Summer Nights' -- where the name field equals ...
limit 1;

SELECT (body->>'count')::int
FROM jtrack
WHERE body @> '{"name": "Summer Nights"}'; -- same meaning

SELECT COUNT(*) FROM jtrack WHERE body ? 'favorite'; -- checks the number of rows with containing the key favorite

SELECT body->>'name' AS name
FROM jtrack
ORDER BY (body->>'count')::int
DESC;
```

- Updating & Insertion

```sql
insert into jtrack (body) select (
  '{"type": "Neon", "series": "24 Hours of Lemon","number": ' || generate_series(1000, 5000) || '}'
)::jsonb;

update jtrack set body = body || '{"favorite":"yes"}' where (body -> 'count')::int > 200;
```
