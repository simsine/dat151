use oblig_4;

DROP TABLE IF EXISTS Teacher;

-- DDL FOR TEACHER TABLE
CREATE TABLE IF NOT EXISTS Teacher (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name TEXT NOT NULL,
	salary INT NOT NULL CHECK(salary >= 1000 AND salary <= 100000),
	bonus INT NOT NULL,
	total INT AS (salary + bonus) STORED
);

-- TESTING THE CONSTRAINTS
INSERT INTO Teacher (name, salary, bonus) VALUES
	('Bob', 50000, 3000)
;

-- CHECKING RESULTS
SELECT id, name, salary, bonus, total FROM Teacher;
