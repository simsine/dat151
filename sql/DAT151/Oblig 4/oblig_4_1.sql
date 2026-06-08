use oblig_4;

-- DROP TABLES BEFORE RECREATING
DROP TABLE IF EXISTS TheTable;
DROP TABLE IF EXISTS LogTable;

-- DDL FOR TABLES
CREATE TABLE IF NOT EXISTS TheTable (
	element_symbol VARCHAR(2) PRIMARY KEY,
	element_name TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS LogTable (
	id INT AUTO_INCREMENT PRIMARY KEY,
	action ENUM('DELETE', 'INSERT', 'UPDATE') NOT NULL,
	run_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	before_element_symbol TEXT,
	after_element_symbol TEXT,
	before_element_name TEXT,
	after_element_name TEXT
);

-- DDL FOR TRIGGERS

-- TRIGGER ON INSERT
CREATE TRIGGER IF NOT EXISTS log_insert_TheTable
AFTER INSERT ON TheTable
FOR EACH ROW
INSERT INTO LogTable VALUES
	(NULL, 'INSERT', NOW(), NULL, NEW.element_symbol, NULL, NEW.element_name)
;

-- TRIGGER ON DELETE
CREATE TRIGGER IF NOT EXISTS log_delete_TheTable
AFTER DELETE ON TheTable
FOR EACH ROW
INSERT INTO LogTable VALUES
	(NULL, 'DELETE', NOW(), OLD.element_symbol, NULL, OLD.element_symbol, NULL)
;

-- TRIGGER ON UPDATE
CREATE TRIGGER IF NOT EXISTS log_update_TheTable
AFTER UPDATE ON TheTable
FOR EACH ROW
INSERT INTO LogTable VALUES
	(NULL, 'UPDATE', NOW(), OLD.element_symbol, NEW.element_symbol, OLD.element_name, NEW.element_name)
;

-- TESTING THE TRIGGERS
INSERT INTO TheTable VALUES
	('H', 'Hydrogen')
;
UPDATE TheTable SET element_symbol = 'He', element_name = 'Helium' WHERE element_symbol = 'H';
DELETE FROM TheTable WHERE element_symbol = 'He';

-- SHOW DATA LOGGED BY TRIGGERS
SELECT * FROM LogTable;
