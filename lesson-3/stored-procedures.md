# STORED PROCEDURES

## What are they

- basically functions for sql.
- they get stored in a virtual table on the db server and gets called on triggers or whatever.
- multiple langs could be used to write them on psql (perl, tck), but plpgsql is best for psql.

---

## Why

- much better performance-wise, your executing logic on the db instead of the code.
- you need a custom db rule that must be enforced (like update updated_on automatically on psql).

---

## Down sides

- veryyyyyyyy unportable to other databases.

---

## Example

- You want to implement auto update of the `updated_at` attribute when updating a set.

```sql
update fav set howmuch=howmuch+1 -- on postgres we have to set updated_at field every time !
  where post_id=1;
```

1. make a function

```sql
create or replace function trigger_set_timestamp() returns trigger as $$ -- your basic func definition
begin -- {
  new.updated_at = now();
  return new;
end; -- }
$$ language plpgsql; -- you need to define the language, it can return a trigger or a statement, etc..
```

2. make a trigger on update for a certain table that executes a function

```sql
create trigger set_timestamp -- creating the trigger
  before update on fav -- the trigger happens when you update on table fav
  for each row -- on the row
  execute procedure trigger_set_timestamp(); -- execute the function
```
