SELECT * from employees;
select department,avg(salary)as avg_sal from employees group by department;

SELECT department, avg(salary) over(partition by department) from employees;

with cte as (
	SELECT *,
    row_number() over(partition by department order by salary) as sachin,
    rank() over(partition by department order by salary) as shiva,
    dense_rank() over(partition by department order by salary) as uttam
    FROM employees
)
select * from cte where uttam =2;

with cte as(
select *,
	LAG(salary,1,0) over(partition by department order by employee_id) as previous_salary,
    LEAD(salary,1,0) over(partition by department order by employee_id) as next_salary
FROM employees)
select employee_id,employee_name,department,salary,previous_salary,next_salary from cte where department = 'HR' and salary > next_salary;


SELECT department,
	sum(salary) over(partition by department) as total_salary_expense
FROM employees;

select department,sum(salary) from employees group by department;

select *,
	sum(salary) over(partition by department order by employee_id)as running_total
from employees;

with cte as (
SELECT  *,
	avg(salary) over(partition by department) as avg_salary
FROM employees)
select * from cte where salary > avg_salary;


