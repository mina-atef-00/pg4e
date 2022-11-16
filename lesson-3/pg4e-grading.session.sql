--? Grading
SELECT track.title AS title,
    album.title AS album,
    artist.name AS artist
FROM track
    JOIN album ON track.album_id = album.id
    JOIN tracktoartist ON track.id = tracktoartist.track_id
    JOIN artist ON tracktoartist.artist_id = artist.id
ORDER BY track.title
LIMIT 3;

--? Creating tables
DROP TABLE album CASCADE;

CREATE TABLE album (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE track CASCADE;

CREATE TABLE track (
    id SERIAL,
    title TEXT,
    artist TEXT,
    album TEXT,
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
    count INTEGER,
    rating INTEGER,
    len INTEGER,
    PRIMARY KEY(id)
);

DROP TABLE artist CASCADE;

CREATE TABLE artist (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE tracktoartist CASCADE;

CREATE TABLE tracktoartist (
    id SERIAL,
    track VARCHAR(128),
    track_id INTEGER REFERENCES track(id) ON DELETE CASCADE,
    artist VARCHAR(128),
    artist_id INTEGER REFERENCES artist(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);

-- \copy track(title,artist,album,count,rating,len) FROM 'library.csv' WITH DELIMITER ',' CSV;
SELECT *
from track;

--? Populating other tables
INSERT INTO album (title) (
        SELECT DISTINCT album
        FROM track
    );

UPDATE track
SET album_id = (
        SELECT album.id
        FROM album
        WHERE album.title = track.album
    );

SELECT *
from album;

INSERT INTO tracktoartist (track, artist) (
        SELECT DISTINCT title,
            artist
        from track
    );

SELECT *
from tracktoartist;

INSERT INTO artist (name)(
        SELECT DISTINCT artist
        from tracktoartist
    );

SELECT *
from artist;

UPDATE tracktoartist
SET track_id = (
        select track.id
        from track
        where tracktoartist.track = track.title
    );

UPDATE tracktoartist
SET artist_id = (
        select artist.id
        from artist
        where artist.name = tracktoartist.artist
    );

--? Remove text columns
ALTER TABLE track DROP COLUMN album;

ALTER TABLE track drop column artist;

ALTER TABLE tracktoartist DROP COLUMN track;

ALTER TABLE tracktoartist drop column artist;