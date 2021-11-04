/*1. How many rows do we have in each table in the employees database? */

SELECT COUNT(*) FROM employees;
/*  output */
300024


/* 2. How many employees with the first name "Mark" do we have in our company? */

SELECT COUNT(first_name) FROM `employees` WHERE first_name='Mark';
/* output */
230

/* 3. How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company? */

SELECT COUNT(emp_no) FROM `employees` WHERE first_name='Eric' AND last_name LIKE'A%';

/* output */
13

/* 4.  How many employees do we have that are working for us since 1985 and who are they? */

SELECT first_name, hire_date from employees WHERE hire_date > '1985-01-01';
SELECT COUNT(emp_no) from employees WHERE hire_date > '1985-01-01';

/* 5.  How many employees got hired from 1990 until 1997 and who are they? */

SELECT COUNT(emp_no) from employees WHERE hire_date BETWEEN '1990-01-01' AND '1997-12-31';
/* output */
129545

/* 6. How many employees have salaries higher than EUR 70 000,00 and who are they? */

SELECT count(emp_no) from employees where employees.emp_no in (SELECT emp_no from salaries where salary > 70000)

/* output */
135631

SELECT emp_no, first_name, last_name from employees where employees.emp_no in (SELECT emp_no from salaries where salary > 70000)


/* 7.  How many employees do we have in the Research Department, who are working for us since 1992 and who are they? */

SELECT * from employees
    join dept_emp on dept_emp.emp_no = employees.emp_no
    join departments on departments.dept_no = dept_emp.dept_no
    where departments.dept_name = 'Research' AND dept_emp.from_date>='1992-00-00' AND dept_emp.to_date>=CURRENT_DATE();

/* count output */ 9521

/* 8.How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they? */

SELECT * from employees
    join salaries on salaries.emp_no = employees.emp_no
    join dept_emp on dept_emp.emp_no = employees.emp_no
    join departments on departments.dept_no = dept_emp.dept_no
    where departments.dept_name = 'Finance' AND dept_emp.from_date>='1985-00-00' AND dept_emp.to_date>=CURRENT_DATE() AND salaries.salary>70000; 

/* count output */65441

/* select * from salaries
where salary > 75000 AND emp_no IN(
    select emp_no, last_name from employees
    where emp_no in (
        SELECT emp_no from dept_emp
        where from_date>'1985-00-00' and to_date>=Current_Date() AND dept_no in(
            select dept_no from departments
            where dept_name='Finance'
        )
    )
) */

/* 9.We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary. */

SELECT (employees.emp_no),(employees.first_name),(employees.last_name),(employees.birth_date),(employees.gender),(employees.hire_date),(titles.title),(salaries.salary) FROM employees
 JOIN titles ON titles.emp_no = employees.emp_no
 JOIN salaries ON salaries.emp_no = employees.emp_no
 join dept_emp on dept_emp.emp_no = employees.emp_no
WHERE dept_emp.to_date>=CURRENT_DATE()
group by employees.emp_no

/* 10. We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary. */

SELECT (employees.emp_no),(employees.first_name),(employees.last_name),(employees.birth_date),(employees.gender),(employees.hire_date),(titles.title),(salaries.salary),(departments.dept_name) FROM employees
 join titles ON titles.emp_no = employees.emp_no
 join salaries ON salaries.emp_no = employees.emp_no
 join dept_emp on dept_emp.emp_no = employees.emp_no
 join departments on departments.dept_no = dept_emp.dept_no
 join dept_manager on dept_manager.emp_no = employees.emp_no
WHERE dept_emp.to_date>=CURRENT_DATE()
group by employees.emp_no

/* Create a query that will join all tables and show all data from all tables. */
SELECT employees.*,titles.*,salaries.*,dept_emp.*,departments.*,dept_manager.*
FROM employees
 join titles ON titles.emp_no = employees.emp_no
 join salaries ON salaries.emp_no = employees.emp_no
 join dept_emp on dept_emp.emp_no = employees.emp_no
 join departments on departments.dept_no = dept_emp.dept_no
 join dept_manager on dept_manager.dept_no = departments.dept_no


/*  Now you should create at least 5 queries on your own, try to use data from more than 2 tables. */