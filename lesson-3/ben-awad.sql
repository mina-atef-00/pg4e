CREATE TABLE "posts" (
    "id" serial NOT NULL,
    "title" character varying(255) NOT NULL UNIQUE,
    "body" TEXT NOT NULL,
    CONSTRAINT posts_pk PRIMARY KEY ("id")
) WITH (OIDS = FALSE);

CREATE TABLE "tags" (
    "id" serial NOT NULL,
    "name" character varying(255) NOT NULL UNIQUE,
    CONSTRAINT tags_pk PRIMARY KEY ("id")
) WITH (OIDS = FALSE);

CREATE TABLE "posts_tags" (
    "postId" bigint NOT NULL,
    "tagId" bigint NOT NULL
) WITH (OIDS = FALSE);

ALTER TABLE "posts_tags"
ADD CONSTRAINT "posts_tags_fk0" FOREIGN KEY ("postId") REFERENCES "posts"("id");

ALTER TABLE "posts_tags"
ADD CONSTRAINT "posts_tags_fk1" FOREIGN KEY ("tagId") REFERENCES "tags"("id");

insert into tags
values (default, 'javascript');

insert into tags
values (default, 'java');

insert into tags
values (default, 'typescript');

insert into posts
values (default, 'hello world', 'stuff');

insert into posts
values (default, 'code splitting', 'stuff');

insert into posts
values (default, 'react hello world', 'stuff');

insert into posts
values (default, 'angular tutorial', 'stuff');

insert into posts
values (default, 'vue tutorial', 'stuff');

insert into posts
values (default, 'how to use spring', 'stuff');

insert into posts_tags
values (2, 8);

insert into posts_tags
values (2, 9);

insert into posts_tags
values (2, 10);

insert into posts_tags
values (3, 9);

insert into posts_tags
values (3, 10);

insert into posts_tags
values (4, 8);

insert into posts_tags
values (5, 9);

insert into posts_tags
values (6, 10);

select *
from posts p
    inner join posts_tags pt on p.id = pt."postId"
    inner join tags t on pt."tagId" = t.id
where p.id in (
        select p.id
        from posts p
            inner join posts_tags pt on p.id = pt."postId"
            inner join tags t on pt."tagId" = t.id
        where t.name in ('javascript', 'java')
    );

select p.*,
    string_agg(t.name, ', ') tags
from posts p
    inner join posts_tags pt on p.id = pt."postId"
    inner join tags t on pt."tagId" = t.id
group by p.id
having string_agg(t.name, '|') ilike '%javascript%';