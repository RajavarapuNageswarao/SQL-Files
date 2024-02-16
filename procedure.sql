--first model simple procedure
create or replace PROCEDURE first_procedure
AS
--v_employees employees%rowtype;
BEGIN
  for emp in (select * from employees)
  LOOP
    dbms_output.put_line(emp.first_name);
  end loop;
end;

BEGIN
  FIRST_PROCEDURE();
end;

--second model using cursor
create or replace PROCEDURE cursor_procedure AS
cursor emp is select * from employees;
BEGIN
  for for_loop in emp
  LOOP
    dbms_output.put_line(for_loop.first_name);
  end loop;
end;

execute CURSOR_PROCEDURE;

--using sysrefcursor
CREATE OR REPLACE PROCEDURE sysrefcursor_proc AS
    emp_cursor SYS_REFCURSOR;
    v_employees employees%rowtype;
BEGIN
    OPEN emp_cursor FOR SELECT * FROM employees;
    
    LOOP
        FETCH emp_cursor INTO v_employees;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_employees.first_name);
    END LOOP;
    
    CLOSE emp_cursor;
END;
/

execute SYSREFCURSOR_PROC;

--using type nested table using procedure;
create or replace PROCEDURE type_procedure as
type simple_type is table of employees%rowtype;
simple_type_proc simple_type;
BEGIN
  select * bulk collect into simple_type_proc from employees;
  for i in 1..simple_type_proc.count loop
  dbms_output.put_line(simple_type_proc(i).first_name);
  end loop;
end;

execute TYPE_PROCEDURE;

--paramters using the procedure;
create or replace procedure param_pro(p_department_id in number)
AS
cursor emp is select * from employees where department_id = p_department_id;
v_employees employees%rowtype;
BEGIN
  open emp;
  LOOP
    fetch emp into v_employees;
    exit when emp%notfound;
    dbms_output.put_line('This is employee id : ' || v_employees.employee_id);
  end loop;
end;     

BEGIN
  PARAM_PRO(50);
end;  

--taking another parameter using procedure;
-- Procedure definition
CREATE OR REPLACE PROCEDURE second_param(p_department_id IN NUMBER, emp_cursor OUT SYS_REFCURSOR) AS
BEGIN
    OPEN emp_cursor FOR
        SELECT * FROM employees WHERE department_id = p_department_id;
END;
/

-- Anonymous block to call the procedure and process the output cursor
DECLARE
    emp_cursor SYS_REFCURSOR;
    v_employees employees%ROWTYPE;
BEGIN
    -- Calling the procedure to populate the cursor with employees from department 50
    second_param(50, emp_cursor);
    
    -- Fetching and printing employee details from the cursor
    LOOP
        FETCH emp_cursor INTO v_employees;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('================================');
        DBMS_OUTPUT.PUT_LINE(v_employees.first_name || ' ' 
                            || v_employees.last_name || ' ' || 
                            v_employees.salary || ' ' || 
                            v_employees.hire_date || ' ' ||
                            v_employees.commission_pct);
        DBMS_OUTPUT.PUT_LINE('================================');

    END LOOP;
    
    -- Closing the cursor
    CLOSE emp_cursor;
END;
/

--insert the values same values are not comming used in procedure;
--create a sequence 
create SEQUENCE my_first_sequence
INCREMENT by 1
start with 100
minvalue 1
maxvalue 100000
cycle
cache 10;

select * from dummy_employees;
--create a procedure
create or replace PROCEDURE proc_8
as
emp_id number;
job_ids VARCHAR2(100) := 'IT_PR,IT_DEV,IT_HR'; -- Define job IDs
job_id_list SYS.ODCIVARCHAR2LIST ; -- Define a list type to hold job IDs
begin
    SELECT REGEXP_SUBSTR(job_ids, '[^,]+', 1, LEVEL)
    BULK COLLECT INTO job_id_list
    FROM dual
    CONNECT BY LEVEL <= REGEXP_COUNT(job_ids, ',') + 1;
for i in 1..5 loop
select my_first_sequence.nextval into emp_id from dual;
INSERT INTO dummy_employees (
            employee_id, 
            first_name, 
            last_name, 
            email, 
            phone_number, 
            hire_date, 
            job_id, 
            salary, 
            commission_pct, 
            manager_id, 
            department_id
        )
        VALUES (
            emp_id, 
            'linked'|| ROUND(DBMS_RANDOM.VALUE(1, 100)), -- Add randomness to first_name
            'list'|| ROUND(DBMS_RANDOM.VALUE(1, 100)),
            'linked.doe'|| ROUND(DBMS_RANDOM.VALUE(1000, 9999)) ||'@example.com', -- Add randomness to email
            TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1000000000, 9999999999))), -- Add randomness to phone_number
            TO_DATE('2025-01-01', 'YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 365)), -- Add randomness to hire_date within the year 2025
            job_id_list(TRUNC(DBMS_RANDOM.VALUE(1, job_id_list.COUNT))), 
            ROUND(DBMS_RANDOM.VALUE(10000, 99999)), -- Add randomness to salary
            ROUND(DBMS_RANDOM.VALUE(1, 100) * 0.01, 2), -- Add randomness to commission_pct
            ROUND(DBMS_RANDOM.VALUE(100, 200)), -- Add randomness to manager_id
            ROUND(DBMS_RANDOM.VALUE(10, 90)) -- Add randomness to department_id
        );
    END LOOP;
END;

execute proc_8;    

select * from dummy_employees;

--same model another code;
--create sequnce for used for procedure
create SEQUENCE Third_sequence
increment by 1
start with 10
minvalue 1
maxvalue 1000000
cycle
cache 10;

---create procedure
CREATE OR REPLACE PROCEDURE proc_11 AS
    emp_id NUMBER;
    job_ids VARCHAR2(200) := 'IT,HR,HCM,HRM';
    job_list SYS.ODCIVARCHAR2LIST;
BEGIN
    -- Split the job_ids string into individual job IDs and store them in job_list
    SELECT REGEXP_SUBSTR(job_ids, '[^,]+', 1, LEVEL)
    BULK COLLECT INTO job_list
    FROM dual
    CONNECT BY LEVEL <= REGEXP_COUNT(job_ids, ',') + 1;

    FOR i IN 1..10 LOOP
        SELECT Third_sequence.nextval INTO emp_id FROM dual;

        INSERT INTO dummy_employees (
            employee_id,
            first_name,
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            commission_pct,
            manager_id,
            department_id
        ) VALUES (
            emp_id,
            'linked' || ROUND(DBMS_RANDOM.VALUE(1, 10000)) || 'list',
            'lost' || ROUND(DBMS_RANDOM.VALUE(1, 10000)) || 'list',
            'linked' || ROUND(DBMS_RANDOM.VALUE(1, 100000)) || '@gmail.com',
            TO_CHAR(ROUND(DBMS_RANDOM.VALUE(11111, 99999))),
            TO_DATE('2023-01-01', 'YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 365)), -- Generate hire date within the year 2023
            job_list(TRUNC(DBMS_RANDOM.VALUE(1, job_list.COUNT))),
            ROUND(DBMS_RANDOM.VALUE(10000, 99999)),
            ROUND(DBMS_RANDOM.VALUE(1, 100) * 0.1, 2),
            ROUND(DBMS_RANDOM.VALUE(100, 9999)),
            ROUND(DBMS_RANDOM.VALUE(1, 9999))
        );
    END LOOP;
    COMMIT;
END;
/

execute proc_11;
select * from dummy_employees
order by employee_id;



