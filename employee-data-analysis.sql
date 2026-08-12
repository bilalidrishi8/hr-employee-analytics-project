CREATE TABLE employees (
    emp_status VARCHAR(30),
    emp_id VARCHAR(30) PRIMARY KEY,
    name VARCHAR(100),
    date_of_joining TEXT,
    date_of_relieving DATE,
    emp_type VARCHAR(50),
    category VARCHAR(20),
    date_of_birth DATE,
    marital_status VARCHAR(30),
    grade VARCHAR(50),
    department VARCHAR(100),
    total_experience NUMERIC(5,1),
    year INT,
    month VARCHAR(15),
    stability VARCHAR(30)
);

SELECT * FROM employees

--1. Department and Employee Status
--Find the number of employees for each department and employee status combination.
SELECT * FROM employees

SELECT department,
emp_status,
COUNT(*) AS total_employees
FROM employees
GROUP BY emp_status, department
ORDER BY department, total_employees DESC 

--2. Average Experience by Department
--Calculate the average total experience for each department.
SELECT * FROM employees

SELECT department,
ROUND(AVG(total_experience), 2) AS average_department
FROM employees
GROUP BY department
ORDER BY average_department DESC 

--3. Average Experience by Grade
--Find the average experience for each employee grade.
SELECT * FROM employees

SELECT
    grade,
    ROUND(AVG(total_experience), 2) AS avg_experience
FROM employees
GROUP BY grade
ORDER BY avg_experience DESC;

--4. Top 5 Departments by Employee Count
--Find the top 5 departments with the highest number of employees.
SELECT * FROM employees

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department
ORDER BY employee_count DESC
LIMIT 5;

--5. Employees by Joining Year
--Calculate the number of employees who joined in each year.
SELECT * FROM employees

SELECT
    EXTRACT(YEAR FROM date_of_joining) AS joining_year,
    COUNT(*) AS employee_count
FROM employees
WHERE date_of_joining IS NOT NULL
GROUP BY EXTRACT(YEAR FROM date_of_joining)
ORDER BY joining_year;

--6. Monthly Joining Trend
--Calculate the number of employees joining in each month.
SELECT * FROM employees

SELECT
    EXTRACT(MONTH FROM date_of_joining)::INT AS month_number,
    TO_CHAR(date_of_joining, 'Month') AS month_name,
    COUNT(*) AS employee_count
FROM employees
WHERE date_of_joining IS NOT NULL
GROUP BY
    EXTRACT(MONTH FROM date_of_joining),
    TO_CHAR(date_of_joining, 'Month')
ORDER BY month_number;

--7. Employee Stability Analysis
--Find the number and percentage of employees in each stability category.
SELECT * FROM employees

SELECT
    stability,
    COUNT(*) AS employee_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS employee_percentage
FROM employees
GROUP BY stability
ORDER BY employee_count DESC;

--8. Experience Categories
--Categorize employees based on experience:
'0–2 years      → Beginner
3–5 years      → Intermediate
6–10 years     → Experienced
10+ years      → Highly Experienced'

SELECT * FROM employees

SELECT
    emp_id,
    name,
    department,
    total_experience,
    CASE
        WHEN total_experience BETWEEN 0 AND 2
            THEN 'Beginner'

        WHEN total_experience BETWEEN 3 AND 5
            THEN 'Intermediate'

        WHEN total_experience BETWEEN 6 AND 10
            THEN 'Experienced'

        WHEN total_experience > 10
            THEN 'Highly Experienced'

        ELSE 'Unknown'
    END AS experience_category
FROM employees
ORDER BY total_experience DESC;

--9. Department Stability Ranking
--Rank departments based on their percentage of stable employees.
SELECT * FROM employees

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
        SUM(
            CASE
                WHEN stability = 'Stable' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS stability_percentage,
    RANK() OVER (
        ORDER BY
            SUM(
                CASE
                    WHEN stability = 'Stable' THEN 1
                    ELSE 0
                END
            ) * 100.0 / COUNT(*) DESC
    ) AS stability_rank
FROM employees
GROUP BY department
ORDER BY stability_rank;

--10. Top 3 Departments by Stability
--Find the top 3 departments with the highest stability percentage.
SELECT * FROM employees

WITH department_stability AS (
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
            SUM(
                CASE
                    WHEN stability = 'Stable' THEN 1
                    ELSE 0
                END
            ) * 100.0 / COUNT(*),
            2
        ) AS stability_percentage
    FROM employees
    GROUP BY department
),

ranked_departments AS (
    SELECT
        department,
        total_employees,
        stable_employees,
        stability_percentage,
        RANK() OVER (
            ORDER BY stability_percentage DESC
        ) AS stability_rank
    FROM department_stability
)

SELECT
    department,
    total_employees,
    stable_employees,
    stability_percentage,
    stability_rank
FROM ranked_departments
WHERE stability_rank <= 3
ORDER BY stability_rank;


--11. Employees Above Department Average
--Find employees whose experience is greater than the average experience of their own department.
SELECT * FROM employees

SELECT
    emp_id,
    name,
    department,
    total_experience
FROM employees e
WHERE total_experience >
(
    SELECT AVG(e2.total_experience)
    FROM employees e2
    WHERE e2.department = e.department
)
ORDER BY department, total_experience DESC;

--12. Department vs Company Average
--Find departments whose average employee experience is higher than the overall company average.
SELECT * FROM employees

SELECT
    department,
    ROUND(AVG(total_experience), 2) AS department_avg_experience
FROM employees
GROUP BY department
HAVING AVG(total_experience) >
       (
           SELECT AVG(total_experience)
           FROM employees
       )
ORDER BY department_avg_experience DESC;

--13. Department Hiring Trend
--Calculate yearly employee hiring for each department and compare it with the previous year.
SELECT * FROM employees

WITH yearly_hiring AS (
    SELECT
        department,
        EXTRACT(YEAR FROM date_of_joining)::INT AS joining_year,
        COUNT(*) AS employees_hired
    FROM employees
    WHERE date_of_joining IS NOT NULL
    GROUP BY
        department,
        EXTRACT(YEAR FROM date_of_joining)
),

hiring_comparison AS (
    SELECT
        department,
        joining_year,
        employees_hired,
        LAG(employees_hired) OVER (
            PARTITION BY department
            ORDER BY joining_year
        ) AS previous_year_hiring
    FROM yearly_hiring
)

SELECT
    department,
    joining_year,
    employees_hired,
    previous_year_hiring,
    employees_hired - COALESCE(previous_year_hiring, 0)
        AS hiring_difference,
    ROUND(
        (
            (employees_hired - previous_year_hiring) * 100.0
            / NULLIF(previous_year_hiring, 0)
        ),
        2
    ) AS hiring_growth_percentage
FROM hiring_comparison
ORDER BY department, joining_year;

--14. Grade-wise Employee Distribution
--Calculate the percentage contribution of each grade to total employees.
SELECT * FROM employees

SELECT
    grade,
    COUNT(*) AS employee_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS employee_percentage
FROM employees
GROUP BY grade
ORDER BY employee_percentage DESC;

--15. Department with Lowest Average Experience
--Find the department with the lowest average employee experience.
SELECT * FROM employees

SELECT
    department,
    ROUND(AVG(total_experience), 2) AS avg_experience
FROM employees
GROUP BY department
ORDER BY avg_experience
LIMIT 1;

--16. Department Hiring Trend
--Calculate yearly employee hiring for each department and compare it with the previous year.

SELECT
    department,
    DATE_TRUNC('month', date_of_joining)::DATE AS joining_month,
    COUNT(*) AS employees_hired
FROM employees
WHERE date_of_joining IS NOT NULL
GROUP BY
    department,
    DATE_TRUNC('month', date_of_joining)
ORDER BY
    department,
    joining_month;