DECLARE
    dept_id NUMBER;
    base_salary NUMBER := &Enter_Base_Salary;
    emp_cursor SYS_REFCURSOR;

    CURSOR dept_cursor IS
        SELECT departmentID FROM department;
    
BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.PUT_LINE('Starting the main: Update all the salaries in the database.');

    -- לולאה על כל המחלקות
    FOR dept_record IN dept_cursor LOOP
        dept_id := dept_record.departmentID;

        -- קריאה לפונקציה GetEmployeesByDepartment
        emp_cursor := GetEmployeesByDepartment(dept_id);

        -- קריאה לפרוצדורה לעדכון המשכורות
        UpdateEmployeeSalariesWithCursor(emp_cursor, base_salary); -- Update salary based on seniority and base salary

        DBMS_OUTPUT.PUT_LINE('Employee salaries updated for Department ' || dept_id || '.');
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
