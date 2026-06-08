USE privbase;

DROP TABLE privbase.movie;

CREATE TABLE IF NOT EXISTS movie (
	name TEXT
);

INSERT INTO privbase.movie(name) VALUES ("Oldboy"), ("Shutter Island"), ("Top Gun"), ("A few good men"), ("Avatar");

SELECT * FROM privbase.movie;

SHOW GRANTS;
