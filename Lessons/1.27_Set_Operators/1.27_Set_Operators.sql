--UNION
SELECT UNNEST([1,23,4,211,11,23,21,1])
UNION 
SELECT UNNEST([1,2,3,44,21,1,12,4]);
--INTERSECT
SELECT UNNEST([1,23,4,211,11,23,21,1])
INTERSECT ALL
SELECT UNNEST([1,2,3,44,21,1,12,4]);
--EXCEPT
SELECT UNNEST([1,23,4,211,11,23,21,1])
EXCEPT 
SELECT UNNEST([1,2,3,44,21,1,12,4]);

--Example
CREATE TEMP TABLE jobs_2023 AS 
SELECT  
    * EXCLUDE (job_id, job_posted_date)
FROM
    job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * 
FROM jobs_2023;

CREATE TEMP TABLE jobs_2024 AS 
SELECT  
    * EXCLUDE (job_id, job_posted_date)
FROM
    job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date) = 2024;

SELECT *
FROm jobs_2024;

-- Which unique job_postings appearedd in either 2023 or 2024?
SELECT
    'jobs_2023' AS table_name,
    COUNT(*) AS Record_count
FROM jobs_2023
UNION 
SELECT 
    'jobs_2024' AS table_name,
    COUNT(*) AS Record_count
FROM jobs_2024;
SELECT *  FROM jobs_2023;
UNION
SELECT * FROM jobs_2024;

--Which job postings appeared across both years, counting duplicates?

SELECT * 
FROM jobs_2023
UNION ALL
SELECT * 
FROM jobs_2024;
-- Which job_postings appeared in 2023 but not in 2024?
SELECT * 
FROM jobs_2023
EXCEPT
SELECT * 
FROM jobs_2024;

--Which job_postings from 2023 remain after subtracting matching 2024 postings , one-for-one?
SELECT * 
FROM jobs_2023
EXCEPT ALL
SELECT * 
FROM jobs_2024;

--Which job_postings appeared in both 2023 and 2024?
SELECT * 
FROM jobs_2023
INTERSECT
SELECT * 
FROM jobs_2024;
--Which job_postings appeared in both 2023 and 2024 , preserving duplicate count?
SELECT * 
FROM jobs_2023
INTERSECT ALL
SELECT * 
FROM jobs_2024;