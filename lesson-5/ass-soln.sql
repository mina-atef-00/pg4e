SELECT purpose
FROM taxdata
WHERE purpose ~ '[0-9]{4}$'
ORDER BY purpose DESC
LIMIT 4;