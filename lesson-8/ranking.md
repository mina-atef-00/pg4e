# RANKING SEARCH RESULTS

- just ranking how well the tsvector row matches the tsquery you made
- it isn't expensive, just a simple calculation

query:

```sql
SELECT id,
  subject,
  sender,
  ts_rank( -- the ranking starts here
    to_tsvector('english', body),
    to_tsquery('english', 'personal & learning')
  ) as ts_rank
FROM messages
WHERE to_tsquery('english', 'personal & learning') @@ to_tsvector('english', body) -- the actual matching
ORDER BY ts_rank DESC; -- ordering by the highest rank
```

result:

```md
id | subject | sender | ts_rank
--+----------------------------+----------------------------+----------
4 | re: lms/vle rants/comments | Michael.Feldstein@suny.edu | 0.282352
5 | re: lms/vle rants/comments | john@caret.cam.ac.uk | 0.09149
7 | re: lms/vle rants/comments | john@caret.cam.ac.uk | 0.09149
```

# OTHER TSQUERY STUFF

```sql
to_tsquery('english', 'learning & personal'); -- queries a line containing both learning AND personal
to_tsquery('english', 'learning | personal'); -- queries a line the either learning OR personal
to_tsquery('english', '! (learning & personal)'); -- queries a line NOT cataining both learning and personal
to_tsquery('english', 'learning <-> personal'); -- queries a line containing learning FOLLOWED BY personal
to_tsquery('english', 'learning <1> personal'); -- same as above, followed by personal after 1 word
to_tsquery('english', '! (learning <4> personal)'); -- not followed by personal after 4 words
to_tsquery('english', '! ((cat | brat) & (learning <4> personal))'); -- NOT ((cat or brat) and (learning followed by personal after 4 words))
palinto_tsquery('english', 'learning & $^^$% personal'); -- throws away chars the are not needed

```
