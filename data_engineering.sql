--Create the departments table 
DROP TABLE IF EXISTS departments;  
CREATE TABLE departments ( 
	dept_no VARCHAR PRIMARY KEY,
    dept_name VARCHAR
);

--CREATE Tittle table:
DROP TABLE IF EXISTS Tittle; 
CREATE TABLE Tittle (
    tittle_id VARCHAR   NOT NULL PRIMARY KEY,
    tittle VARCHAR   NOT NULL 
);

--Create the Employee table 
DROP TABLE IF EXISTS Employees; 
CREATE TABLE Employees (
    emp_no INT   NOT NULL PRIMARY KEY,
    emp_tittle_id VARCHAR   NOT NULL,
    birth_date VARCHAR   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date VARCHAR   NOT NULL, 
	FOREIGN KEY (emp_tittle_id) REFERENCES Tittle(tittle_id)
	
);

--Create the Dept_emp table
DROP TABLE IF EXISTS dept_emp; 
CREATE TABLE dept_emp (
	emp_no INT   NOT NULL,
    dept_no VARCHAR  NOT NULL, 
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Create the dept_manager table 
DROP TABLE IF EXISTS Dept_manager; 
CREATE TABLE Dept_manager (
	dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
	PRIMARY KEY (dept_no, emp_no), 
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

-- Create the Salaries table 
DROP TABLE IF EXISTS Salaries; 
CREATE TABLE Salaries (
    emp_no INT  PRIMARY KEY,
    salary INT  NOT NULL, 
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);


-- Check and Display the tables 

SELECT * FROM Departments; 
SELECT * FROM Tittle; 
SELECT * FROM Employees; 
SELECT * FROM Dept_emp; 
SELECT * FROM Dept_manager; 
SELECT * FROM Salaries; 

--PART 3: DATA ANALYSIS: 

--Once you have a complete database, perform these steps:

--1. List the following details of each employee: employee number, 
--last name, first name, sex, and salary.
SELECT e.emp_no, e.first_name, e.last_name, e.sex, s.salary
FROM Employees as e 
INNER JOIN Salaries as s on s.emp_no = e.emp_no; 

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM Employees 
WHERE hire_date LIKE '%1986'; 

--3. List the manager of each department with the following information:
--department number, department name, the manager's employee number, last name, first name.
SELECT dm.dept_no, d.dept_name,  dm.emp_no, e.last_name, e.first_name
FROM Dept_manager AS dm 
JOIN Employees AS e ON e.emp_no = dm.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
; 

--4. List the department of each employee with the following information:
--employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN Employees AS e ON de.emp_no = e.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
; 

--5. List first name, last name, and sex for employees whose first name
--is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex FROM Employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'; 

-- 6. List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN Employees AS e ON de.emp_no = e.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
; 

--7. List all employees in the Sales and Development departments,
--including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
JOIN Employees AS e ON de.emp_no = e.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
; 

--8. List the frequency count of employee last names 
--(i.e., how many employees share each last name) in descending order.
SELECT last_name, COUNT(last_name) AS Frequency_count
FROM employees
GROUP BY last_name
ORDER BY Frequency_count DESC;