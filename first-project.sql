--cursors using in plsql
-- set SERVEROUTPUT on
-- DECLARE
-- cursor c1(p_job_id VARCHAR2,p_department_id NUMBER) is select first_name,last_name,salary,DEPARTMENT_ID from employees
-- where job_id = p_job_id and DEPARTMENT_ID = p_department_id;
-- --p_boolean number := 1;
-- BEGIN
--   for emp in c1('IT_PROG',50)
--   LOOP
--     --p_boolean := 0;
--     DBMS_OUTPUT.PUT_LINE('first_name =>>' || emp.first_name || 
--                         ';last_name =>>' || emp.last_name || 
--                         ';salary ==>'   || emp.salary || 
--                         ';DEPARTMENT_ID ==>' || emp.DEPARTMENT_ID);
--   end LOOP;
-- end;

--update and insert the table using cursor
-- CREATE TABLE update_table (
--     employee_id NUMBER,
--     first_name VARCHAR2(50),
--     last_name VARCHAR2(50),
--     department_id NUMBER,
--     salary NUMBER
-- );

-- INSERT INTO UPDATE_TABLE (employee_id, first_name, last_name, department_id, salary)
-- VALUES (1, 'John', 'Doe', 101, 50000);

-- INSERT INTO UPDATE_TABLE (employee_id, first_name, last_name, department_id, salary)
-- VALUES (2, 'Jane', 'Smith', 102, 60000);

-- INSERT INTO UPDATE_TABLE (employee_id, first_name, last_name, department_id, salary)
-- VALUES (3, 'Michael', 'Johnson', 101, 55000);

-- INSERT INTO UPDATE_TABLE (employee_id, first_name, last_name, department_id, salary)
-- VALUES (4, 'Emily', 'Williams', 103, 70000);

-- INSERT INTO UPDATE_TABLE (employee_id, first_name, last_name, department_id, salary)
-- VALUES (5, 'David', 'Brown', 102, 65000);

-- INSERT INTO UPDATE_TABLE (employee_id, first_name, last_name, department_id, salary)
-- VALUES (6, 'Emma', 'Jones', 103, 72000);

-- COMMIT;

--update and insert the using cursor;
DECLARE
--insertion after the store the value
v_employee_id table_developer.employee_id%type;

BEGIN
  --create table and if already exists throught error
  BEGIN
    EXECUTE IMMEDIATE ('create table table_developer(
      employee_id number,
      first_name varchar(255),
      last_name varchar(255),
      department_id number,
      salary number
    )');
    dbms_output.put_line('table inserted successfully');
  exception
    when others then
    dbms_output.put_line('error occured as ==> ' || SQLERRM);
  end;

  --insert the date using cursor
  for emp in (select first_name,last_name,department_id from table_developer)LOOP
      insert into table_developer(employee_id,first_name,last_name,department_id,salary)
      VALUES(emp.employee_id,emp.first_name,emp.last_name,emp.department_id,5000);

      --display the information insertion
      v_employee_id := table_developer.CURRVAL;
      dbms_output.put_line('inserted employees '||emp.employee_id ||' '|| emp.first_name || ' ' || emp.last_name || ' ' || emp.department_id);
  end loop;

  --update the insertion value
  update table_developer set salary = emp.salary + 100;

  commit;

  dbms_output.put_line('data inserted and updated successfully');
exception
when others then
dbms_output.put_line('error occured ' || SQLERRM);
end;

