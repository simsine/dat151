USE oblig_4;

DROP PROCEDURE IF EXISTS takeSpace;

DROP TABLE IF EXISTS participant;
DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS participation;
DROP TABLE IF EXISTS temp;

-- 1)

CREATE TABLE IF NOT EXISTS event (
    eventId INT,
    eventTitle VARCHAR(30) NOT NULL,
    eventDate TIMESTAMP NOT NULL,
    totSpaces INT NOT NULL,
    bookedSpaces INT NOT NULL DEFAULT 0,
    PRIMARY KEY (eventId)
);

CREATE TABLE participant (
    pId INT,
    givenName VARCHAR(40),
    sureName VARCHAR(40),
    PRIMARY KEY (pId)
);

CREATE TABLE participation (
    pId INT,
    eventId INT,
    PRIMARY KEY (pId, eventId),
    FOREIGN KEY (pId) REFERENCES participant(pId),
    FOREIGN KEY (eventId) REFERENCES event(eventId)
);

CREATE TABLE temp (
    eventId INT,
    eventTitle VARCHAR(40) NOT NULL,
    eventDate TIMESTAMP NOT NULL,
    totSpaces INT NOT NULL,
    pId INT,
    givenName VARCHAR(40) NOT NULL,
    sureName VARCHAR(40) NOT NULL,
    PRIMARY KEY (eventId, pId)
);

LOAD DATA LOCAL INFILE '/home/simsine/Downloads/data.txt'
INTO TABLE temp fields TERMINATED BY ';';

INSERT INTO event(eventId, eventTitle, eventDate, totSpaces, bookedSpaces)
SELECT DISTINCT eventId, eventTitle, eventDate, totSpaces, COUNT(pid) AS bookedSpaces
FROM temp
GROUP BY eventId, eventTitle, eventDate, totSpaces;

INSERT INTO participant
SELECT DISTINCT pId, givenName, sureName
FROM temp;

INSERT INTO participation
SELECT DISTINCT pId, eventId
FROM temp;

SELECT * FROM event;
SELECT * FROM participant;
SELECT * FROM participation;

-- 2)

-- i)
SELECT MAX(event_count) AS max_events_attended
FROM (
    SELECT pId, COUNT(*) AS event_count
    FROM participation
    GROUP BY pId
) AS counts;

-- iv)
SELECT p.pId, MAX(p.givenName), MAX(p.sureName)
FROM participant p
JOIN participation pa ON p.pId = pa.pId
GROUP BY p.pId
HAVING COUNT(*) = 3;

-- 3)

CREATE PROCEDURE IF NOT EXISTS takeSpace(
    IN param_pId INT,
    IN param_eventId INT
)
BEGIN
    UPDATE event SET bookedSpaces = bookedSpaces + 1
    WHERE eventId = param_eventId AND bookedSpaces < totspaces;

    IF ROW_COUNT() = 1 THEN
       INSERT INTO participation(pId, eventId)
       VALUES (param_pId, param_eventId);
    END IF;
END;

-- 4)

SET profiling = 1;

DELETE FROM participation WHERE pId = 5;

CALL takeSpace(5, 11);

SELECT * FROM participation WHERE pId = 5;

SHOW PROFILES;
