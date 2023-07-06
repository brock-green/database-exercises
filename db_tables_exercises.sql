SHOW DATABASES;

USE albums_db;
SELECT database();
SHOW TABLES;

USE employees;
SELECT database();
SHOW TABLES;
DESCRIBE departments;
SELECT * FROM dept_emp;
-- Which table(s) do you think contain a numeric type column?(Write this question and your answer in a comment)
-- dept_emp, dept_manager, employees, salaries, titles

-- Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
-- Departments, dept_emp. dept_manager, employees, titles

-- Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
-- dept_manager, dept_emp, employees, salaries, titles

-- What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
-- the employees and departments tables are related through the dept_emp table. This ties to the employees with the emp_no column and the 
-- department through the dept_no column.
SHOW CREATE TABLE dept_manager;