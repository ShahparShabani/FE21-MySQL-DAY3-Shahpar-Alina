-- 1. Report:
--  How many rows do we have in each table in the employees database?
SELECT COUNT(*) as No_departments
FROM `departments`;
-- No_departments->9

SELECT COUNT(*) as No_dept_emp
FROM `dept_emp`;
-- No_dept_emp - > 331603

SELECT COUNT(*) as No_dept_manager
FROM `dept_manager`;
-- No_dept_manager->24

SELECT COUNT(*) as No_employees
FROM `employees`;
-- No_employees->300024

SELECT COUNT(*) as No_salaries
FROM `salaries`;
-- No_salaries->2844047

SELECT COUNT(*) as No_titles
FROM `titles`;


-- No_titles->443308 -- 2. Report:
-- How many employees with the first name "Mark" do we have in our company?
SELECT COUNT(*) as No_FName_Mark
FROM `employees`
WHERE first_name like 'Mark';


-- No_FName_Mark->230 -- 3. Report:
-- How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?
SELECT COUNT(*) as No_Name_Eric_A_
FROM `employees`
WHERE first_name like 'Eric'
    AND last_name like 'A%';


-- No_Name_Eric_A_->13 --  4. Report:
--  How many employees do we have that are working for us since 1985 and who are they?
SELECT COUNT(*) as No_Employees_1985
FROM `employees`
WHERE `hire_date` >= 1985;
SELECT COUNT(*) as No_Employees_1985
FROM `employees`
WHERE `hire_date` >= '1985-00-00';
-- No_Employees_1985->300024

SELECT *
FROM `employees`
WHERE `hire_date` >= 1985;


--  5. Report:
--  How many employees got hired from 1990 until 1997 and who are they?
SELECT COUNT(*)
FROM `employees`
WHERE `hire_date` BETWEEN '1990-00-00' AND '1997-12-31';
-- COUNT->129545

SELECT *
FROM `employees`
WHERE `hire_date` BETWEEN '1990-00-00' AND '1997-00-00';



--  6. Report:
--  How many employees have salaries higher than EUR 70 000,00 and who are they? 
SELECT COUNT(*)
FROM `employees`
WHERE `emp_no` IN (
        SELECT emp_no
        FROM `salaries`
        WHERE `salary` > 70000
    );
-- Count->135631

SELECT *
FROM `employees`
WHERE `emp_no` IN (
        SELECT emp_no
        FROM `salaries`
        WHERE `salary` > 70000
    );


--  7. Report:
--  How many employees do we have in the Research Department, who are working for us since 1992 and who are they?
-- TIP: You can use the CURRENT_DATE() FUNCTION to access today's date
SELECT COUNT(*)
FROM `employees`
WHERE `hire_date` BETWEEN '1992-00-00' AND CURRENT_DATE()
    AND emp_no IN (
        SELECT emp_no
        FROM `dept_emp`
        WHERE dept_no = 'd008'
    );
SELECT COUNT(*)
FROM `employees`
WHERE `hire_date` BETWEEN '1992-00-00' AND CURRENT_DATE()
    AND emp_no IN (
        SELECT emp_no
        FROM `dept_emp`
        WHERE dept_no IN (
                SELECT departments.dept_no
                FROM departments
                WHERE departments.dept_name = 'Research'
            )
    );
-- COunt -->6145


SELECT *
FROM `employees`
WHERE `hire_date` BETWEEN '1992-00-00' AND CURRENT_DATE()
    AND emp_no IN (
        SELECT emp_no
        FROM `dept_emp`
        WHERE dept_no = 'd007'
    );

-- How many employees do we have in the Research Department
SELECT *
FROM `employees`
WHERE emp_no IN (
        SELECT emp_no
        FROM `dept_emp`
        WHERE dept_no = 'd007'
    );



--  8. Report:
--  How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?
SELECT COUNT(*)
FROM `employees`
WHERE (
        `hire_date` BETWEEN '1985-00-00' AND CURRENT_DATE()
    )
    AND emp_no IN (
        SELECT emp_no
        FROM `dept_emp`
        WHERE dept_no IN (
                SELECT departments.dept_no
                FROM departments
                WHERE departments.dept_name = 'Finance'
            )
    )
    AND emp_no IN (
        SELECT emp_no
        FROM `salaries`
        WHERE `salary` > 75000
    ) 
    -- Count->8948 
    
    
    --  9. Report:
    --  We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary.
    ----------------------
SELECT first_name,
    last_name,
    birth_date,
    gender,
    hire_date,
    titles.title as title,
    salaries.salary as salary
FROM `employees`
    INNER JOIN titles on employees.emp_no = titles.emp_no
    INNER JOIN salaries on employees.emp_no = salaries.emp_no
WHERE employees.emp_no NOT IN (
        SELECT emp_no
        FROM `dept_emp`
        WHERE dept_emp.to_date < CURRENT_DATE
    )
GROUP By employees.emp_no;
------------
SELECT (employees.emp_no),
(employees.first_name),
(employees.last_name),
(employees.birth_date),
(employees.gender),
(employees.hire_date),
(titles.title),
(salaries.salary)
FROM employees
    JOIN titles ON titles.emp_no = employees.emp_no
    JOIN salaries ON salaries.emp_no = employees.emp_no
    join dept_emp on dept_emp.emp_no = employees.emp_no
WHERE dept_emp.to_date >= CURRENT_DATE()
group by employees.emp_no;
-----------
--  Best solution
SELECT (employees.emp_no),
(employees.first_name),
(employees.last_name),
(employees.birth_date),
(employees.gender),
(employees.hire_date),
(titles.title),
(salaries.salary)
FROM employees
    JOIN titles ON titles.emp_no = employees.emp_no
    JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE salaries.to_date >= CURRENT_DATE()
group by employees.emp_no;
-- Alina->240124 
-- Shahpar->214916


-- 10. Report:
--  We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.
SELECT (employees.emp_no),
(employees.first_name),
(employees.last_name),
(employees.birth_date),
(employees.gender),
(employees.hire_date),
(titles.title),
(salaries.salary),
(departments.dept_name)
FROM employees
    join titles ON titles.emp_no = employees.emp_no
    join salaries ON salaries.emp_no = employees.emp_no
    join dept_emp on dept_emp.emp_no = employees.emp_no
    join departments on departments.dept_no = dept_emp.dept_no
    join dept_manager on dept_manager.emp_no = employees.emp_no
WHERE dept_emp.to_date >= CURRENT_DATE()
group by employees.emp_no 


--  Bonus query:
    --   Create a query that will join all tables and show all data from all tables.


    
    --  Next step:
    --  Now you should create at least 5 queries on your own, try to use data from more than 2 tables.
    -- Employees who are still working for us
SELECT first_name,
    last_name,
    birth_date,
    gender,
    hire_date
FROM `employees`
WHERE `emp_no` NOT IN (
        SELECT emp_no
        FROM `dept_emp`
        WHERE dept_emp.to_date <= CURRENT_DATE
    );
SELECT COUNT(*)
FROM `employees`
WHERE `emp_no` NOT IN (
        SELECT emp_no
        FROM `dept_emp`
        WHERE dept_emp.to_date <= CURRENT_DATE
    );
-- Count->214916

SELECT first_name,
    last_name,
    birth_date,
    gender,
    hire_date,
    title
FROM `employees`
    LEFT JOIN titles on employees.emp_no = titles.emp_no
WHERE employees.emp_no NOT IN (
        SELECT emp_no
        FROM `dept_emp`
        WHERE dept_emp.to_date <= CURRENT_DATE
    );