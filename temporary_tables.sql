USE robinson_2284;

-- 1. Using the example from the lesson, create a temporary table called employees_with_departments 
-- that contains first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", 
-- it means that the query was attempting to write a new table to a database that you can only read.


CREATE TEMPORARY TABLE employees_with_departments AS 
SELECT first_name, last_name, dept_name 
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.dept_emp.to_date > NOW();
	-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths 
    -- of the first name and last name columns.
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);
	-- b. Update the table so that the full_name column contains the correct data.
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, last_name);
	-- c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;
	-- d. What is another way you could have ended up with this same table?
    -- ANSWER: Rather than adding the full_name column and then removing first and last, you could create it directly
    -- in the select statement of the original temp table creation.

-- 2. Create a temporary table based on the payment table from the sakila database. Write the SQL necessary to 
-- transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.

CREATE TEMPORARY TABLE sakila_payment AS 
	SELECT * FROM sakila.payment;

ALTER TABLE sakila_payment
MODIFY amount decimal(6,2);

UPDATE sakila_payment
SET amount = amount*100;
ALTER TABLE sakila_payment
MODIFY amount int;

-- 3. Go back to the employees database. Find out how the current average pay in each department 
-- compares to the overall current pay for everyone at the company. 
-- For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the 
-- best department right now to work for? The worst?

USE employees;

SELECT 
	AVG(salary)
FROM 
	salaries
JOIN dept_emp
	USING(emp_no)
JOIN departments
	USING(dept_no)
GROUP BY dept_name;
-- -- -- -- -- -- 
CREATE TEMPORARY TABLE metrics (
SELECT
	AVG(salary) AS overall,
    STDDEV(salary) AS stdv
FROM
	employees.salaries s
WHERE to_date > NOW());
-- -- -- -- 
CREATE TEMPORARY TABLE department_avg as (
SELECT
	dept_name AS Department,
    AVG(salary) AS dept_avg
FROM
	employees.departments d
JOIN employees.dept_emp de
	USING(dept_no)
JOIN employees.salaries s
	USING(emp_no)
WHERE
	de.to_date > NOW()
    AND
    s.to_date > NOW()
GROUP BY dept_name
);

ALTER TABLE department_avg
ADD zscore FLOAT;

ALTER TABLE department_avg
-- --
SELECT
	dept_name AS Department,
    AVG(salary) AS dept_avg
FROM
	departments d
JOIN dept_emp de
	USING(dept_no)
JOIN employees.salaries s
	USING(emp_no)
WHERE
	de.to_date > NOW()
    AND
    s.to_date > NOW()
GROUP BY dept_name;
-- -- 
    (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
	(SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
FROM salaries
JOIN dept_emp
	USING(emp_no)
JOIN departments
	USING(dept_no)
WHERE salaries.to_date > now()
GROUP BY dept_name, zscore;


    -- Returns the current z-scores for each salary
    -- Notice that there are 2 separate scalar subqueries involved
WITH 
	dep_avg AS (
		SELECT AVG(salary)
        FROM salaries
        WHERE salaries.to_date > NOW()
        JOIN dept_emp
			USING(emp_no)
		JOIN departments
			USING(dept_no)
		GROUP BY dept_name
)
SELECT 
	dept_name,
	(dep_avg.salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
	(SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
FROM salaries
JOIN dept_emp
	USING(emp_no)
JOIN departments
	USING(dept_no)
WHERE dept_emp.to_date > now()
GROUP BY dept_name;


















