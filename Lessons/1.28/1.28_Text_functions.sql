-- 1. LENGTH
SELECT LENGTH('Hello');

-- 2. COUNT
SELECT COUNT(*) FROM Students;

-- 3. UPPER
SELECT UPPER('hello');

-- 4. LOWER
SELECT LOWER('HELLO');

-- 5. SUBSTRING
SELECT SUBSTRING('DATABASE', 1, 4);

-- 6. CONCAT
SELECT CONCAT('SQL', ' ', 'Learning');

-- 7. CONCATENATION OPERATOR
SELECT 'SQL' || ' ' || 'Learning';

-- 8. TRIM
SELECT TRIM('  SQL  ');

-- 9. LTRIM
SELECT LTRIM('  SQL');

-- 10. RTRIM
SELECT RTRIM('SQL  ');

-- 11. REPLACE
SELECT REPLACE('I LIKE JAVA', 'JAVA', 'SQL');

--Final Example 
WITH title_lower AS(
    SELECT 
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)
SELECT 
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyat'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        ELSE 'Other '         
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 24;
-- NULLIF
SELECT NULLIF(33,33);
SELECT NULLIF(33,32);

SELECT 
    MEDIAN(NULLIF(salary_year_avg,0)),
    MEDIAN(NULLIF(salary_hour_avg,0))
FROM   
    job_postings_fact
WHERE  salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 12;

--COALESCE
SELECT COALESCE(NULL, NULL,23,4 );

SELECT 
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg,salary_hour_avg *2080)
FROM 
    job_postings_fact
WHERE   
    salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 15;

SELECT
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg,salary_hour_avg*2080) AS standardized_salary,
    CASE   
        WHEN COALESCE(salary_year_avg,salary_hour_avg*2080) IS NULL THEN 'MISSING'
        WHEN COALESCE(salary_year_avg,salary_hour_avg*2080) <75000 THEN 'Low'
        WHEN COALESCE(salary_year_avg,salary_hour_avg*2080) <150000 THEN 'Mid'
        ELSE 'High'
    END AS salary_bucket
FROM job_postings_fact
ORDER BY standardized_salary DESC;
