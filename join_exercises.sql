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

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows 
-- each department along with the name of the current manager for that department.

SELECT 
	dept_name AS 'Department Name', 
    CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM 
	dept_manager
JOIN 
	employees 
	USING (emp_no)
JOIN 
	departments
	USING (dept_no)
WHERE dept_manager.to_date > NOW()
ORDER BY dept_name;

-- 3. Find the name of all departments currently managed by women.

SELECT 
	dept_name AS 'Department Name', 
    CONCAT(first_name, ' ', last_name) AS 'Manager Name'
FROM 
	dept_manager
JOIN employees 
	USING (emp_no)
JOIN departments
	USING (dept_no)
WHERE dept_manager.to_date > NOW() AND gender = 'f'
ORDER BY dept_name;

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT 
	title AS Title, 
    count(*) AS Count
FROM 
	titles
JOIN employees 
	USING (emp_no)
JOIN dept_emp
	USING (emp_no)
JOIN departments
	USING (dept_no)
WHERE titles.to_date > NOW() AND dept_name = 'Customer Service'
GROUP BY title
ORDER BY title;

-- 5. Find the current salary of all current managers.

SELECT 
	dept_name AS 'Department Name', 
    CONCAT(first_name, ' ', last_name) AS 'Name', 
    salary AS 'Salary'
FROM 
	dept_manager
JOIN employees 
	ON dept_manager.emp_no = employees.emp_no
JOIN departments
	ON departments.dept_no = dept_manager.dept_no
JOIN salaries
	ON salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date > NOW() AND salaries.to_date > NOW()
ORDER BY dept_name;

-- 6. Find the number of current employees in each department.

SELECT 
	departments.dept_no, 
    dept_name, 
    COUNT(*) AS num_employees
FROM 
	departments
JOIN dept_emp
	ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > NOW()
GROUP BY dept_name
ORDER BY dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT 
	dept_name, 
    AVG(salary) AS 'average_salary'
FROM 
	departments
JOIN dept_emp
	USING (dept_no)
JOIN salaries
	USING (emp_no)
WHERE 
	salaries.to_date > NOW()
    AND dept_emp.to_date > NOW()
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?

SELECT 
	first_name, 
    last_name
FROM employees
JOIN salaries
	USING (emp_no)
JOIN dept_emp
	USING (emp_no)
JOIN departments
	USING (dept_no)
WHERE dept_name = 'Marketing'
ORDER BY salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?

SELECT 
	first_name, 
    last_name, 
    salary, 
    dept_name
FROM 
	employees
JOIN salaries
	ON salaries.emp_no = employees.emp_no
JOIN dept_manager
	ON dept_manager.emp_no = employees.emp_no
JOIN departments
	ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > NOW()
ORDER BY salary DESC
LIMIT 1;

-- 10. Determine the average salary for each department. Use all salary information and round your results.

SELECT 
	dept_name, 
    ROUND(AVG(salary)) AS average_salary
FROM 
	departments
JOIN dept_emp
	USING (dept_no)
JOIN salaries
	USING (emp_no)
GROUP BY dept_name
ORDER BY average_salary DESC;
