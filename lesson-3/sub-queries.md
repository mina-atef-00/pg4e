# SUB QUERIES (USE AT CAUTION)

- not preferred when you're going to manipulate data a lot of times like in a system

  - useful tho when you make a 1 time change

- use a query to get the value of something inside another query

## Example

- You have 2 queries:

```sql
SELECT id FROM account WHERE email='asdf@asdf.com'; -- => returns 7
SELECT content FROM comment WHERE account_id=7;
```

- You can turn them into 1:

```sql
SELECT content FROM comment WHERE account_id=(SELECT id FROM account WHERE email='asdf@asdf.com');
```

---

## Why they bad

- Having sub-queries might make the DBMS use a temporary table for the inner select and then read from it which will slow down the query.
- So splitting the query is more efficient although not as elegant.

---

## Some Usage

- Some DBMSes don't have the `HAVING`, so you have to use sub-queries.

```sql
SELECT
  ct, abbrev

  FROM ( -- Temp table
    SELECT
      COUNT(abbrev) AS ct,
      abbrev
    FROM pg_timezone_names
    WHERE is_dst = 'f'
    GROUP BY abbrev -- only distinct abbrevs
  ) AS zap -- This is what would have been written before the HAVING

  WHERE ct > 10 -- This is the HAVING
  LIMIT 15;
```

- it is equivalent to:

```sql
SELECT
  COUNT(abbrev) AS ct,
  abbrev
FROM pg_timezone_names
WHERE is_dst = 'f'
GROUP BY abbrev
HAVING COUNT(abbrev) > 10
LIMIT 15;
```
