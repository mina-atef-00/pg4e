# INDEXING TECHNIQUES / HASHES

## charsets

`ascii('w')` >> returns ascii code
`chr(<ascii_code>)` >> returns ascii char

- python uses unicode, http/email/db use utf-8, decode/encode

## hashing

`md5('bruh')` >> 128-bit hash

## indexing strats

- we can make unique indexes & drop em

```sql
create unique index if not exists index_name_b_or_h on table using btree (column);

drop index index_name;
```

- We for example wanna make a web-crawler db & want to store out-going urls
- lots of lookups (100s)

```sql
create table crl(
  id serial primary key,
  url varchar(128) unique, -- logical key
  content text
);

insert into crl(url) (
  select repeat('Neon',1000) || generate_series(1,5000)
); -- won't work, url bigger than 128 chars
```

### 3 b-tree methods

#### normal index on text url

- big index, quick lookups (LIKE, ILIKE, SIMILAR TO), quick exact match (=)

```sql
create table cr2(
  id serial primary key,
  url text,
  content text
);

create unique index cr2_unique on cr2 (url);

insert into cr2(url) (
  select repeat('Neon',1000) || generate_series(1,5000)
); -- 4001 char urls


SELECT pg_relation_size('cr2'),
    pg_indexes_size('cr2');
```

#### adding an index for the url hash no hash column

- smaller index size, **works only when you compare hashes**, still quick

```sql
drop index cr2_unique;

create unique index cr2_md5 on cr2 (md5(url)); -- hashes then adds to index table

SELECT pg_relation_size('cr2'),
    pg_indexes_size('cr2');

explain analyze
select * from cr2
where md5(url)=md5('lemons'); -- only way to use index
```

#### separate hash column

- a lot bigger relation size cuz we add a new column, but much much faster.
- there's a uuid column type that's very easy to use with md5 hashes, same size.
- you can add a function & trigger to add a uuid hash of a url to the hash column after adding the url.

```sql
create table cr3(
  id serial primary key,
  url text,
  url_md5 uuid unique,
  content text
);

create unique index cr3_md5 on cr3 (url_md5);

insert into cr3(url) (
  select repeat('Neon',1000) || generate_series(1,5000)
);

update cr3 set url_md5 = md5(url)::uuid; -- populating the hashes

SELECT pg_relation_size('cr3'),
    pg_indexes_size('cr3');

explain analyze
select * from cr3
where url_md5 = md5('lemons')::uuid;
```

### 1 hash vs btree

- smaller index, table space
- faster than btree
- only for exact match (=)
- dont use on pg9 wenta nazel

```sql
create table cr4(
  id serial primary key,
  url text,
  content text
);

create index cr4_hash on cr4 using hash (url);

insert into cr4(url) (
  select repeat('Neon',1000) || generate_series(1,5000)
);

SELECT pg_relation_size('cr4'),
    pg_indexes_size('cr4');

explain analyze
select * from cr4
where url = 'lemons';
```
