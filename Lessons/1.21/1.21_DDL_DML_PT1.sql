-- .read Lessons\1.21\1.21_DDL_DML_PT1.sql

CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

--DROP DATABASE IF EXISTS jobs_mart;

SELECT *
FROM information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

--DROP SCHEMA IF EXISTS staging;


CREATE TABLE IF NOT EXISTS staging.preferred_roles (
	role_id INT PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL,
    role_description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
--DROP TABLE IF EXISTS staging.preferred_roles;
SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart' AND table_schema = 'staging';

--DROP TABLE IF EXISTS staging.preferred_roles;

INSERT INTO staging.preferred_roles (role_id, role_name, role_description)
VALUES
   (1, 'Data Engineer', 'Responsible for designing, building, and maintaining data pipelines and infrastructure.'),
   (2, 'Senior Data Engineer', 'Lead data engineer responsible for designing and implementing large-scale data solutions.'),
   (3, 'software Engineer', 'Develops and maintains software applications, ensuring they meet user requirements and are scalable.');



ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role Boolean;

ALTER TABLE staging.preferred_roles
DROP COLUMN created_at;


UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id IN (1, 2);


UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id IN (3);

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INT;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = (3);

SELECT  *
FROM staging.priority_roles;