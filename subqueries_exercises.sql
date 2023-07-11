USE employees;
SHOW TABLES;
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

-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) 'Full Name'
FROM employees
JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.to_date > NOW()
AND employees.hire_date = (
	SELECT employees.hire_date
	FROM employees
    WHERE employees.emp_no = 101010
    );
-- 		ANSWER: First 5 (Shigeo Kaiserswerth, Akemi Iwayama, Emran Laventhal, Wayne Schoegge, Zeljko Baik)

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT
	DISTINCT title
FROM
	titles
WHERE
	emp_no IN (
		SELECT 
			e.emp_no
		FROM employees e 
		JOIN dept_emp de
			ON de.emp_no = e.emp_no
			AND de.to_date > NOW()
		WHERE first_name = 'Aamod'
    );


-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT 
	COUNT(*)
FROM employees e
WHERE emp_no NOT IN (
	SELECT 
		emp_no
    FROM 
		dept_emp
    WHERE to_date > NOW()
    );
-- 		ANSWER: 59900

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
SELECT 
	CONCAT(first_name, ' ', last_name) 'Full Name'
FROM employees
WHERE emp_no IN (
	SELECT emp_no
    FROM dept_manager
    WHERE to_date > NOW()
    )
AND gender = 'F';
-- 		ANSWER: Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT 
	CONCAT(first_name, ' ', last_name) 'Employee'
FROM employees
WHERE emp_no IN (
	SELECT emp_no
    FROM salaries
    WHERE salary > (
		SELECT 
        AVG(salary)
        FROM salaries
)
	AND to_date > NOW()
    );

-- 		ANSWER: First 5(Georgi Facello, Bezalel Simmel, Chirstian Koblick, Kyoichi Maliniak, Tzvetan Zielinski)

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?


SELECT
	COUNT(*)
FROM salaries
WHERE salaries.to_date > NOW()
AND salary >= (
	SELECT MAX(salary) - STDDEV(salary) one_dev
	FROM salaries s
	WHERE s.to_date > NOW());
-- CTE Approach --
WITH cur_sals AS (
SELECT salary
FROM salaries
WHERE salaries.to_date> NOW()),
metrics AS (
SELECT MAX(salary) max_sal, STDDEV(salary) one_dev
FROM salaries s
WHERE s.to_date > NOW()
)
SELECT COUNT(*)
FROM cur_sals
WHERE cur_sals.salary BETWEEN (SELECT max_sal - one_dev FROM metrics) AND
(SELECT max_sal FROM metrics);

-- Percentage --

SELECT	(	SELECT COUNT(*)
		FROM salaries
		WHERE salaries.to_date > NOW()
		AND salary >= (
		SELECT MAX(salary) - STDDEV(salary) one_dev
		FROM salaries s
		WHERE s.to_date > NOW())
    
    ) 
    /
	(
		SELECT 
			COUNT(*)
        FROM
			salaries
		WHERE
			salaries.to_date > NOW()
    ) * 100;
    

