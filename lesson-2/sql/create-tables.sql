CREATE DATABASE music WITH OWNER 'mina' ENCODING 'UTF8';

CREATE TABLE artist(
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    -- ? indexing that field too
    -- ! LOGICAL KEY
    PRIMARY KEY(id)
);

CREATE TABLE album(
    id SERIAL,
    title VARCHAR(256) UNIQUE,
    -- ! LOGICAL KEY
    artist_id INTEGER REFERENCES artist(id) ON DELETE CASCADE,
    -- ? foreign key action
    PRIMARY KEY(id)
);

CREATE TABLE genre(
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE track(
    id SERIAL,
    title VARCHAR(256),
    -- ! don't make it unique, you can have many songs of the same name some where else
    len INTEGER,
    rating INTEGER,
    play_count INTEGER,
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES genre(id) ON DELETE CASCADE,
    UNIQUE(title, album_id),
    -- ! IMPORTANT
    -- ? the combination of the track title & album is unique
    -- ? you can't have 2 same titles on the same album
    -- ? we don't want the track to be part of 2 albums, will be a faster index
    PRIMARY KEY(id)
);