USE employees;
Describe employees;

-- 1. 102000, 10397, 10610
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- 2. 10200, 10397, 10610. It matches the previous
SELECT * FROM employees 
WHERE first_name = 'Irena' OR  first_name = 'Vidya' OR first_name = 'Maya';

-- 3. 10200, 10397, 10821
SELECT * FROM employees 
WHERE (first_name = 'Irena' OR  first_name = 'Vidya' OR first_name = 'Maya')
AND
gender = 'M';

-- 4.
SELECT DISTINCT last_name FROM employees 
WHERE last_name LIKE 'E%';

-- 5.
SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE 'E%' 
OR last_name LIKE '%E';

-- 6.
SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE '%E'
AND
last_name NOT LIKE 'E%';

-- 7. 
SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE 'E%E';

-- 8. 10008, 10011, 10012
SELECT * FROM employees 
WHERE hire_date BETWEEN ('1990-01-01') AND ('1999-12-31');

-- 9. 10078, 10115, 10261
SELECT * FROM employees
WHERE birth_date LIKE '%-12-25';

-- 10. 10261, 10438, 10681
SELECT * FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date
BETWEEN '1990-01-01' AND '1999-12-31';

-- 11. 
SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE '%Q%';

-- 12. 
SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE '%Q%'
AND last_name NOT LIKE '%Qu%';

-- Start of Order By Exercises:

-- 2. First Row (Irena, Reutenauer); Last Row (Vidya, Simmen)
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- 3. First Row (Irena, Acton); Last Row (Vidya, Zweizig)
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- 4. First Row (Irena, Acton); Last Row (Maya, Zyda)
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- 5. 899 employees returned. First Row (10021 Ramzi, Erde); Last Row (499648 Tadahiro, Erde)
SELECT COUNT(emp_no) FROM employees
WHERE last_name LIKE 'E%E';
SELECT * FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no;

-- 6. 899 employees returned. Newest (Teiji, Eldridge); Oldest (Sergi, Erde)
SELECT COUNT(emp_no) FROM employees
WHERE last_name LIKE 'E%E';
SELECT * FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY hire_date DESC;

-- 7. 362 employees returned. Oldest employee hired last is Khun, Bernini; Douadi, Pettis)
-- Youngest employee hired first is 
SELECT * FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY birth_date ASC, hire_date DESC;
SELECT COUNT(emp_no) FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date
BETWEEN '1990-01-01' AND '1999-12-31';

-- START of FUNCTIONS exercises -- 

-- 1. order_by_exercises copied as functions_exercises.sql

-- 2. Write a query to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees
WHERE last_name LIKE 'E%E';

-- 3. Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name FROM employees
WHERE last_name LIKE 'E%E';

-- 4. Use a function to determine how many results were returned from your previous query.
SELECT COUNT(UPPER(CONCAT(first_name, ' ', last_name))) FROM employees
WHERE last_name LIKE 'E%E';

-- 5. Find all employees hired in the 90s and born on Christmas. 
-- Use datediff() function to find how many days they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE())

SELECT  emp_no, CONCAT(first_name, ' ', last_name) AS full_name, datediff(CURDATE(), hire_date) AS days_employeed FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date
BETWEEN '1990-01-01' AND '1999-12-31';

-- 6. Find the smallest and largest current salary from the salaries table. Smallest-38623, Largest-158220
SELECT MIN(salary) AS smallest, MAX(salary) AS largest FROM salaries;

-- 7. Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, the month the employee was born, 
-- and the last two digits of the year that they were born. Below is an example of what the 
-- first 10 rows will look like:

SELECT LOWER(CONCAT(
SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)
)) AS username, first_name, last_name, birth_date FROM employees;

