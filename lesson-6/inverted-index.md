# INVERTED INDICES

## essential indexing strats

- use unique, exclude by as much as you can
- try to filter the select as much as you can with where
- some times you can add a partial index (i.e. if all the events are finished, or maybe all the events are in past years and you want the ones in your year and you want to search for open events then filter the finished ones out using a partial index on the field, or you could just use a where clause instead of adding an index reducing the size by that)
- unique indexes make inserting faster, and index tables much smaller.

```sql
create unique index on events (time) where date_trunc(time,'1 year') > '2020'::date;
```

- you can make multi-column indexes if there are some certain combination that get queried a lot
- they can be reusable when searching for one of the columns alone

```sql
create index on event (time,done);
```

## the hard gory way

1- `string_to_array('Hello world', ' ')` >> literally like python `split()`, gets you an array
2- `unnest(string_to_array('Hello world', ' '))` >> puts the array in multiple rows, from horizontal to vertical

```sql
create table docs (id serial primary key, doc text);

insert into docs (doc)
values (
    'This is SQL and Python and other fun teaching stuff'
  ),
('More people should learn SQL from UMSI'),
('UMSI also teaches Python and also SQL');

CREATE TABLE docs_gin (
  keyword TEXT,
  doc_id INTEGER REFERENCES docs(id) ON DELETE CASCADE
);
```
