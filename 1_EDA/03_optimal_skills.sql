/*
    Question: What are the most optimal skills for data engineers-balancing both demand
              and salary?

        . Create a ranking column that combines demand count and median salary to identify
            the most valuable skills.

        . Focus only on remote Data Engineer positions with specified annual salaries.

    o This approach highlights skills that balance market demand and financial reward.
        It weights core skills appropriately, rather than letting rare, outlier skills distort the results.
*/


SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)),1) AS ln_demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))/1_000_000,2) AS Optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd    
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOt NULL
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) >100
ORDER BY 
    Optimal_score DESC
LIMIT 20;

/*

Key Insights
1. Terraform ranks first overall, with an optimal score of 0.97 and a median salary of $184,000. However, its demand count (193) is lower than Python and SQL.
2. Python and SQL have the strongest demand in this table, with 1,133 and 1,128 job postings, respectively. They are essential foundational skills for many Data Engineering roles.
3. Cloud skills are valuable. AWS has a median salary of $137,320 and an optimal score of 0.91, while Azure scores 0.79.
4. Data processing and orchestration skills offer strong opportunities. Airflow has a median salary of $150,000, while Spark offers $140,000.
5. Kubernetes pays well but has lower demand here. Its median salary is $150,500, but only 147 postings match the skill.
6. A high optimal score does not necessarily mean the highest salary or demand. It reflects the scoring formula used in your analysis, so its interpretation depends on how that formula was calculated.


┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ Optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │          193 │             5.3 │          0.97 │
│ python     │      135000.0 │         1133 │             7.0 │          0.95 │
│ sql        │      130000.0 │         1128 │             7.0 │          0.91 │
│ aws        │      137320.0 │          783 │             6.7 │          0.91 │
│ airflow    │      150000.0 │          386 │             6.0 │          0.89 │
│ spark      │      140000.0 │          503 │             6.2 │          0.87 │
│ snowflake  │      135500.0 │          438 │             6.1 │          0.82 │
│ kafka      │      145000.0 │          292 │             5.7 │          0.82 │
│ azure      │      128000.0 │          475 │             6.2 │          0.79 │
│ java       │      135000.0 │          303 │             5.7 │          0.77 │
│ scala      │      137290.0 │          247 │             5.5 │          0.76 │
│ git        │      140000.0 │          208 │             5.3 │          0.75 │
│ kubernetes │      150500.0 │          147 │             5.0 │          0.75 │
│ databricks │      132750.0 │          266 │             5.6 │          0.74 │
│ redshift   │      130000.0 │          274 │             5.6 │          0.73 │
│ gcp        │      136000.0 │          196 │             5.3 │          0.72 │
│ nosql      │      134415.0 │          193 │             5.3 │          0.71 │
│ hadoop     │      135000.0 │          198 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │          152 │             5.0 │           0.7 │
│ mongodb    │      135750.0 │          136 │             4.9 │          0.67 │
├────────────┴───────────────┴──────────────┴─────────────────┴───────────────┤
│ 20 rows                                                           5 columns │
└─────────────────────────────────────────────────────────────────────────────┘
*/