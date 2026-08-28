-- learning joins 

USE employee_practice;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,           -- links back to customers.customer_id
    product VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Alice', 'Bangalore'),
(2, 'Bob', 'Mumbai'),
(3, 'Charlie', 'Delhi'),
(4, 'Diana', 'Chennai'); 

INSERT INTO orders (order_id, customer_id, product, amount) VALUES
(101, 1, 'Laptop', 55000.00),
(102, 1, 'Mouse', 500.00),
(103, 2, 'Keyboard', 1500.00),
(104, 3, 'Monitor', 12000.00),
(105, 99, 'Webcam', 2000.00);

show tables;

select * from customers;
select * from orders;

SELECT c.customer_name, o.product, o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

SELECT c.customer_name, o.product, o.amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;

 -- customers with NO orders
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;  

SELECT c.customer_name, o.product, o.amount
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;

-- SELECT c.customer_name, o.product, o.amount
-- FROM customers c
-- FULL OUTER JOIN orders o
-- ON c.customer_id = o.customer_id;
-- MySQL doesn't support FULL OUTER JOIN syntax at all — that error confirms it. You're using MySQL (Workbench, by the look of that log), so you need to simulate it with a UNION of a LEFT JOIN and a RIGHT JOIN,
SELECT c.customer_name, o.product, o.amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_name, o.product, o.amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;



    SELECT c.customer_name, o.product, o.amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_name, o.product, o.amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;


SELECT c.customer_name, o.product
FROM customers c
CROSS JOIN orders o;


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees (emp_id, emp_name, manager_id) VALUES
(1, 'Ravi', NULL),      -- Ravi is the top boss, no manager
(2, 'Sneha', 1),        -- Sneha reports to Ravi
(3, 'Amit', 1),         -- Amit reports to Ravi
(4, 'Priya', 2);        -- Priya reports to Sneha

SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.emp_id;
    
-- 1. Total spent per customer
SELECT c.customer_name, COALESCE(SUM(o.amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- 2. Customers with no orders
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 3. Orphaned orders (bad customer_id)
SELECT o.*
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 4. Direct reports count
SELECT m.emp_name AS manager, COUNT(e.emp_id) AS direct_reports
FROM employees m
LEFT JOIN employees e ON e.manager_id = m.emp_id
GROUP BY m.emp_name;


DROP TABLE orders;
DROP TABLE customers;
DROP TABLE employees;
DROP DATABASE learn_joins;