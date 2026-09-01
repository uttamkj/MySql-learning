use youtube;
show tables;
SELECT * FROM employees;
SELECT * FROM employee_projects;
SELECT * FROM projects;

desc employees;
desc employee_projects;
desc projects;
select e.employee_id,e.employee_name,ep.project_id,ep.role,p.project_name
from employees e 
join employee_projects ep
on e.employee_id = ep.employee_id
join projects p 
on ep.project_id = p.project_id
-- where p.project_name = 'crm system'
order by p.project_name desc;


SELECT * FROM employees;
select * from bonuses;

with cte as (
select *,sum(bonus_amount) over(partition by employee_id) as running from bonuses order by employee_id
) 
select distinct employee_id,running from cte where running > 10000;


select e.employee_id,e.employee_name,e.salary,b.bonus_amount 
from employees e 
join bonuses b on e.employee_id = b.employee_id 
where b.bonus_amount >=10000 
order by e.employee_id ;

SELECT e.employee_name AS employerName,
       b.bonus_id      AS bonus_id,
       b.bonus_amount
FROM employees e
LEFT JOIN bonuses b ON e.employee_id = b.employee_id
WHERE b.bonus_id IS NULL;


SELECT e.employee_name  AS employeName,
       m.employee_name  AS managerName,
       e.employment_status
FROM employees e
INNER JOIN employees m ON e.manager_id = m.employee_id
WHERE e.employment_status = 'On Leave';


SELECT e.employee_name as emp_name, m.employee_name as manager_name 
FROM employees e 
JOIN employees m 
ON e.manager_id = m.employee_id 
order by emp_name;

SELECT m.employee_name AS managerName, e.employee_name AS employeeName
FROM employees m 
LEFT JOIN employees e 
ON m.employee_id = e.manager_id 
WHERE m.employee_id IN(
	SELECT DISTINCT employee_id
	FROM employees 
	WHERE manager_id IS NULL
);

SELECT DISTINCT employee_id
FROM employees 
WHERE manager_id IS NULL;


SELECT e.employee_name,
       COUNT(ep.project_id) AS total_project
FROM employees e
INNER JOIN employee_projects ep ON e.employee_id = ep.employee_id
GROUP BY e.employee_id
HAVING COUNT(ep.project_id) > 1;

SELECT p.project_id,
       p.project_name
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
WHERE ep.project_id IS NULL;

SELECT c.client_name,
       COUNT(c.client_id) AS total_number_Orders
FROM clients c
LEFT JOIN orders_data o ON c.client_id = o.client_id
GROUP BY c.client_id;
