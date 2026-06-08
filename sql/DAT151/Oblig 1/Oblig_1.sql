use oblig_1;

CREATE TABLE oblig_1.inno (name TEXT);

ALTER TABLE oblig_1.inno ENGINE=MyISAM;

SHOW INDEX FROM inno;

CREATE TABLE IF NOT EXISTS movie (
	name TEXT
);

INSERT INTO oblig_1.movie(name) VALUES ("Oldboy"), ("Shutter Island"), ("Top Gun"), ("A few good men"), ("Avatar");

CREATE UNIQUE INDEX IF NOT EXISTS movie_name ON movie(name);

SHOW INDEX FROM oblig_1.movie;

ANALYZE TABLE oblig_1.movie PERSISTENT FOR ALL;

CHECK TABLE oblig_1.movie EXTENDED;

REPAIR TABLE oblig_1.movie QUICK;

OPTIMIZE TABLE oblig_1.inno;

CHECKSUM TABLE oblig_1.movie EXTENDED;

SELECT * FROM oblig_1.movie;
