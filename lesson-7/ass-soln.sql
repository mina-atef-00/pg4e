EXPLAIN
SELECT id,
  doc
FROM docs03
WHERE '{complicated}' <@ string_to_array(lower(doc), ' ');

CREATE TABLE docs03 (id SERIAL, doc TEXT, PRIMARY KEY(id));

INSERT INTO docs03 (doc)
VALUES (
    'the problem to someone else or even to yourself you will sometimes'
  ),
  (
    'find the answer before you finish asking the question'
  ),
  (
    'But even the best debugging techniques will fail if there are too many'
  ),
  (
    'errors or if the code you are trying to fix is too big and complicated'
  ),
  (
    'Sometimes the best option is to retreat simplifying the program until'
  ),
  (
    'you get to something that works and that you understand'
  ),
  (
    'Beginning programmers are often reluctant to retreat because they cant'
  ),
  (
    'stand to delete a line of code even if its wrong If it makes you'
  ),
  (
    'feel better copy your program into another file before you start'
  ),
  (
    'stripping it down Then you can paste the pieces back in a little bit at'
  );

INSERT INTO docs03 (doc)
SELECT 'Neon ' || generate_series(10000, 20000);

create index array03 on docs03 using gin(string_to_array(lower(doc), ' ') array_ops);

SELECT id,
  doc
FROM docs03
WHERE to_tsquery('english', 'complicated') @@ to_tsvector('english', doc);

EXPLAIN
SELECT id,
  doc
FROM docs03
WHERE to_tsquery('english', 'complicated') @@ to_tsvector('english', doc);

CREATE TABLE docs03 (id SERIAL, doc TEXT, PRIMARY KEY(id));

CREATE INDEX fulltext03 ON docs03 USING gin(to_tsvector('english', doc));