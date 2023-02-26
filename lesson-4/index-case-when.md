# INDEXING

```sql
CREATE TABLE textfun(content TEXT);

CREATE index textfun_b on textfun (content);

SELECT pg_relation_size('textfun'),
    pg_indexes_size('textfun');

INSERT INTO textfun (content)
  SELECT (
          (
              case
                  when (random() < 0.5) then 'https://www.pg4e.com/neon/'
                  else 'https://www.pg4e.com/LEMONS/'
              end
          ) || generate_series(100000, 200000)
      );

SELECT pg_relation_size('textfun'),
    pg_indexes_size('textfun');
```

- indices on `text` columns are a bad idea, they take too much space, even more than the db itself
- most indices are binary trees Ologn
- `case when then else end` are if statement stuff
- the insert thing above adds 100k rows

- `%` is literally like `*` (0 1 2 chars wildcard) (mssql uses *)
- `_` just matches one char wildcard. `like '_r'` >> match smth with a letter before `r`

```sql
-- very fast
explain analyze
SELECT content
from textfun
where content like 'racing%'; -- anything that starts with racing, fast af

-- Seq Scan
-- Index Only Scan

-- full table scan, 1000x slower
explain analyze
SELECT content
from textfun
where content like '%racing%';

-- full table scan, might look for less if limit 1, 500x slower,
explain analyze
SELECT content
from textfun
where content like '%racing%'
LIMIT 1;

-- full table scan, 2000x slower, case insensitive much worse
explain analyze
SELECT content
from textfun
where content ilike '%150000%';

SELECT upper(content)
from textfun
where content like '%150000%';

SELECT left(content, 4)
from textfun
where content like '%150000%';

SELECT substr(content, 2, 4)
from textfun
where content like '%150000%';

SELECT split_part(content, '/', 4)
from textfun
where content like '%150000%';
```
