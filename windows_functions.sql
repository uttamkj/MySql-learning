use browsejobs;
show tables;
select * from employees;

SELECT employee_id,first_name,salary,department_id,
	dense_rank() over(partition by department_id order by salary) as rn, 
    rank() over(order by salary) as rnk,
    row_number() over(order by salary) as odr
FROM employees;

with cte as (
SELECT employee_id,first_name,salary, 
	LEAD(salary) over(order by salary desc) as next_salary, 
	LAG(salary) over(order by salary desc) as previous_salary
FROM employees)

select * from cte where salary > previous_salary;

WITH cte AS (
    SELECT employee_id, first_name, salary,
        LEAD(salary) OVER(ORDER BY employee_id ) AS next_salary,
        LAG(salary) OVER(ORDER BY employee_id) AS previous_salary
    FROM employees
)
SELECT * FROM cte 
WHERE salary > next_salary;