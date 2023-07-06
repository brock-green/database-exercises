USE employees;

-- 2. 
SELECT DISTINCT last_name FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- 3. Alselm, Cappello; Utz, Mandell; Bouchung, Schreiter; Baocai, Kushner; Petter, Stroustrup)
SELECT * FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date
BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date ASC
LIMIT 5;

-- 4. Pranay, Narwekar; Marjo, Farrow; Ennio, Karcich; Dines, Lubachevsky; Ipke, Fontan. I have to use the LIMIT
-- to calculate how many rows to OFFSET. With 5 rows/page the 10th page would start on the 46th row. I need to
-- OFFSET 45 rows.
SELECT * FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date
BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date ASC
LIMIT 5 OFFSET 45;



