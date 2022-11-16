# ALTER TABLE

- you can change the schema and everything will change while the program is running, unless something might blow up

- For example if twitter changes their tweet limit

- You can alter indices, uniqueness, constraints, FKs

- You can drop columns.

## Example wrong schemas

### wrong!:

```sql
CREATE TABLE post (
  id SERIAL,
  title VARCHAR(128) UNIQUE NOT NULL,
  oops TEXT, -- You need to remove this column!
  content VARCHAR(1024) -- You need to turn this into TEXT!
  -- You need to add howmanylikes column!
);
```

### fix:

```sql
ALTER TABLE post
  DROP COLUMN oops,
  ALTER COLUMN content TYPE TEXT,
  ADD COLUMN howmanylikes INTEGER;
```

## TO RESTART THE SEQUENCE OF AN OLD SERIAL COLUMN

```sql
ALTER SEQUENCE id RESTART WITH 1;
```

---

# TO EXECUTE SQL FILES

```bash
\i path-to-sql-file.sql
```
