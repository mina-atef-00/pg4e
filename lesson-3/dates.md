# DATES

- dates don't need time-zones.
- time though needs to be simultaneous between different time-zones.
- `TIMESTAMPTZ` is always better than regular timestamps. Changes with your time-zone.
  - UTC is preferred when storing timestamps.
  - And then convert them to the desired time zone when retrieving.

```sql
SELECT
  NOW(), -- defaults to your time zone
  NOW() AT TIME ZONE 'UTC', -- utc
  NOW() AT TIME ZONE 'HST'; -- another time zone
```

- To check available time zones:

```sql
SELECT *
  FROM pg_timezone_names ptz
  WHERE name LIKE '%Hawaii%';
```

---

## Casting Types

```sql
SELECT
  NOW() :: DATE, -- psql sugar
  CAST(NOW() AS TIME); -- more standard
```

---

## Date/Time Intervals

- We use `INTERVAL 'n days/years/minutes/seconds'` for intervals.

```sql
SELECT
  NOW(),
  NOW() - INTERVAL '2 days',
  CAST((NOW() - INTERVAL '5 years') AS DATE),
  (NOW() - INTERVAL '3 minutes')::TIMETZ;
```

---

## Truncating Accuracy From Timestamps

- Use `DATE_TRUNC('day/month/year/second/minute',<the_actual_time>)`

Example:

```sql
SELECT
  content, created_at FROM comment
  WHERE
    created_at >= DATE_TRUNC('day', NOW()) -- created from the beginning of this day
    AND
    created_at < DATE_TRUNC('day', (NOW() + INTERVAL '1 day')); -- till tomorrow
```

**!!! IMPORTANT !!!**

- SOME QUERIES RETURNING THE SAME RESULTS ARE FASTER THAN OTHERS.
- The query above is **faster** than:

```sql
WHERE created_at::DATE = NOW()::DATE;
```

- As the casting to `DATE` can prevent the DB from using optimizations used with `DATE_TRUNC()`.
