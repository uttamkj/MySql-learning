use youtube;
show tables;
select * from employees;
select distinct department from employees;
select distinct department from employees where department is not null;
select * from employees where salary > 80000;

select * from employees where salary > 80000 and department = "IT";
SELECT * from employees where department in ('IT','Finance');

SELECT * FROM employees where  employment_status  <> 'Active';

with cte as (select distinct department from employees where department is not null)
select count(*) as total_dept from cte;



