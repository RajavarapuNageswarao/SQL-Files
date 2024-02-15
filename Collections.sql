--collections are used in nested tables
set SERVEROUTPUT on
DECLARE
type nested_table is table of employees%rowtype;
my_table nested_table := nested_table();
i  number := 1;
BEGIN
  for emp in (select * from employees) LOOP
  my_table.extend;
  my_table(i) := emp;
  i := i+1;
  end LOOP;
  for j in 1..my_table.count LOOP
  dbms_output.put_line(my_table(j).first_name || '  ' || my_table(j).last_name);
  end LOOP;
end;

--this is second way of collections
-- Creating a nested table type
CREATE OR REPLACE TYPE first_type IS TABLE OF VARCHAR2(200);
/

-- Creating a table with a nested table column
CREATE TABLE my_objects (
    stu_id NUMBER,
    sub_name VARCHAR2(200),
    total_table first_type
) NESTED TABLE total_table STORE AS total_table_storage;

-- Inserting data into the main table
INSERT INTO my_objects (stu_id, sub_name, total_table) VALUES (1, 'Math', first_type('A', 'B', 'C'));
INSERT INTO my_objects (stu_id, sub_name, total_table) VALUES (2, 'Science', first_type('B', 'C', 'D'));

--update the statements
update my_objects set total_table  = total_table multiset union all first_type('D','E','F')
where stu_id = 1;

--show the results
DECLARE
    nested_table first_type;
BEGIN
    SELECT total_table
    INTO nested_table
    FROM my_objects
    WHERE stu_id = 1;

    FOR i IN 1..nested_table.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(nested_table(i));
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for stu_id = 1');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Too many rows found for stu_id = 1');
END;
/


-- LINE/COL  ERROR
-- --------- -------------------------------------------------------------
-- 0/0       PL/SQL: Compilation unit analysis terminated
-- 1/38      PLS-00329: schema-level type has illegal reference to HR.EMPLOYEES
-- Errors: check compiler log
--normal you can use this you can create object.
--Another way of example of collections creation
-- Define a collection type based on the structure of the employees table
CREATE OR REPLACE TYPE employee_type AS OBJECT (
    employee_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    hire_date DATE
);
/

-- Define a nested table type using the previously defined object type
CREATE OR REPLACE TYPE employee_table_type AS TABLE OF employee_type;
/

-- Declare a variable of the nested table type
DECLARE
    emp_table employee_table_type;
BEGIN
    -- Populate the nested table with data from the employees table
    SELECT employee_type(employee_id, first_name, last_name, email, hire_date)
    BULK COLLECT INTO emp_table
    FROM employees;

    -- Print the data from the nested table
    FOR i IN 1..emp_table.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_table(i).employee_id || ', Name: ' || emp_table(i).first_name || ' ' || emp_table(i).last_name || ', Email: ' || emp_table(i).email || ', Hire Date: ' || emp_table(i).hire_date);
    END LOOP;
END;
/
