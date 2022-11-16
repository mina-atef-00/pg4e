INSERT INTO artist (name)
VALUES ('Led Zeppelin'),
    ('AC/DC');

INSERT INTO album (title, artist_id)
VALUES ('Who Made Who', 2),
    ('IV', 1);

INSERT INTO genre (name)
VALUES ('Rock'),
    ('Metal');

INSERT INTO track (
        title,
        rating,
        len,
        play_count,
        album_id,
        genre_id
    )
VALUES ('Black Dog', 5, 297, 0, 2, 1),
    ('Stairway', 5, 482, 0, 2, 1),
    ('About to Rock', 5, 313, 0, 1, 2),
    ('Who Made Who', 5, 207, 0, 1, 2);

SELECT track.title,
    artist.name,
    album.title,
    genre.name
FROM track
    JOIN genre ON track.genre_id = genre.id
    JOIN album ON track.album_id = album.id
    JOIN artist ON album.artist_id = artist.id;