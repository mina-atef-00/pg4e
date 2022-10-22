# KEYS

- keys are connection points that make finding data faster.
  ![](images/firefox_qYjUCwFENg.png)

## Key Types

### Primary key

- Auto increments in general, used to replicate data.
- Not that useful for searching though, just instant access.

### Logical key

- email address, title of track.
- not as efficient as integer ids but that's what the user would lookup logically.

### Foreign key

- int in a table that points to another tables.
- will be used later for JOINS.

---

## Naming Conventions

- all tables have `id` column (PK)
- foreign keys are `<table_name>_id`
- logical keys are whatever

---

## Primary Keys

- NEVER use a logical key as a primary key
  - strings aren't as efficient as ids
  - GUIDs/emails might change later you never know

---

## Foreign Keys

![](images/firefox_cyrGaPwUts.png)

- They MUST point to PKs (that are integers)
- if all is int then the joining will be blazingly fast
