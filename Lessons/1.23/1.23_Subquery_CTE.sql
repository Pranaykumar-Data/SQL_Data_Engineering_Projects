-- SubQuery

SELECT *
FROM (
    SELECT *
    FROM data_jobs.job_postings_fact
    WHERE 
        salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)
LIMIT 10;

--CTE 
WITH valid_salaries AS(
    SELECT *
    FROM data_jobs.job_postings_fact
    WHERE 
        salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)
SELECT *
FROM valid_salaries
LIMIT 10;

-- Scenario 1 - Subquery in 'SELECT'
-- Show each job's salary next to overall market median:
SELECT 
    job_title_short,
    salary_year_avg,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM data_jobs.job_postings_fact
    )AS market_median_salary
FROM data_jobs.job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;


-- Scenario 2 - Subquery in 'FROM'
-- Stage only jobs that are remote before aggregating to determaine the remote median salary per job :
SELECT 
    job_title_short,
    MEDIAN(salary_year_avg),
    (
        SELECT MEDIAN(salary_year_avg)
        FROM data_jobs.job_postings_fact
        WHERE job_work_from_home = TRUE
    )AS market_remote_median_salary
FROM (
    SELECT 
        job_title_short,
        salary_year_avg
    FROM data_jobs.job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs
GROUP BY job_title_short
LIMIT 10;

-- Scenario 3 - Subquery in 'Having'
-- Keep only job titles whose median salary is above the overall median:
SELECT 
    job_title_short,
    MEDIAN(salary_year_avg),
    (
        SELECT MEDIAN(salary_year_avg)
        FROM data_jobs.job_postings_fact
        WHERE job_work_from_home = TRUE
    )AS market_remote_median_salary
FROM (
    SELECT 
        job_title_short,
        salary_year_avg
    FROM data_jobs.job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > (
    SELECT MEDIAN(salary_year_avg)
    FROM data_jobs.job_postings_fact
    WHERE job_work_from_home = TRUE
)
LIMIT 10;

--- CTE Example
--- Compare how much more(or less) remote roles pay compared to onsite roles for each job title.
--- Use a CTE to Calculate the median salary by title and wok arranagement, then compare those medians.

WITH title_median AS(
    SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg):: INT AS median_salary
    FROM data_jobs.job_postings_fact
    WHERE 
        job_country = 'India'
    GROUP BY 
        job_title_short,
        job_work_from_home
)

SELECT 
    r.job_title_short,
    r.median_salary AS remote_median_salary,
    o.median_salary AS onsite_median_salary,
    (r.median_salary - o.median_salary) AS remote_premium
FROM title_median AS r
INNER JOIN title_median AS o
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
    AND o.job_work_from_home = FALSE
ORDER BY 
    remote_premium DESC;

--- Practice on WHERE EXISTS and NOT EXISTS 
SELECT *
FROM RANGE(4) AS src(Key)
WHERE EXISTS (
    SELECT 1
    FROM RANGE(2) AS tgt(Key)
    WHERE tgt.Key = src.Key
);

SELECT *
FROM RANGE(4) AS src(Key)
WHERE NOT EXISTS (
    SELECT 1
    FROM RANGE(2) AS tgt(Key)
    WHERE tgt.Key = src.Key
);

--- Identify job postings that have no associated skills before loading them into a data mart
SELECT *
FROM job_postings_fact
ORDER BY job_id
LIMIT 12;

SELECT *
FROM skills_job_dim
ORDER BY job_id
LIMIT 12;

SELECT *
FROM job_postings_fact AS jpf
WHERE NOT EXISTS(
    SELECT 1
    FROM skills_job_dim AS sjd
    WHERE jpf.job_id = sjd.job_id
)
ORDER BY job_id
LIMIT 12;