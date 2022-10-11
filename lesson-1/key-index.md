# KEYS

## Auto incrementing

Just use the `SERIAL` type, and then define the pk row `PRIMARY KEY(<row_name>)`.

You can add `UNIQUE` (_logical key_) to make rows unique.

Integer indices are the fastest.

```sql
CREATE TABLE users(
  id SERIAL,
  name VARCHAR(128),
  email VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);
```

---

# INDICES

RDBMSes use hashes or trees for the fastest lookups.

It's abstracted though, the system will handle it.

## Binary Tree Indices O(logn)

- You split up the ranges and have indices to the ranges.
- Best used for:
  - exact match lookups like emails
  - sorting
  - range lookups
  - prefix lookups (like when adding `UNIQUE` to string columns)

## Hash Indices O(1)

- Faster
- Only good for exact matches (id primary keys, GUIDs). You can't do lookups on them.
