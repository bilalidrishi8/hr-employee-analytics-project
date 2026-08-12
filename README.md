# 👥 HR Employee Analytics Project

![SQL](https://img.shields.io/badge/SQL-Analysis-4169E1?style=for-the-badge\&logo=databricks\&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-336791?style=for-the-badge\&logo=postgresql\&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge\&logo=powerbi\&logoColor=black)
![Excel](https://img.shields.io/badge/Excel-Analytics-217346?style=for-the-badge\&logo=microsoft-excel\&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-Portfolio-181717?style=for-the-badge\&logo=github)

---

## 📌 Project Overview

The **HR Employee Analytics Project** is an end-to-end data analytics project designed to analyze employee information, workforce stability, experience, departments, and organizational performance.

The project uses **SQL** to transform employee data into meaningful HR insights and can be extended into an interactive **Power BI dashboard** for business reporting and decision-making.

The main focus is understanding **employee stability, department performance, workforce distribution, and employee experience**.

---

## 🎯 Project Objectives

* Analyze the overall employee workforce.
* Understand employee distribution across departments.
* Calculate employee stability percentages.
* Rank departments based on workforce stability.
* Identify the top departments by stability.
* Compare employee experience with department averages.
* Analyze employee and department-level performance.
* Generate HR-focused business insights.
* Build an interactive HR analytics dashboard.

---

## 📊 Key HR Analysis Areas

### 👥 Employee Analysis

* Total number of employees
* Employee distribution by department
* Employee experience analysis
* Stable vs unstable employees
* Employee-level performance analysis

### 🏢 Department Analysis

* Total employees by department
* Average experience by department
* Stable employees by department
* Department stability percentage
* Department stability ranking
* Top 3 departments by stability

### 📈 Experience Analysis

* Average employee experience
* Highest employee experience
* Lowest employee experience
* Employees above department average experience
* Experience comparison across departments

### 💼 Workforce Stability

* Stable employee count
* Unstable employee count
* Overall stability percentage
* Department-level stability percentage
* Department ranking by stability

---

## 🔍 Business Questions

### Beginner

1. What is the total number of employees?
2. How many employees are in each department?
3. What is the average employee experience?
4. What is the minimum employee experience?
5. What is the maximum employee experience?
6. How many stable and unstable employees are there?
7. What percentage of employees are stable?
8. Which department has the most employees?

### Intermediate

9. What is the average experience by department?
10. What is the stability percentage of each department?
11. Which department has the highest stability percentage?
12. Which department has the lowest stability percentage?
13. How many stable employees are in each department?
14. How many unstable employees are in each department?
15. Which employees have experience above the company average?
16. Which employees have experience above their department average?

### Advanced

17. Rank departments based on stability percentage.
18. Find the top 3 departments with the highest stability percentage.
19. Find employees whose experience is greater than their department average.
20. Calculate the percentage contribution of each department to total employees.
21. Rank employees based on experience.
22. Compare department average experience with overall average experience.
23. Identify departments with above-average employee stability.
24. Identify departments with below-average employee stability.
25. Create an HR summary report using multiple KPIs.

---

## 📈 Key KPIs

| KPI                           | Description                       |
| ----------------------------- | --------------------------------- |
| 👥 Total Employees            | Total number of employees         |
| 🏢 Total Departments          | Number of departments             |
| 📊 Average Experience         | Average employee experience       |
| ⭐ Stable Employees            | Number of stable employees        |
| ⚠️ Unstable Employees         | Number of unstable employees      |
| 📈 Stability %                | Percentage of stable employees    |
| 🏆 Top Department             | Department with highest stability |
| 👨‍💼 Avg Experience by Dept. | Average experience by department  |

---

## 🧮 Sample SQL Analysis

### Total Employees

```sql
SELECT
    COUNT(*) AS total_employees
FROM employees;
```

### Average Experience by Department

```sql
SELECT
    department,
    AVG(experience) AS avg_experience
FROM employees
GROUP BY department
ORDER BY avg_experience DESC;
```

### Department Stability Ranking

```sql
SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN stability = 'Stable' THEN 1
            ELSE 0
        END
    ) AS stable_employees,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN stability = 'Stable' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS stability_percentage
FROM employees
GROUP BY department
ORDER BY stability_percentage DESC;
```

### Top 3 Departments by Stability

```sql
SELECT
    department,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN stability = 'Stable' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS stability_percentage
FROM employees
GROUP BY department
ORDER BY stability_percentage DESC
LIMIT 3;
```

### Employees Above Department Average

```sql
SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    e.experience
FROM employees e
WHERE e.experience >
(
    SELECT AVG(e2.experience)
    FROM employees e2
    WHERE e2.department = e.department
)
ORDER BY e.department, e.experience DESC;
```

---

## 🛠️ Technologies Used

* **SQL**
* **PostgreSQL**
* **pgAdmin**
* **Microsoft Excel**
* **Power BI**
* **DAX**
* **Power Query**
* **Git & GitHub**

---

## 📊 Power BI Dashboard

### Page 1 — HR Executive Overview

**KPI Cards**

* Total Employees
* Total Departments
* Average Experience
* Stable Employees
* Stability %
* Unstable Employees

**Visuals**

* Employees by Department
* Stability Distribution
* Average Experience by Department
* Department Stability Ranking

### Page 2 — Employee Analytics

* Employee Experience Distribution
* Employees by Department
* Stable vs Unstable Employees
* Employee Experience Ranking
* Employee Details Table

### Page 3 — Department Analytics

* Department Employee Count
* Average Experience by Department
* Stability Percentage by Department
* Top 3 Departments
* Department Ranking

---

## 📂 Repository Structure

```text
hr-employee-analytics-project/
│
├── Dataset/
│   └── employees.csv
│
├── SQL/
│   ├── 01_Create_Table.sql
│   ├── 02_Data_Exploration.sql
│   ├── 03_Beginner_Queries.sql
│   ├── 04_Intermediate_Queries.sql
│   ├── 05_Advanced_Queries.sql
│   └── 06_Business_Insights.sql
│
├── PowerBI/
│   └── HR_Employee_Analytics.pbix
│
├── Excel/
│   └── HR_Employee_Analytics.xlsx
│
├── README.md
└── LICENSE
```

---

## 🚀 Project Workflow

```text
Employee Dataset
       ↓
Data Cleaning
       ↓
PostgreSQL Database
       ↓
SQL Data Exploration
       ↓
Business Questions
       ↓
Advanced SQL Analysis
       ↓
HR Insights
       ↓
Power Query
       ↓
DAX Measures
       ↓
Power BI Dashboard
       ↓
HR Decision-Making Insights
```

---

## 🎓 Skills Demonstrated

* SQL Data Analysis
* PostgreSQL
* Data Cleaning
* Data Aggregation
* GROUP BY & HAVING
* CASE Statements
* Subqueries
* CTEs
* Window Functions
* Ranking
* HR Analytics
* KPI Development
* Power BI
* DAX
* Power Query
* Data Visualization
* Business Intelligence

---

## 💡 Key Insights

This project helps organizations understand:

* Workforce distribution
* Employee stability
* Department performance
* Experience levels
* Workforce concentration
* Department-level stability
* High-experience employees
* HR performance indicators

---

## 🔮 Future Enhancements

* Employee attrition prediction
* Employee satisfaction analysis
* Salary analysis
* Hiring trend analysis
* Workforce forecasting
* Employee performance dashboard
* Python-based HR analytics
* Machine learning attrition prediction

---

## 👨‍💻 Author

**Md Bilal**

**Aspiring Data Analyst | SQL | Excel | Power BI | Data Analytics**

---

## ⭐ Project Highlight

> **Turning employee data into actionable workforce insights using SQL, Excel, and Power BI.**

If you find this project useful, consider giving the repository a ⭐ **Star**.

---

**Built with SQL • PostgreSQL • Excel • Power BI • DAX • GitHub**
