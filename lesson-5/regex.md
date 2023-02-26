# REGULAR EXPRESSIONS

## quick regex guide

- `^` beginning
- `$` end
- `.` any one char (like \_ in sql)
- `*` 0 or more of anything (greedy)
- `*?` non greedy version
- `+` one or more (greedy)
- `+?` non greedy version
- `[aeiou]` matches any char in the brackets (in this case any vowel) (**just one char is matched**)
- `[^aeiou]` matches any char _not_ in the brackets (constants) (**just one char is matched**)
- `[a-z0-9]` the `-` is like range. in this case any letter and any number (**just one char is matched**)
- `()` you want to extract just a part of the string being matched. `www.([a-z0-9/-]*).com` >> matches the domain name inside a url

## WHERE clause regex operator in sql

- it implicitly searches the whole field unlike LIKE where you need `%%`

- `~` matches regex, case sensitive
- `~*` matches regex, case **in**sensitive
- `!~` doesn't matche regex, case sensitive
- `!~*` doesn't matche regex, case **in**sensitive

```sql
create table em (id serial primary key, email text);

insert into em (email)
values ('monaa@asdf.com'),
    ('monaa@asdf3.com'),
    ('monaa@asdf7.com'),
    ('monaa@asdf5.com'),
    ('monaa@asdf3.com');

-- get me an email where after the @ symbol, has 'asdf' and a number, but doesn't have the number range from 4 to 7, case insensitve
select email
from em
where email !~* '^monaa@([asdf4-7])*.com$';

-- get me an email that contains a number, then extract the domain name after the @ sign from
select distinct substring(
        email
        from '.+@(.*)$'
    )
from em
where email ~ '[0-9]';

select substring(
        email
        from '.+@(.*)$'
    ) as email_domain,
    count(*) as count
from em
group by email_domain
having count(*) < 3;
```

## Multiple regex matches

- you want to get all the matches not the first match like the where operators
- `regexp_matches()` gets a column with all the matches

```sql
create table tw (id serial, tweet text);

alter table tw
add constraint id_prime_key primary key (id);

insert into tw
values (default, 'this is #sql and #fun');

insert into tw
values (default, 'this is #sql man #umsi');

insert into tw
values (default, '#umsi is the best in #python');

select tweet from tw;

select id,
    regexp_matches(tweet, '#([A-Za-z0-9_]+)', 'g')
from tw;
```
