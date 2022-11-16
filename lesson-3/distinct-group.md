# DISTINCT / DISTINCT ON / GROUP BY

- They are used after the join

- `DISTINCT` only returns unique rows with 0 vertical replication.
- `DISTINCT ON` removes duplicates that occur on **specified** columns, but allows dups on other columns.
- `GROUP BY` is like distinct on where it limits vertical duplication, but can be used with **aggregate functions**:
  - like `COUNT()` `MAX()` `SUM()` `AVE()`
  - on the rest of the rows

---

## Distinct

```sql
SELECT DISTINCT make FROM racing;
```

- the more you reduce the number of columns you need with `SELECT`, the more optimized your query will be, because of less distinct combinations.

---

## Distinct on (not commonly used at all)

```sql
SELECT
  DISTINCT ON (model)
  make,model FROM racing;
```

- it will just be distinct on model but not the make.

---

## Group By

- you add a aggregate function column and then you make a group by so you can limit the vert replication.

```sql
SELECT -- You want to limit duplicates of the abbrev column (like distinct on) & then count the rows
  COUNT(abbrev), abbrev
  FROM pg_timezone_names GROUP BY abbrev
  LIMIT 10;

select country, -- Gets the aggregate sum of the combination of countries, cities
    city,
    count(country, city)
from countries
group by 1, 2; -- You can use this numbering 1,2,3,... instead of having to repeat the column names each time
```

---

## HAVING

- `WHERE` clause can **only** filter results before the group by calculations.
- use `HAVING` instead after the group by to filter the calculated results.

```sql
SELECT
  COUNT(abbrev) AS ct,
  abbrev AS abbreviation
  FROM pg_timezone_names
  WHERE is_dst='t'
  GROUP BY abbrev
  HAVING COUNT(abbrev) > 10;
```
