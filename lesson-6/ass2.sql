CREATE TABLE docs02 (id SERIAL, doc TEXT, PRIMARY KEY(id));

CREATE TABLE invert02 (
  keyword TEXT,
  doc_id INTEGER REFERENCES docs02(id) ON DELETE CASCADE
);

INSERT INTO docs02 (doc)
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

CREATE TABLE stop_words (word TEXT unique);

INSERT INTO stop_words (word)
VALUES ('i'),
  ('a'),
  ('about'),
  ('an'),
  ('are'),
  ('as'),
  ('at'),
  ('be'),
  ('by'),
  ('com'),
  ('for'),
  ('from'),
  ('how'),
  ('in'),
  ('is'),
  ('it'),
  ('of'),
  ('on'),
  ('or'),
  ('that'),
  ('the'),
  ('this'),
  ('to'),
  ('was'),
  ('what'),
  ('when'),
  ('where'),
  ('who'),
  ('will'),
  ('with');

insert into invert02 (keyword, doc_id)(
    select distinct S.keyword,
      D2.id
    from docs02 as D2,
      unnest(string_to_array(lower(D2.doc), ' ')) S (keyword)
    where S.keyword not in (
        select word
        from stop_words
      )
  );

SELECT keyword,
  doc_id
FROM invert02
ORDER BY keyword,
  doc_id
LIMIT 10;