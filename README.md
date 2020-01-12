# Employee Database Analysis
_By: Nick Rosing_

## Entity Relationship Diagram
![ERD](https://github.com/nwrosing/SQL-Challenge/blob/master/Images/ERD.PNG)

### Data Engineering
- Database and Table Creation
  - Data imported from CSV Files
```
DROP TABLE  IF EXISTS departments;
DROP TABLE  IF EXISTS dept_emp;
DROP TABLE  IF EXISTS dept_manager;
DROP TABLE  IF EXISTS employees;
DROP TABLE  IF EXISTS salaries;
DROP TABLE  IF EXISTS titles;

-- Create Tables
CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "GENDER" CHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "titles" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
```
## Data Analysis

```
-- Question 1 (All Employee Data)
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees e
INNER JOIN salaries s ON
e.emp_no=s.emp_no
ORDER BY emp_no
;

-- Question 2 (All Employees hired in 1986)
SELECT * FROM employees
WHERE EXTRACT(year FROM hire_date) = 1986;

-- Question 3 (Manager Information)
SELECT dep.dept_no, dep.dept_name, man.emp_no, 
		emp.last_name, emp.first_name, man.from_date, man.to_date
FROM departments dep
JOIN dept_manager man ON dep.dept_no = man.dept_no
JOIN employees emp ON man.emp_no = emp.emp_no
ORDER BY dept_no
;

-- Question 4 (Employee-Department Info)
SELECT dept_emp.emp_no, emp.last_name, emp.first_name, dep.dept_name
FROM dept_emp
JOIN employees emp ON dept_emp.emp_no = emp.emp_no
JOIN departments dep ON dept_emp.dept_no = dep.dept_no
ORDER BY emp_no
;

-- Question 5 (All Employees Named "Hercules B...")
SELECT first_name, last_name 
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'
;

-- Question 6 (Sales Department)
SELECT dept_emp.emp_no, emp.last_name, emp.first_name, dep.dept_name
FROM dept_emp
JOIN employees emp ON dept_emp.emp_no = emp.emp_no
JOIN departments dep ON dept_emp.dept_no = dep.dept_no
WHERE dept_name = 'Sales'
;

-- Question 7 (Sales and Development)
SELECT dept_emp.emp_no, emp.last_name, emp.first_name, dep.dept_name
FROM dept_emp
JOIN employees emp ON dept_emp.emp_no = emp.emp_no
JOIN departments dep ON dept_emp.dept_no = dep.dept_no
WHERE dept_name = 'Sales'
OR dept_name = 'Development'
;

-- Question 8 (Last Name Frequency)
SELECT last_name, COUNT(last_name) AS "Count of Name"
FROM employees
GROUP BY last_name
ORDER BY "Count of Name" DESC
;
```
## Bonus

![AVGSAL](https://github.com/nwrosing/SQL-Challenge/blob/master/Images/avg_salary.png)
