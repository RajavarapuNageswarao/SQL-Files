select e.first_name || ' ' || e.last_name as full_name,d.department_name,d.location_id,jh.START_DATE,jh.END_DATE,j.JOB_TITLE
from employees e join departments d on e.department_id = d.DEPARTMENT_ID
join JOB_HISTORY jh on e.employee_id = jh.EMPLOYEE_ID
join jobs j on e.job_id = j.JOB_ID;















