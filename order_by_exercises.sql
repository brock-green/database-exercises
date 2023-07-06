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















