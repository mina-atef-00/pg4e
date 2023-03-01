CREATE TABLE docs01 (id SERIAL, doc TEXT, PRIMARY KEY(id));

CREATE TABLE invert01 (
  keyword TEXT,
  doc_id INTEGER REFERENCES docs01(id) ON DELETE CASCADE
);

INSERT INTO docs01 (doc)
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

SELECT *
from docs01;

----------------------------------------------------------
insert into invert01 (keyword, doc_id)(
    select distinct S.keyword,
      D1.id
    from docs01 as D1,
      unnest(string_to_array(lower(D1.doc), ' ')) S (keyword)
  );

select *
from invert01;