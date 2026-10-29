/*
    Qusetion: What are the most in demand skills for data engineers?
        * Identify the top 10 in demand skills for data engineers
        * Focus on remote job postings
        -- Retrives the top 10 skills with the highest demand in the remote job market, providing insights into the most valuable skills for data enginners seeking remote work
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS Demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd    
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
GROUP BY 
    sd.skills
ORDER BY 
    Demand_count DESC
LIMIT 8;

/*

---> The most Demanded Skills for Data Engineers:
    --SQL , Python , AWS , ASURE , SPARK , AIRFLOW , SNOWFLAKE , DATABRICKS
    In this Skills SQL and Python are most in demand skills with around 29,000 job postings each 
    The Cloud platforms round out the top skills, AWS is at the top with ~18,000 postings , followed by Azure at 14,000.
    Apache Spark completes at top 5 with nearly 13,000 postings.


    The KEY Takeawys are:
    --SQL and Python remain the foundational skills for data engineers
    --Cloud platforms (AWS, Azure) are critical for modern data engineering
    --BIG Data tools like Spark continue to be high valued skill
    --Data Pipeline tools (Airfolw, snowflake, Databricks) shows increasing in demand.
┌────────────┬──────────────┐
│   skills   │ Demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
└────────────┴──────────────┘
*/