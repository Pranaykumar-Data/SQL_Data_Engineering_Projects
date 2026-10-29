SELECT 
    job_id,
    job_title_short,
    salary_year_avg,
    company_id
FROM
    job_postings_fact
LIMIT 14;

SELECT 
    *
FROM
    company_dim 
WHERE
    name IN ('Facebook', 'Meta');

SELECT 
    *
FROM 
    skills_job_dim
LIMIT 4;

SELECT 
    *
FROM 
    skills_dim
LIMIT 5;

SELECT 
    table_name, column_name, data_type
FROM
    information_schema.columns
WHERE 
    table_catalog = 'data_jobs';


SELECT *
FROM information_schema.tables
WHERE 
    table_catalog = 'data_jobs';

SELECT *
FROM information_schema.tables_constraints
WHERE 
    table_catalog = 'data_jobs';


PRAGMA show_tables_expanded;  -- to inspect the meta of the table use PRAGMA and table name

DESCRIBE job_postings_fact;   -- It discribes the table given in command


