SELECT * FROM employees where salary > (Select avg(salary) from employees);

select * from employees where salary = (SELECT max(salary) from employees);

SELECT * from employees where department in (
SELECT department
FROM employees 
WHERE employee_name = 'Aarav Sharma');


SELECT * from employees where salary > all(
SELECT salary
from employees
where department = 'Support');

SELECT * FROM employees where department in (
SELECT distinct department from employees where employment_status = 'On Leave');

SELECT * from bonuses;

SELECT * from employees where employee_id in ( SELECT distinct employee_id from bonuses);

SELECT * 
FROM employees e 
where exists(
	select  1 
	from bonuses b 
	where b.employee_id = e.employee_id
);

SELECT *
FROM employees e
WHERE not EXISTS (
    SELECT 1
    FROM bonuses b
    WHERE b.employee_id = e.employee_id
);







