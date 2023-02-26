CREATE TABLE bigtext(content TEXT);

INSERT INTO bigtext (
        select 'This is record number ' || generate_series(100000, 199999) || ' of quite a few text records.'
    );

SELECT *
from bigtext
LIMIT 4;

SELECT *
from bigtext
ORDER BY content DESC
LIMIT 4;