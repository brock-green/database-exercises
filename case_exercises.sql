USE employees;

DESCRIBE departments;
-- pk (dept_no), dept_name
DESCRIBE dept_emp;
-- pk (emp_no), pk (dept_no), from_date, to_date
DESCRIBE dept_manager;
-- pk (emp_no), pk (dept_no), from_date, to_date
DESCRIBE employees;
-- pk (emp_no), birth_date, first_name, last_name, gender, hire_date
DESCRIBE salaries;
-- pk (emp_no), salary, pk (from_date), to_date
DESCRIBE titles;
-- pk (emp_no), pk (title), pk (from_date), to_date


-- 1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' 
-- that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.

SELECT 
	emp_no, 
    dept_no, 
    from_date AS start_date, 
    to_date as end_date, 
    IF(to_date > NOW(), True, False) AS is_current_employee
FROM 
	dept_emp;

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' 
-- that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT
	first_name,
    last_name,
    CASE last_name
		WHEN last_name LIKE 'A%' OR last_name LIKE 'B%' OR last_name LIKE 'C%' OR last_name LIKE 'D%' OR last_name LIKE 'E%' OR last_name LIKE 'F%' OR last_name LIKE 'G%' OR last_name LIKE 'H%' THEN 'A-H'
		WHEN last_name LIKE 'I%' OR last_name LIKE 'J%' OR last_name LIKE 'K%' OR last_name LIKE 'L%' OR last_name LIKE 'M%' OR last_name LIKE 'N%' OR last_name LIKE 'O%' OR last_name LIKE 'P%' OR last_name LIKE 'Q%' THEN 'I-Q'
        WHEN last_name LIKE 'R%' OR last_name LIKE 'S%' OR last_name LIKE 'T%' OR last_name LIKE 'U%' OR last_name LIKE 'V%' OR last_name LIKE 'W%' OR last_name LIKE 'X%' OR last_name LIKE 'Y%' OR last_name LIKE 'Z%' THEN 'R-Z'
        ELSE 0
	END AS alpha_group
FROM employees;

-- 3. How many employees (current or previous) were born in each decade?
-- 	ANSWER: 50's - 182886; 60's - 117138
SELECT
	count(*),
	CASE 
		WHEN birth_date LIKE '195%' THEN "50's"
        WHEN birth_date LIKE '196%' THEN "60's"
        ELSE birth_date
	END AS decade
FROM employees
GROUP BY decade;

-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
-- 67709.26, R&D
-- 86368.86, Sales & Marketing
-- 67328.50, Prod & QM
-- 71107.74, Finance & HR
-- 67285.23, Customer Service
SELECT
	ROUND(AVG(salary), 2)AS avg_salary,
	CASE 
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        WHEN dept_name = 'Customer Service' THEN 'Customer Service'
		ELSE dept_name
END AS dept_group
FROM salaries s
JOIN dept_emp de
	USING(emp_no)
JOIN departments d
	USING(dept_no)
WHERE de.to_date > NOW() AND s.to_date > NOW()
GROUP BY dept_group;
