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