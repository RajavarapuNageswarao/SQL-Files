/*
Write an SQL query to fetch �FIRST_NAME� from the Worker table using the alias name <WORKER_NAME>.
Write an SQL query to fetch �FIRST_NAME� from the Worker table in upper case.
Write an SQL query to fetch unique values of DEPARTMENT from the Worker table.
Write an SQL query to print the first three characters of  FIRST_NAME from the Worker table.
Write an SQL query to find the position of the alphabet (�a�) in the first name column �Amitabh� from the Worker table.
Write an SQL query to print the FIRST_NAME from the Worker table after removing white spaces from the right side.
Write an SQL query to print the DEPARTMENT from the Worker table after removing white spaces from the left side.
Write an SQL query that fetches the unique values of DEPARTMENT from the Worker table and prints its length.
Write an SQL query to print the FIRST_NAME from the Worker table after replacing �a� with �A�.
Write an SQL query to print the FIRST_NAME and LAST_NAME from the Worker table into a single column COMPLETE_NAME. A space char should separate them.
Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
Write an SQL query to print details for Workers with the first names �Vipul� and �Satish� from the Worker table.
Write an SQL query to print details of workers excluding first names, �Vipul� and �Satish� from the Worker table.
Write an SQL query to print details of Workers with DEPARTMENT name as �Admin�.
Write an SQL query to print details of the Workers whose FIRST_NAME contains �a�.
Write an SQL query to print details of the Workers whose FIRST_NAME ends with �a�.
Write an SQL query to print details of the Workers whose FIRST_NAME ends with �h� and contains six alphabets.
Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
Write an SQL query to print details of the Workers who joined in Feb 2021.
Write an SQL query to fetch the count of employees working in the department �Admin�.
Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
Write an SQL query to fetch the number of workers for each department in descending order.
Write an SQL query to print details of the Workers who are also Managers.
Write an SQL query to fetch duplicate records having matching data in some fields of a table.
Write an SQL query to show only odd rows from a table.
Write an SQL query to show only even rows from a table.
Write an SQL query to clone a new table from another table.
Write an SQL query to fetch intersecting records of two tables.
Write an SQL query to show records from one table that another table does not have.
Write an SQL query to show the current date and time.
Write an SQL query to show the top n (say 10) records of a table.
Write an SQL query to determine the nth (say n=5) highest salary from a table.
Write an SQL query to determine the 5th highest salary without using the TOP or limit method.
Write an SQL query to fetch the list of employees with the same salary.
Write an SQL query to show the second-highest salary from a table.
Write an SQL query to show one row twice in the results from a table.
Write an SQL query to fetch the first 50% of records from a table.
Write an SQL query to fetch the departments that have less than five people in them.
Write an SQL query to show all departments along with the number of people in there.
Write an SQL query to show the last record from a table.
Write an SQL query to fetch the first row of a table.
Write an SQL query to fetch the last five records from a table.
Write an SQL query to print the names of employees having the highest salary in each department.
Write an SQL query to fetch three max salaries from a table.
Write an SQL query to fetch three min salaries from a table.
Write an SQL query to fetch nth max salaries from a table.
Write an SQL query to fetch departments along with the total salaries paid for each of them.
Write an SQL query to fetch the names of workers who earn the highest salary.
*/

--1
select first_name||''||last_name as worker_name from employees;
--2
select upper(first_name || ' ' || last_name) as worker_name from employees; 
--3
select distinct(department_id) as departments from employees
where department_id is not null
order by department_id;
--4
select substr(first_name|| ' ' ||last_name,1,3) as full_name from employees;
--5
select instr(first_name,'a') as instr_name from employees where first_name = 'Alexander';
--6
select RTRIM(first_name) from employees;
--7
select LTRIM( last_name ) from employees;
--8
select distinct(length(department_id)) as departments from employees;
--9
select replace(first_name,'a','A') as remove_names from employees;
--10
select first_name || ' ' || last_name as complete_name from employees;
--11
select first_name from employees order by first_name desc;
select first_name,department_id from employees order by first_name asc,department_id desc; 
--12
select first_name,last_name from employees where first_name in ('Neena','David');
--13
select first_name,last_name from employees where first_name not in ('Neena','David');
--14
select first_name as department from employees where first_name = 'Admin';
--Write an SQL query to print details of the Workers whose FIRST_NAME contains �a�.
select first_name from employees where first_name like '%a%';
--Write an SQL query to print details of the Workers whose FIRST_NAME ends with �a�.
select first_name from employees where first_name like '%a';
--Write an SQL query to print details of the Workers whose FIRST_NAME ends with �h� and contains six alphabets.
select first_name from employees where first_name like '______h';
--Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
select salary from employees where salary between 100000 and 500000;
--Write an SQL query to print details of the Workers who joined in Feb 2021.
select salary from employees where extract(year from hire_date) = 2021 
and extract(month from hire_date) = 2;
--Write an SQL query to fetch the count of employees working in the department �Admin�.
select count(*) from employees
where department_id = 'Admin';
--Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
select salary from employees where salary between 50000 and 100000;
--Write an SQL query to fetch the number of workers for each department in descending order.
select department_id,count(*) as count_of_workers from employees 
group by department_id;
--Write an SQL query to print details of the Workers who are also Managers.
with employees_manager as(
select employee_id,manager_id from employees e)
select distinct e.employee_id,e.manager_id from employees e
join employees_manager s on e.employee_id = s.manager_id; 
--Write an SQL query to fetch duplicate records having matching data in some fields of a table.
SELECT t1.*
FROM employees t1
JOIN departments t2 ON (
    t1.first_name = t2.department_name 
    AND t1.employee_id = t2.location_id 
    AND t1.salary = t2.department_id
    -- Add more fields as needed
    AND t1.department_id <> t2.department_id -- Ensure not to match the same row
);
--Write an SQL query to show only odd rows from a table.
select * from employees where mod(employee_id,2)<>0;
select * from employees where mod(employee_id,2)=0;
--Write an SQL query to clone a new table from another table.
CREATE TABLE employee_21 AS
SELECT *
FROM employees;
--Write an SQL query to fetch intersecting records of two tables.
select * from EMPLOYEES_NEW
intersect
select * from employees;
--Write an SQL query to show records from one table that another table does not have.
SELECT *
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM departments d
    WHERE e.department_id = d.department_id
);
--Write an SQL query to show the current date and time.
select sysdate from dual;
--Write an SQL query to show the top n (say 10) records of a table.
select * from(
select * from employees)
where rownum<=10;
--Write an SQL query to determine the nth (say n=5) highest salary from a table.
with salaries_fifth as(
select first_name||' '||last_name as full_name,salary,
row_number()over(order by salary desc) as rank from employees)
select full_name,salary from salaries_fifth
where rank = 5;
--Write an SQL query to determine the nth (say n=5) highest salary from a table.
select * from (
select salary,row_number()over(order by salary desc) as salary_5 from employees)ranked_salarie
where salary_5=5;
--Write an SQL query to fetch the list of employees with the same salary.
select e1.employee_id,e1.first_name,e1.salary
from employees e1
join employees e2
on e1.salary = e2.salary
WHERE e1.employee_id <> e2.employee_id
order by e1.salary;
--Write an SQL query to show the second-highest salary from a table.
select * from (
select salary,row_number()over(order by salary desc) as salary_5 from employees)ranked_salarie
where salary_5=2;
--same employees twice
SELECT * FROM employees
UNION ALL
SELECT * FROM employees_new;
--50 percent employees print
WITH ranked_records AS (
    SELECT first_name,last_name,salary,
           NTILE(107) OVER (ORDER BY salary) AS percentile_rank
    FROM employees
)
SELECT first_name,last_name,salary
FROM ranked_records
WHERE percentile_rank <= 50;
--Write an SQL query to fetch the departments that have less than five people in them.
SELECT department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*) < 5;
--Write an SQL query to show all departments along with the number of people in there.
select department_id,count(*) as count_employees from employees
group by department_id;
--Write an SQL query to show the last record from a table.
SELECT *
FROM (
    SELECT e.*,
           ROW_NUMBER() OVER (ORDER BY e.employee_id DESC) AS row_num
    FROM employees e
) subquery
WHERE row_num = 1;
--write an sql query to show the record of the first
SELECT *
FROM (
    SELECT e.*,
           ROW_NUMBER() OVER (ORDER BY e.employee_id asc) AS row_num
    FROM employees e
) subquery
WHERE row_num <= 5;
--last five records
SELECT *
FROM (
    SELECT e.*,
           ROW_NUMBER() OVER (ORDER BY employee_id DESC) AS row_num
    FROM employees e
) subquery
WHERE row_num <= 5;
--Write an SQL query to print the names of employees having the highest salary in each department.
WITH ranked_employees AS (
    SELECT e.*,
           ROW_NUMBER() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS rank
    FROM employees e
)
SELECT employee_id, first_name || ' ' || last_name as full_name, department_id, salary
FROM ranked_employees
WHERE rank = 1;
--all min and max of three employees
WITH ranked_salaries AS (
    SELECT salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS max_rank
           --ROW_NUMBER() OVER (ORDER BY salary ASC) AS min_rank
    FROM employees
)
SELECT 'Max Salaries Top 3' AS category, salary
FROM ranked_salaries
WHERE max_rank <= 3;
--min top 3
WITH ranked_salaries AS (
    SELECT salary,
           --ROW_NUMBER() OVER (ORDER BY salary DESC) AS max_rank
           ROW_NUMBER() OVER (ORDER BY salary ASC) AS min_rank
    FROM employees
)
SELECT 'Min Salaries Top 3' AS category, salary
FROM ranked_salaries
WHERE min_rank <= 3;

--top n
WITH ranked_salaries AS (
    SELECT salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS max_rank
           --ROW_NUMBER() OVER (ORDER BY salary ASC) AS min_rank
    FROM employees
)
SELECT 'Max Salaries &n' AS category, salary
FROM ranked_salaries
WHERE max_rank <= &n;
--sum of all salaries department wise
SELECT department_id, 'This is the total salary: ' || TO_CHAR(SUM(salary)) AS total_salary
FROM employees
GROUP BY department_id;

--
SELECT 'highest salary employees : ' || first_name || ' ' || last_name as full_name
FROM (
    SELECT first_name, last_name, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM employees
) ranked_workers
WHERE rn = 1;

/*
1 Create a query that displays EMPFNAME, EMPLNAME, DEPTCODE, DEPTNAME, LOCATION from EMPLOYEE, and DEPARTMENT tables. 
Make sure the results are in ascending order based on the EMPFNAME and LOCATION of the department.
*/

SELECT e.first_name AS EMPFNAME ,
  e.last_name       AS EMPLNAME,
  e.department_id   AS DEPTCODE,
  d.department_name AS DEPTNAME,
  l.city            AS location
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
ORDER BY EMPFNAME,
  location;

--Display EMPFNAME and �TOTAL SALARY� for each employee
SELECT 'Employee Full Name : ' || first_name || ' ' || last_name || 
'       This is Employee Total salary' || SUM(SALARY) 
AS full_name_total_salary
FROM employees
GROUP BY first_name, last_name; --91

--Display MAX and 2nd MAX SALARY from the EMPLOYEE table.
SELECT 'This is the max salary : '
  || MAX(salary) AS Total_salary
FROM
  (SELECT salary,
    row_number()over(order by salary DESC) AS ranked_salaries
  FROM employees
  ) salaries_employees
UNION ALL
SELECT 'This is The second Highest Salary : '
  || MAX(
  CASE
    WHEN ranked_salaries = 2
    THEN salary
  END)
FROM
  (SELECT salary,
    row_number()over(order by salary DESC)AS ranked_salaries
  FROM employees
  )salaries_employees;

-- Display the TOTAL SALARY drawn by an analyst working in dept no 20
select sum(salary) as total_salary from employees where job_id = 'analyst' and department_id = 20;
--Compute the average, minimum, and maximum salaries of the group of employees having the job of ANALYST.
select avg(salary) as average,
min(salary) as minimum,
max(salary) as maximum from employees
where job_id = 'FI_ACCOUNT';

--Query to find all employees who did not get a promotion in the last year:
SELECT emp.employee_id, emp.first_name
FROM employees emp
LEFT JOIN employees prom ON emp.manager_id = prom.employee_id
WHERE prom.commission_pct IS NULL OR prom.hire_date > ADD_MONTHS(SYSDATE, -12);

--Top 10 highest salary
select * from(
select e.*, row_number() over(order by e.salary desc) as rank from employees e)
where rank = 10;

select first_name,last_name,salary from(
select first_name,last_name,salary from employees order by salary desc)where rownum <=10;
--Query to find all database tables which was not part of the backup during last week:
SELECT table_name
FROM all_tables
WHERE table_name NOT IN (
    SELECT DISTINCT table_name
    FROM ALL_TABLES
    WHERE LAST_ANALYZED >= TRUNC(SYSDATE) - 7  -- Last week
);

--Retrieve all employees and their departments, including those without a department.
select 'This is the employees details ' || e.employee_id,e.first_name|| ' ' ||e.last_name as full_name, d.department_name from employees e
left join departments d on e.department_id=d.department_id;

--Find the second highest salary from the �salaries� table.
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);
--Calculate the average salary for each department.
select d.department_name,avg(e.salary) as avg_salary from employees e
join departments d on e.department_id = d.department_id
group by rollup(d.department_name);
--List the employees who have the same salary as the second highest-paid employee.
with rankedemployees as(
select e.*,dense_rank()over(order by salary desc) as rank from employees e)
select * from rankedemployees
where rank = 8;

--another model
select employee_id,first_name,last_name, ' This is The Third Highest Salary : ' || salary as second_highest_salary 
from employees
where salary =(
select max(salary) from employees where salary <
(select max(salary) from employees)
and salary < (select max(salary) from employees where salary < (select max(salary) from employees)));

--Retrieve the employees who joined before their manager. use employees table
select e.employee_id,e.first_name,e.hire_date,
m.employee_id as manager_id,m.first_name as manager_name,m.hire_date as manager_hire_date
from employees e join employees m
on e.manager_id = m.employee_id
where e.hire_date < m.hire_date; --37

--Find the top 3 departments with the highest average salary.
WITH RankedDepartments AS (
    SELECT
        d.department_name,
        AVG(e.salary) AS avg_salary,
        row_number() OVER (ORDER BY AVG(e.salary) DESC) AS rank
    FROM
        employees e
    JOIN
        departments d ON e.department_id = d.department_id
    GROUP BY
        d.department_name
)
SELECT
    department_name,
    avg_salary
FROM
    RankedDepartments
WHERE
    rank <= 3;

-- List the departments where the average salary is above the overall average salary.
with overall_average_salary as(
select d.department_id,avg(e.salary) as avg_salary,
row_number()over(order by avg(e.salary) desc) as rank from employees e
join departments d on e.department_id = d.department_id 
group by d.department_id),
overagesalary as (select avg(salary ) from employees)
select 
d.department_name,
d.department_id,
oas.avg_salary
 from overall_average_salary oas join departments d on oas.department_id = d.department_id
 cross join overagesalary os
 where rank <=6;
--Update employee salaries to the maximum salary within their department. Also, print the old salary vs the new salary.
select department_id,salary from employees where department_id = 20;--13000 6000
UPDATE employees e
SET salary = (SELECT MAX(salary) FROM employees WHERE department_id = e.department_id)
where department_id = 20;
select 'This is new salary '  from (
select department_id,'This is old salary  ' || salary from employees where department_id = 20);

--Find the employees who have the same salary and department as their manager.
SELECT e.employee_id, e.first_name, e.salary, e.department_id
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary = m.salary
AND e.department_id = m.department_id; --169	Harrison	11000	80

--Retrieve the cumulative salary for each employee considering the running total within their department.
SELECT 
    CASE 
        WHEN employee_id IS NULL THEN 'Sum of Total Salary: ' || department_id
        ELSE NVL(TO_CHAR(employee_id), 'Sum of Total Salary: ')
    END AS employee_id,
    CASE 
        WHEN employee_id IS NULL THEN 'Sum of Total Salary: ' || department_id
        ELSE NVL(first_name, 'Sum of Total Salary: ')
    END AS first_name,
    CASE 
        WHEN employee_id IS NULL THEN 'Sum of Total Salary: ' || department_id
        ELSE NVL(TO_CHAR(department_id), 'There is no department')
    END AS department_id,
    NVL(TO_CHAR(salary), TO_CHAR(SUM(salary) OVER (PARTITION BY department_id))) AS salary,
    CASE 
        WHEN employee_id IS NULL THEN SUM(salary) OVER (PARTITION BY department_id)
        ELSE SUM(salary) OVER (PARTITION BY department_id ORDER BY employee_id)
    END AS cumulative_salary
FROM 
    employees
WHERE 
    department_id IS NOT NULL
GROUP BY 
    GROUPING SETS ((employee_id, first_name, department_id, salary), (department_id));

--Find the third maximum salary from the �salaries� table without using the LIMIT clause.
select * from
(select e.*,row_number()over(order by salary desc) as Salary_Rank from employees e)
where Salary_Rank = 3;
--List the employees who have never been assigned to a department.
select * from employees where department_id is null;
-- Retrieve the employees with the highest salary in each department.
WITH RankedEmployees AS (
    SELECT 
        employee_id,
        first_name,
        department_id,
        salary,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank
    FROM 
        employees
)
SELECT 
    employee_id,
    first_name,
    department_id,
    salary
FROM 
    RankedEmployees
WHERE 
    rank = 1;
 
--Calculate the median salary for each department.
WITH MedianSalary AS (
    SELECT 
        department_id,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) OVER (PARTITION BY department_id) AS median_salary
    FROM 
        employees
)
SELECT 
    department_id,
    median_salary
FROM 
    MedianSalary
GROUP BY 
    department_id, median_salary;
    
--Find the employees who have the same manager as the employee with ID 3.
SELECT e.employee_id, e.first_name, e.manager_id
FROM employees e
JOIN employees m ON e.manager_id = m.manager_id
WHERE m.employee_id = 131
AND e.employee_id != 131;
  

WITH RankedEmployees AS (
    SELECT 
        employee_id,
        first_name,
        salary,
        department_id,
        hire_date,
        RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
    FROM 
        employees
    WHERE 
        hire_date >= ADD_MONTHS(CURRENT_DATE, 20)
)
SELECT 
    employee_id,
    first_name,
    salary,
    department_id
FROM 
    RankedEmployees
WHERE 
    salary_rank = 1;

select hire_date from employees
order by hire_date desc;


-- List the departments with more than 3 employees
select department_id,count(*) from employees
group by department_id
having count(*)<=3;
--Retrieve the employees with the second lowest salary.
select * from(
select e.*,dense_rank()over(order by salary) as rank from employees e)
where rank = 2;

--Find the departments where the highest and lowest salaries differ by more than $10,000.
SELECT 
    department_id,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary,
    MAX(salary) - MIN(salary) AS salary_difference
FROM 
    employees
GROUP BY 
    department_id
HAVING 
    MAX(salary) - MIN(salary) > 10000;

--Retrieve the employees who have the same salary as the employee with ID 2 in a different department.
SELECT e.employee_id, e.first_name, e.salary, e.department_id
FROM employees e
JOIN employees e2 ON e.salary = e2.salary
WHERE e.employee_id != 104 -- Exclude the employee with ID 2
AND e.department_id != e2.department_id; -- Ensure employees are in different departments

--Calculate the difference in days between the hire dates of each employee and their manager.
select e.employee_id,e.hire_date,m.employee_id as manager_id,
m.hire_date as manager_hire_date,
(e.hire_date - m.hire_date) as hire_date_difference
from employees e join employees m  on e.manager_id = m.employee_id;

--Find the departments where the sum of salaries is greater than the overall average salary.
select department_id from employees group by department_id 
having sum(salary) > (select avg(salary) as avg_salary from employees); --6838.093457943925233644859813084112149533

--24. List the employees who have the same salary as at least one other employee.
select e1.first_name,e1.employee_id,e1.salary from employees e1 join employees e2 on e1.salary=e2.salary
and e1.employee_id<>e2.employee_id;

--Retrieve the employees with the highest and lowest salary in each department.

select department_id,max(salary) as max_salary, min(salary) as min_salary from employees
where department_id is not null
group by department_id
order by department_id;

--26. Find the employees who have the same salary as the employee with ID 2 and are in the same department.
SELECT e1.employee_id, e1.salary, e1.department_id
FROM employees e1
JOIN employees e2 ON e1.salary = e2.salary
WHERE e2.employee_id = 100
AND e1.department_id = e2.department_id
AND e1.employee_id != 100;


--7. Calculate the average salary excluding the highest and lowest salaries in each department.
select department_id,avg(salary) as avg_salary from 
(select e.*,row_number()over(partition by department_id order by salary desc) as ranked_employees,
count(*) over(partition by department_id) as count_of_employees from employees e) 
where ranked_employees>1 
and ranked_employees<count_of_employees
group by department_id;

--List the employees who have a higher salary than their manager.
SELECT e.employee_id, e.salary, e.manager_id
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

--29. Retrieve the top 5 departments with the highest salary sum.
SELECT department_id, total_salary
FROM (
    SELECT department_id, SUM(salary) AS total_salary,
           ROW_NUMBER() OVER (ORDER BY SUM(salary) DESC) AS rn
    FROM employees
    GROUP BY department_id
)
WHERE rn <= 5;

--Find the employees who have the same salary as the average salary in their department.
select e.employee_id,e.department_id,e.salary from employees e join(
select department_id,avg(salary) as avg_salary from employees group by department_id) avg_salary_records on 
e.department_id = avg_salary_records.department_id
where e.salary = avg_salary_records.avg_salary;

--Calculate the moving average salary for each employee over the last 3 months.
SELECT employee_id, hire_date, salary,
       AVG(salary) OVER (PARTITION BY employee_id ORDER BY hire_date 
                         RANGE BETWEEN INTERVAL'10' year PRECEDING AND CURRENT ROW) AS moving_avg_salary
FROM employees;

--List the employees who have joined in the same month as their manager.
select e.employee_id,e.first_name,e.manager_id
from employees e join employees m on e.manager_id = m.employee_id
where extract (year from e.hire_date) =  extract(year from m.hire_date)
and extract(month from e.hire_date) = extract(month from m.hire_date);
/*
109
138
179
206
*/

--Retrieve the employees with salaries in the top 10% within their department.
SELECT employee_id, salary, department_id
FROM (
    SELECT employee_id, salary, department_id,
           NTILE(10) OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_percentile
    FROM employees
)
WHERE salary_percentile = 1 and department_id is not null;

--Find the departments where the number of employees is greater than the number of employees in the �IT� department.
SELECT e.department_id,d.department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name,e.department_id
HAVING COUNT(*) > (
    SELECT COUNT(*)
    FROM employees
    WHERE department_id = (
        SELECT department_id
        FROM departments
        WHERE department_name = 'IT'
    )
);


--35. Retrieve the employees who have the same salary as the employee with ID 2 in a different department and joined in the last year.
SELECT e.employee_id, e.first_name
FROM employees e
WHERE e.salary = (
    SELECT salary
    FROM employees
    WHERE employee_id = 2
  )
  AND e.department_id <> (
    SELECT department_id
    FROM employees
    WHERE employee_id = 2
  )
  AND e.hire_date >= ADD_MONTHS(sysdate, -12);

--36. Calculate the difference in salary between each employee and the employee with ID 1.
select first_name,employee_id ,salary - (select salary from employees
where employee_id = 104) as salary_difference from employees;

--37. List the employees who have the same salary as the employee with ID 3 in the same department.
select first_name,last_name,employee_id from employees e
where salary = (select salary from employees where employee_id = 104)
and department_id = (select department_id from employees where employee_id = 104) and e.employee_id <> 3;

--Retrieve the employees who have the same manager as the employee with ID 2 and are in a different department.
select e.first_name,e.employee_id from employees e where manager_id = (
select manager_id from employees where employee_id = 102) and department_id <> (
select manager_id from employees where employee_id = 102) and e.employee_id <> 2;

--Calculate the difference in years between the hire dates of each employee and the average hire date in their department.
--40. Find the employees who have a salary equal to or more than the average salary across all departments.
select department_id,salary from employees where salary >=(select avg(salary) from employees);

--Retrieve the employees who have the same salary as the median salary in their department.

SELECT 
    e.employee_id,
    e.first_name,
    e.salary,
    m.median_salary
FROM 
    employees e
JOIN (
    SELECT 
        department_id,
        MEDIAN(salary) OVER (PARTITION BY department_id) AS median_salary
    FROM 
        employees
) m ON e.department_id = m.department_id
WHERE 
    e.salary = m.median_salary;

--42. Calculate the difference in days between the hire dates of each employee and 
--the hire date of the employee with the earliest hire date in their department.
select e.first_name|| '' ||e.last_name as full_name,e.salary,e.hire_date,
min(e.hire_date) over(partition by department_id) as earliest_hire_date,
e.hire_date - min(e.hire_date) over(partition by department_id) as hire_date_difference
from employees e

--Retrieve the employees who have the same salary as the employee with ID 5 in a different department.
select e.first_name,e.last_name,e.salary,e.department_id from employees e where e.salary = 
(select salary from employees where employee_id = 104)
and e.department_id <> 
(select department_id from employees where employee_id = 104)
and e.employee_id <> 5;

--List the employees who have the same manager as the employee with ID 5 and have a higher salary.
select e.first_name,e.salary from employees e
where e.manager_id = (select salary from employees where employee_id = 184)
and e.salary > (select salary from employees where employee_id = 184)
and e.employee_id <> 5;
--45. Calculate the difference in months between the hire dates of each 
--employee and the hire date of the employee with the latest hire date in their department.
SELECT 
    employee_id,
    first_name,
    hire_date,
    department_id,
    MAX(hire_date) OVER (PARTITION BY department_id) AS latest_hire_date,
    MONTHS_BETWEEN(hire_date, MAX(hire_date) OVER (PARTITION BY department_id)) AS hire_date_difference_months
FROM 
    employees; 

--46. Retrieve the employees who have the same salary as the employee with ID 1 and joined in the last 6 months.
select first_name,employee_id,hire_date,salary from employees where salary = (select salary from employees
where employee_id = 106)
and hire_date >= add_months((select hire_date from employees where employee_id = 106), - 6);

--List the departments where the highest salary is more than twice the lowest salary.
select department_id from employees group by department_id
having  max(salary) >2*min(salary);

--48. Retrieve the employees who have the same manager as the employee with ID 3 and are in the same department.
select first_name,employee_id from employees  where manager_id = 
(select salary from employees where employee_id = 102)
and department_id = (select department_id from employees where employee_id = 102);

--49. Calculate the difference in hours between the hire dates of each 
--employee and the hire date of the employee with the earliest hire date in the company.
SELECT 
    employee_id,
    first_name,
    hire_date,
    (hire_date - (SELECT MIN(hire_date) FROM employees)) * 24 AS hire_date_difference_hours
FROM 
    employees;

--Find the employees who have the same salary as the employee with ID 2 and joined in the last year.
SELECT 
    employee_id,
    first_name,
    salary,
    hire_date
FROM 
    employees
WHERE 
    salary = (SELECT salary FROM employees WHERE employee_id = 119)
    AND hire_date >= ADD_MONTHS((SELECT hire_date FROM employees WHERE employee_id = 119), -12);
    
    
--   Retrieve the names of each and every customer who joined before �2022-03-25�.
select hire_date,first_name || ' ' ||last_name as full_name from employees
where hire_date < to_date('2022-03-25','YYYY-MM-DD');
--List out each and every order made by �Kim.�
SELECT employee_id, hire_date, first_name
   FROM employees
   WHERE employee_id = (SELECT employee_id FROM employees WHERE first_name = 'Neena');

--   
/*

Table:

CREATE TABLE TABLE_NAME(
  ID NUMBER PRIMARY KEY,
  COLUMN_NAME NUMBER NOT NULL,   -- Modify with varchar2(20) NOT NULL
  .
  .
  .  
);

Step to modify the datatype of COLUMN_NAME from NUMBER to VARCHAR2

STEPS:

--Step 1: Add a temp column COLUMN_NAME_TEMP in table TABLE_NAME to hold data temporary
ALTER TABLE TABLE_NAME
ADD( COLUMN_NAME_TEMP           varchar2(20) );

--Step 2: Update temp column COLUMN_NAME_TEMP with Old columns COLUMN_NAME data
UPDATE TABLE_NAME
SET COLUMN_NAME_TEMP   = COLUMN_NAME;

--Step 3: Remove NOT NULL constrain from old columns COLUMN_NAME
ALTER TABLE TABLE_NAME MODIFY (COLUMN_NAME NULL);

--Step 4: Update old columns COLUMN_NAME data with NULL
UPDATE TABLE_NAME SET COLUMN_NAME  = NULL;

--Step 5: Alter table old columns COLUMN_NAME to new data type varchar2(20)
ALTER TABLE TABLE_NAME MODIFY COLUMN_NAME varchar2(20);

--Step 6: Update old columns COLUMN_NAME with data from temp columns COLUMN_NAME_TEMP
UPDATE TABLE_NAME
SET COLUMN_NAME  = COLUMN_NAME_TEMP;

--Step 7: Add NOT NULL constrain from old columns [COLUMN_NAME]
ALTER TABLE TABLE_NAME MODIFY (COLUMN_NAME NOT NULL);

--Step 8: Drop the temp column [COLUMN_NAME_TEMP]
alter table TABLE_NAME drop column COLUMN_NAME_TEMP;

*/

