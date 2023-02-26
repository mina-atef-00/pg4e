# GENERATE DATA FUNCTIONS

## random()

- use `random()` to generate (horizontal) numbers in a row
- gets you a floating point num < 1

```sql
select
  random(),
  random(),
  trunc(random()*100); -- makes the number 2 digits
```

## repeat()

- it repeats text (horizontal)
- `repeat('some text bla bla',<number_of_times_you_want_to_repeat>)`

```sql
select repeat('Yo wassup? ',5);
```

## generate_series()

- it **vertically** generates numbers, creates rows like a range() in python
- `generate_series(num_from,num_to_that_included_unlike_range)`

```sql
select generate_series(1,5);
```

## concatenation

- `||` concatenates strings
- `'bruh '||'man'` -> 'bruh man'

```sql
select 'https://www.google.com/' || trunc(random() * 1000000) || repeat('Monna', 6) || generate_series(6, 9);
```
