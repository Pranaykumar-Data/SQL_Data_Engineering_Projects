/*
-Question : What are the highest-paying skills for data engineers?
    -Calculate the median salary for each skill required in data engineer postions
    -Focus on remote postions with specified salaries 
    -include skill frequency to identify both salary and demand
    ----------------------------------------------------------------------------------
    Helps in identify which skills command the highest compensation while also showing 
    how common those skills are providing a more complete picture for skill development priorities.
    The MEDIAN is used insted of the average to reduce the impact of outkier salaries.  

*/


SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
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
HAVING 
    COUNT(jpf.*) >100
ORDER BY 
    median_salary DESC
LIMIT 20;

/*
Key Insights
1. Rust offers the highest median salary at $210,000 per year, making it the highest-paying skill in this analysis.
2. Golang and Terraform rank second at $184,000 each, combining high salaries with strong demand, especially Terraform with 3,248 job postings.
3. Specialized and modern technologies such as Neo4j, GraphQL, MongoDB, and FastAPI also offer attractive median salaries.
4. Salary and demand are not the same. Rust pays the most, but Terraform (3,248 postings) and FastAPI (204 postings) have very different demand levels.
5. These results apply specifically to remote Data Engineer jobs with more than 100 matching job postings per skill. Median salaries do not guarantee individual earnings.
Final Takeaway
For aspiring Data Engineers, focus on skills that balance salary potential with job-market demand.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ Demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ django     │      155000.0 │          265 │
│ bitbucket  │      155000.0 │          478 │
│ crystal    │      154224.0 │          129 │
│ atlassian  │      151500.0 │          249 │
│ c          │      151500.0 │          444 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ css        │      150000.0 │          262 │
│ airflow    │      150000.0 │         9996 │
│ node       │      150000.0 │          179 │
├────────────┴───────────────┴──────────────┤
│ 20 rows                         3 columns │
└───────────────────────────────────────────┘
*/