USE oblig_4;

DROP TABLE IF EXISTS hero;
DROP TABLE IF EXISTS org;

CREATE TABLE IF NOT EXISTS org (
	id VARCHAR(3) PRIMARY KEY,
	name TEXT NOT NULL,
	leader TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS hero (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name TEXT NOT NULL,
	org_id VARCHAR(3) NOT NULL REFERENCES org(id)
);

INSERT INTO org(id, name, leader) VALUES
	('GLC', 'Green Lantern Corps', 'Hal Jordan'),
	('BAT', 'Batfamily', 'Batman')
;

INSERT INTO hero(name, org_id) VALUES
	('Batman', 'BAT'),
	('Dick Grayson', 'BAT'),
	('Jason Todd', 'BAT'),
	('Tim Drake', 'BAT'),
	('Hal Jordan', 'GLC'),
	('Aa', 'GLC'),
	('Brin', 'GLC'),
	('Galius Zed', 'GLC')
;

DELIMITER //

CREATE TRIGGER trg_pendant_delete
AFTER DELETE ON hero
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(id) FROM hero WHERE org_id = OLD.org_id) = 0 THEN
		DELETE FROM org WHERE id = OLD.org_id;
	END IF;
END//

DELIMITER ;

SELECT * FROM hero;
SELECT * FROM org;

DELETE FROM hero WHERE name = 'Batman';
DELETE FROM hero WHERE name = 'Dick Grayson';
DELETE FROM hero WHERE name = 'Jason Todd';
DELETE FROM hero WHERE name = 'Tim Drake';

SELECT * FROM hero;
SELECT * FROM org;