SELECT count(*) as total_emp FROM employees;
SELECT count(manager_id) as total_mgr FROM employees;
select sum(salary) as total_spend from employees;
select round(avg(salary),2) avg_salary from employees;
SELECT max(salary) as max_salary_emp FROM employees;
SELECT * FROM employees where salary = (select max(salary) from employees) ;
SELECT department,count(*) as total_emp_dept_wise from employees where department is not null  group by department;
select city,avg(salary) as avg_salary from employees group by city;
select employment_status,count(*) as total from employees  group by employment_status;
select employment_status,count(*) as total from employees WHERE employment_status = 'Active' group by employment_status;
select department,sum(salary) as total from employees where city = 'mumbai' group by department;

select department,count(*) as total from employees group by department having total>5;

-- Q12: Find cities whose average salary is greater than ₹70,000.
select city,avg(salary) as avg_salary 
FROM employees
GROUP BY city
having avg_salary > 70000;

--  Q13: Find departments whose average salary lies between ₹60,000 and ₹80,000.
select department, avg(salary) as avg_dept_salary
from employees
group by department
having avg_dept_salary between 60000 and 80000;

-- Q14: Find departments having at least 4 employees who are currently Active.

select department,count(*) as total_active_emp
FROM employees
where employment_status = 'Active'
group by department
having total_active_emp > 4;


SELECT email, COUNT(*) AS duplicate_email_count
FROM employees
GROUP BY email
HAVING duplicate_email_count > 1;
 

-- Q16: Find the department with the highest average salary.
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC
LIMIT 1;

-- Q17: Find the city with the lowest average salary.
SELECT city, AVG(salary) AS avg_salary
FROM employees
GROUP BY city
ORDER BY avg_salary ASC
LIMIT 1;

-- Q18: Find the top 3 highest-paid employees in each department.
SELECT department, name, salary
FROM (
    SELECT department, name, salary,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
    FROM employees
) AS ranked_employees
WHERE rank <= 3;