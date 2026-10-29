
# Exploratory Data Analysis with SQL: Data Engineer Job Market

![EDA Project Overview](/Images\1_1_Project1_EDA.png)

## Project Overview

In this project, I analyzed real-world job posting data to understand the Data Engineer job market using SQL.

The main goal was to find:
- Which skills are most in demand
- Which skills have the highest salaries
- Which skills provide a good balance between salary and demand

I used SQL queries to analyze the data and find useful insights about the skills needed for Data Engineering jobs.

---

## Executive Summary

In this project, I worked on 3 SQL queries to analyze the Data Engineer job market.

- **Project scope:** Created 3 SQL queries to analyze job demand, salaries, and skill value.
- **Data analysis:** Used joins to connect different tables and get the required information.
- **SQL concepts:** Used filtering, grouping, aggregation, sorting, and mathematical functions.
- **Results:** Identified important skills such as Python, SQL, cloud platforms, and data engineering tools.

### Project Queries

1. [Top Demanded Skills](./01_top_demanded_skills.sql)
2. [Top Paying Skills](./02_top_paying_skills.sql)
3. [Optimal Skills](./03_optimal_skills.sql)

---

## Problem and Context

I wanted to understand the current job market for Data Engineers and identify the skills that are useful for getting a Data Engineering job.

The main questions I explored were:

- **Most in-demand skills:** Which skills appear most frequently in Data Engineer job postings?
- **Highest-paying skills:** Which skills have the highest median salaries?
- **Best skills to learn:** Which skills provide a good balance between salary and job demand?

To answer these questions, I analyzed job posting data using SQL.

### Data Warehouse

The project uses a data warehouse based on a star schema design.

![Data Warehouse Schema](/Images\1_2_Data_Warehouse.png)

The main tables used in this project are:

- **Fact Table:** `job_postings_fact` - Contains job posting details such as job titles, locations, salaries, and dates.
- **Company Dimension:** `company_dim` - Contains company information.
- **Skills Dimension:** `skills_dim` - Contains skill names and types.
- **Bridge Table:** `skills_job_dim` - Connects job postings with their required skills.

I used these tables to analyze skill demand, salary patterns, and the skills that are valuable for Data Engineering jobs.

---

## Tech Stack

- **Query Engine:** DuckDB
- **Language:** SQL
- **Data Model:** Star Schema
- **Development Tool:** VS Code
- **Terminal:** DuckDB CLI
- **Version Control:** Git and GitHub

---

## Repository Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql
├── 02_top_paying_skills.sql
├── 03_optimal_skills.sql
└── READIT.md
```

---

## Analysis Overview

### 1. Top Demanded Skills

[01_top_demanded_skills.sql](./01_top_demanded_skills.sql)

This query identifies the most in-demand skills for Data Engineer jobs.

I used SQL joins, filtering, grouping, and counting to find the skills that appear most frequently in job postings.

### 2. Top Paying Skills

[02_top_paying_skills.sql](./02_top_paying_skills.sql)

This query analyzes the highest-paying skills for Data Engineer jobs.

I used median salary and job posting counts to compare salaries and understand the demand for different skills.

### 3. Optimal Skills

[03_optimal_skills.sql](./03_optimal_skills.sql)

This query combines salary and job demand to identify skills that provide a good balance between compensation and demand.

I used the natural logarithm of job demand and median salary to calculate an optimal score.

---

## Key Insights

- **Programming languages:** Python and SQL are among the most demanded skills for Data Engineers.
- **Cloud platforms:** AWS and Azure are important skills in Data Engineering job postings.
- **Infrastructure tools:** Kubernetes, Docker, and Terraform are useful tools for working with cloud infrastructure.
- **Big Data tools:** Apache Spark is a valuable skill for processing large amounts of data.
- **Data orchestration:** Airflow is useful for managing and scheduling data pipelines.
- **Salary and demand:** Some skills offer higher salaries, while others have more job postings.

### Top Skills by Optimal Score

Based on my analysis:

| Skill | Optimal Score | Median Salary | Demand Count |
|---|---:|---:|---:|
| Terraform | 0.97 | $184,000 | 193 |
| Python | 0.95 | $135,000 | 1,133 |
| SQL | 0.91 | $130,000 | 1,128 |
| AWS | 0.91 | $137,320 | 783 |
| Airflow | 0.89 | $150,000 | 386 |

### Final Takeaway

Python and SQL are good starting points because they have strong demand in the job market.

Cloud technologies such as AWS and tools such as Airflow, Spark, and Terraform can help build additional Data Engineering skills.

The main takeaway from this project is that choosing skills based on both salary and demand can help identify useful skills for a Data Engineering career.

---

## SQL Skills Demonstrated

### Query Design

- **Joins:** Used `INNER JOIN` to connect job postings, skills, and skill details.
- **Aggregations:** Used `COUNT()`, `MEDIAN()`, and `ROUND()` to analyze job postings and salaries.
- **Filtering:** Used `WHERE` conditions to filter job titles, remote jobs, and salary information.
- **Grouping:** Used `GROUP BY` to analyze each skill separately.
- **Sorting:** Used `ORDER BY` to arrange results based on salary and demand.
- **Limiting results:** Used `LIMIT` to display the top skills.

### Data Analysis Techniques

- **Grouping:** Grouped job postings by skill.
- **Mathematical functions:** Used `LN()` to calculate the natural logarithm of job demand.
- **Calculated metrics:** Combined salary and demand to calculate an optimal score.
- **HAVING clause:** Filtered skills based on the number of job postings.
- **NULL handling:** Used `IS NOT NULL` to exclude missing salary values.

---

## Conclusion

This project helped me practice SQL and understand how to analyze real-world job posting data.

By working on these queries, I learned how to use joins, aggregations, filtering, and mathematical functions to answer questions about the Data Engineer job market.

The analysis also helped me understand the importance of Python, SQL, cloud platforms, and data engineering tools when preparing for a Data Engineering career.
