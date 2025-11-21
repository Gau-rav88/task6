CREATE DATABASE task6_db;
USE task6_db;

-- Create 2 tables
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert sample data
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales');

INSERT INTO employees (emp_id, emp_name, dept_id, salary) VALUES
(101, 'Amit', 1, 30000),
(102, 'Neha', 2, 60000),
(103, 'Ravi', 2, 80000),
(104, 'Sara', 3, 50000),
(105, 'John', 3, 70000);

-- Subquery in WHERE 
SELECT emp_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- Subquery in WHERE with IN
SELECT emp_name, dept_id
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE dept_name IN ('IT', 'HR')
);


-- Correlated subquery
SELECT e1.emp_name, e1.dept_id, e1.salary
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e1.dept_id
);
-- Subquery with EXISTS
SELECT d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
      AND e.salary > 60000
);
-- Subquery in SELECT
SELECT 
    emp_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS overall_avg_salary
FROM employees;

-- Subquery in FROM
SELECT dept_name, avg_salary
FROM (
    SELECT d.dept_name, AVG(e.salary) AS avg_salary
    FROM departments d
    JOIN employees e ON e.dept_id = d.dept_id
    GROUP BY d.dept_name
) AS dept_avg
WHERE avg_salary > 60000;





