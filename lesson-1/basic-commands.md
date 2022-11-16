# BASIC DBMS COMMANDS

## Outside

- `sudo -u postgres psql` => give sudo perms to postgres user and run psql (opens root user)
- `psql -U mina -p 8050 -h 127.0.0.1 people` || `psql people mina` => opens _people_ database on localhost using port 8050

## Inside

- `\du` => Lists roles (users)
- `\l` => Lists all the databases
- `\dt` => List tables in connected database
- `\d+ <table_name>` => List columns on table (+ for extra info)

---

# BASIC SQL COMMANDS

0. Creating users

```sql
CREATE USER mina WITH LOGIN CREATEDB CREATEROLE SUPERUSER CONNECTION
LIMIT 100 VALID UNTIL '2030-01-01' PASSWORD 'passbro';
```

0.1. Creating Databases

```sql
create database revisionStuff owner mina encoding utf8;
```

1. Creating tables

```sql
CREATE TABLE users(
    name VARCHAR(128),
    email VARCHAR(128)
);
```

2. Inserting data into tables

```sql
INSERT INTO users (name, email)
VALUES
    ('Mina','menaloli@gmail.com'),
    ('James','james@gmail.com'),
    ('Franklin','franklin@gmail.com');
```

- You can make the database return certain columns of the object when inserting (_useful for post_)

```sql
INSERT INTO users (name, email) VALUES ('Mina','menaloli@gmail.com') RETURNING name,email;
```

3. Deleting rows in tables

```sql
DELETE FROM users
    WHERE email='menaloli@gmail.com';
DELETE FROM users WHERE name='Mina';
DELETE FROM users;
```

4. Updating rows in tables

```sql
UPDATE users SET
        name='Antonious',
        email='niabcdefg@outlook.com'
        WHERE email='menaloli@gmail.com';
```

5. Retrieving rows from tables

```sql
SELECT * FROM users;
SELECT (name,email) FROM users WHERE
    name='Mina',
    email='menaloli@gmail.com';
```

6. ORDERING & Retrieving rows from tables **ASCENDING BY DEFAULT**

```sql
SELECT * FROM users ORDER BY email DESC;
SELECT * FROM users ORDER BY name, email DESC;
```

**WHERE CLAUSE IS IMPORTANT DON'T JUST UPDATE/DELETE ALL ROWS**

- `WHERE` applies the query to all rows that are true

---

**ALL OF THE ABOVE QUERIES USE INDICES SO THEY DON'T HAVE TO DO A FULL TABLE SCAN WHICH WILL BE VERY COSTLY**

_The wild cards tho..._

```sql
SELECT * FROM users WHERE name LIKE '%mem%'; -- contains mem
SELECT * FROM users WHERE name LIKE 'age%'; -- starts with age
SELECT * FROM users WHERE name LIKE '%ender'; -- ends with ender
```

`name LIKE '%e%'` searches for names that contain the letter **e** using this wildcard

Later you will learn to make indices that make this look up more efficient

---

- `OFFSET/LIMIT` limit the amount of rows retrieved from the db server.
- you put them at the very end of the query.
- `OFFSET` **starts from 0**

this query shows the second of two rows

```sql
SELECT * FROM users ORDER BY name DESC OFFSET 1 LIMIT 2;
```

---

`SELECT COUNT(*)` retrieves just the count instead of fetching all the rows then counting.

```sql
SELECT COUNT(*) FROM users WHERE name='Mina'
```
