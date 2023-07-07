USE employees;
-- 1. Create a new file named group_by_exercises.sql

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
-- (Answer: 7)

SELECT COUNT(DISTINCT title) FROM titles;
-- 3. Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.

SELECT last_name FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;
-- 4. Write a query to to find all unique combinations of first and last names of all employees whose 
-- last names start and end with 'E'.

SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY full_name;
-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. 
-- Include those names in a comment in your sql code.
-- (Answer: Chleq, Lindqvist, Qiwen)

SELECT last_name FROM employees
WHERE last_name LIKE '%Q%'
AND last_name NOT LIKE '%Qu%'
GROUP BY last_name;
-- 6. Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.

SELECT last_name, COUNT(*) FROM employees
WHERE last_name LIKE '%Q%'
AND last_name NOT LIKE '%Qu%'
GROUP BY last_name;
-- 7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and 
-- GROUP BY to find the number of employees with those names for each gender.

SELECT first_name, gender, COUNT(*) FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;
-- 8. Using your query that generates a username for all employees, generate a count of employees 
-- with each unique username.

SELECT LOWER(CONCAT(
SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)
)) AS username,COUNT(*) AS username_count FROM employees
GROUP BY username;
-- 9. From your previous query, are there any duplicate usernames? What is the highest number of times a username shows up? 
-- Bonus: How many duplicate usernames are there?
-- (Answer: Yes there are duplicates. The highest number of times a username shows up is 6.)

SELECT LOWER(CONCAT(
SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)
)) AS username,COUNT(*) AS username_count FROM employees
GROUP BY username
ORDER BY username_count DESC;

SELECT LOWER(CONCAT(
SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)
)) AS username,
COUNT(*) AS username_count FROM employees
GROUP BY username
HAVING username_count > 1;
