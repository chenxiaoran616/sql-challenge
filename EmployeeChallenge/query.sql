DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE departments (
    dept_no character(50) NOT NULL,
    dept_name character varying(255) NOT NULL
);

CREATE TABLE dept_emp (
  emp_no integer NOT NULL,
  dept_no character(50) NOT NULL,
  from_date date NOT NULL,
  to_date date NOT NULL
);

CREATE TABLE dept_manager (
  dept_no character(50) NOT NULL,
  emp_no integer NOT NULL,
  from_date date NOT NULL,
  to_date date NOT NULL
);

CREATE TABLE employees (
  emp_no integer NOT NULL,
  birth_date date NOT NULL,
  first_name character varying(45) NOT NULL,
  last_name character varying(45) NOT NULL,
  gender character NOT NULL,
  hire_date date NOT NULL
);

CREATE TABLE salaries (
  emp_no integer NOT NULL,
  salary integer NOT NULL,
  from_date date NOT NULL,
  to_date date NOT NULL
);

CREATE TABLE title (
  emp_no integer NOT NULL,
  title character varying(255) NOT NULL,
  from_date date NOT NULL,
  to_date date NOT NULL
);

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT
	employees.emp_no,
	first_name,
	last_name,
	gender,
	salary
FROM
	employees
FULL OUTER JOIN salaries ON employees.emp_no=salaries.emp_no
ORDER BY employees.emp_no;

--2. List employees who were hired in 1986.
SELECT * FROM employees
WHERE date_part('year', hire_date) = 1986;

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT 
	dept_manager.dept_no, 
	dept_manager.emp_no,
	from_date,
	to_date,
	dept_name,
	employees.first_name,
	employees.last_name
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no=departments.dept_no
INNER JOIN employees ON dept_manager.emp_no=employees.emp_no

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT 
	dept_emp.emp_no,
	dept_emp.dept_no,
	first_name,
	last_name,
	departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no
ORDER BY dept_emp.emp_no

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees 
WHERE first_name='Hercules' AND last_name LIKE 'B%'

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT 
	dept_emp.emp_no,
	dept_emp.dept_no,
	first_name,
	last_name,
	dept_name
FROM dept_emp 
INNER JOIN employees ON dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE dept_name='Sales'

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT 
	dept_emp.emp_no,
	dept_emp.dept_no,
	first_name,
	last_name,
	dept_name
FROM dept_emp 
INNER JOIN employees ON dept_emp.emp_no=employees.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE dept_name='Sales' OR dept_name='Development'
ORDER BY dept_name,emp_no

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT employees.last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY count DESC
	
	