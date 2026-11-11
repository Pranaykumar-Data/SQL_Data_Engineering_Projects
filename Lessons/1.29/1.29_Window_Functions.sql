--Count Rows - Aggregation Only
SELECT
    COUNT(*)
FROM 
    job_postings_fact;

--Count Rows - Window functions
SELECT  
    job_id,
    COUNT(*) OVER()
FROM 
    job_postings_fact;

-- PARTITION BY - Find hourly salary
SELECT 
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short, company_id
    )
FROM 
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL 
ORDER BY RANDOM()
LIMIT 15;

-- ORDER bY - Ranking hourly salary
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        ORDER BY salary_hour_avg DESC
    )AS rank_hourly_salary
FROM 
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL 
--ORDER BY 
--  salary_hour_avg DESC
LIMIT 15;

-- PARTITION BY & ORDER BY - Running AVG hourly salary
SELECT 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL 
    AND job_title_short = 'Data Engineer'
ORDER BY 
    job_title_short,
    job_posted_date
LIMIT 15;
-- PARTITITON BY & ORDER bY - Ranking by job_title_short
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        PARTITION BY job_title_short
        ORDER BY salary_hour_avg DESC
    )AS Ranking_job_title_salary
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL 
ORDER BY 
    salary_hour_avg DESC,
    job_title_short
LIMIT 15;
-- Ranking Functions - Rank() Vs DENSE_RANK
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    --DENSE_RANK - not skips to direct to last it shows next number 
    RANK() OVER (
        ORDER BY salary_hour_avg DESC
    )AS rank_hourly_salary
FROM 
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL 
--ORDER BY 
--  salary_hour_avg DESC
LIMIT 15;

--ROW_NUMBE() - Providing a new job_id
SELECT 
    *,
    ROW_NUMBER() OVER(
        ORDER BY job_posted_date
    )
FROM 
    job_postings_fact
ORDER BY 
    job_posted_date
LIMIT 14;
-- Navigation Funtions
-- LAG() - Time Based comparision of Company Yearly Salary
-- LEAD() as works same but opposite
SELECT 
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LAG(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS previous_posting_salary,
    salary_year_avg - LAG(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change
FROM   
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
ORDER BY 
    company_id,job_posted_date
LIMIT 40;