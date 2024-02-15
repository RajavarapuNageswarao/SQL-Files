--this is one type of model.
set SERVEROUTPUT on
DECLARE
cursor emp is select * from employees;
v_employees employees%rowtype;
BEGIN
  open emp;
  LOOP
    fetch emp into v_employees;
    exit when emp%notfound;
    dbms_output.put_line(v_employees.first_name||'' ||v_employees.last_name);
  end LOOP;
end;

--this is another type of model;
--This is used dbms_output prints to the used.
set SERVEROUTPUT on
DECLARE
--declare the cursor
--cursor emp is select * from employees;
BEGIN
  for i in (select * from employees) LOOP
  dbms_output.put_line(i.first_name || '' || i.last_name);
  end LOOP;
end;

--this is another type of model;
DECLARE
cursor emp is select * from employees;
v_employees employees%rowtype;
BEGIN
  BEGIN
    open emp;
    LOOP
      fetch emp INTO v_employees;
      exit when emp%notfound;
      dbms_output.put_line(v_employees.first_name || '' || v_employees.last_name);
    end loop;

    if salary > 5000 THEN
    update EMPLOYEES set salary = salary + 500;
    elsif salary < 5000 THEN
    update employees set salary = salary + 500;
    else
    COMMIT;
    end if;
    EXCEPTION
    when others THEN
    dbms_output.put_line('update the table successfully');
    close emp;
  end;
end;

--use paramter cursor
set SERVEROUTPUT on
DECLARE
cursor emp(p_department_id number,p_job_id VARCHAR2,v_salary number) is select * from employees
where department_id = p_department_id and job_id = p_job_id and salary < v_salary;
v_employees employees%rowtype;
p_boolean BOOLEAN := FALSE;
BEGIN
  open emp(50,'ST_CLERK',3000);
  LOOP
  fetch emp into v_employees;
  exit when emp%notfound;
  p_boolean := TRUE;
  dbms_output.put_line(v_employees.first_name || ' ' ||v_employees.last_name);
  end loop;
  close emp;
  if not p_boolean THEN
  dbms_output.put_line('Wow you take paramters combination there is NO employees found !!!!');
  end if;
end;
--using syscursor
DECLARE
emp_cursor SYS_REFCURSOR;
v_employees employees%rowtype;
BEGIN
  open emp_cursor for select * from employees;
  loop
  fetch emp_cursor into v_employees;
  exit when emp_cursor%notfound;
  dbms_output.put_line(v_employees.first_name|| ''  || v_employees.last_name);
  end loop;
  close emp_cursor;
end; 

--type using inside the cursor;
DECLARE
type emp_cursor_type IS REF CURSOR;
emp_cursor_tab  emp_cursor_type;
v_employees employees%rowtype;
BEGIN
  open emp_cursor_tab for select * from employees;
  LOOP
    fetch emp_cursor_tab into v_employees;
    exit when emp_cursor_tab%notfound;
    dbms_output.put_line(v_employees.first_name || ' ' ||v_employees.last_name);
  end loop;
  EXCEPTION
  when others THEN
  dbms_output.put_line('NO data found for');
end;  

--using bulk collect
declare
type emp_array is table of employees%rowtype;
emp_array_another emp_array;
BEGIN
  select * bulk collect into emp_array_another from employees;
  for i in 1..emp_array_another.count loop
  dbms_output.put_line(emp_array_another(i).employee_id);
  end loop;
end;  

--All models combined one cursor
DECLARE
--cursor fetching the records
cursor emp is select * from employees;
v_employees employees%rowtype;

--nested table creation of 
type emp_nt is table of employees%rowtype;
emp_array emp_nt;

BEGIN

  --method 1 retriving the cursor
  open emp;
  LOOP
    fetch emp into v_employees;
    exit when emp%notfound;
    dbms_output.put_line('This is cursor : ' || v_employees.first_name);
  end loop;
  close emp;

  --method 2 retriving the record of nested table
  select * bulk collect into emp_array from employees;
  for i in 1..emp_array.count 
  loop
     dbms_output.put_line('This is nested table : ' || emp_array(i).first_name );
  end loop;

  --method 3 retriving the for loop
  for i in emp 
  LOOP
    dbms_output.put_line('This is for loop using cursor :' || i.first_name);
  end loop;

  --method 4 retriving the implicit cursor;
  for implicit_cursor in (select * from employees)
  LOOP
    dbms_output.put_line('This is implicit cursor :' || implicit_cursor.first_name);
  end loop;
END;      



