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

--



