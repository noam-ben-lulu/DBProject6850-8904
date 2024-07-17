CREATE OR REPLACE FUNCTION GetEmployeesByDevelopment(development_id NUMBER) 
RETURN SYS_REFCURSOR 
IS
    emp_dev_ref_cursor SYS_REFCURSOR; -- Ref Cursor to return employee data
    emp_id Employee.EmployeeID%TYPE;
    first_name Employee.First_Name%TYPE;
    last_name Employee.Last_Name%TYPE;
    salary Employee.salary%TYPE;
    department_id Employee.DepartmentID%TYPE;
    total_salary NUMBER := 0;
    has_employees BOOLEAN := FALSE;
BEGIN
    OPEN emp_dev_ref_cursor FOR
        SELECT e.EmployeeID, e.First_Name, e.Last_Name, e.salary, e.DepartmentID
        FROM Employee e
        JOIN Development d ON e.DepartmentID = d.departmentID
        WHERE d.DevelopmentID = development_id;
    
    -- הצגת העובדים הקיימים ביוזמת הפיתוח וחישוב סכום המשכורות
    LOOP
        FETCH emp_dev_ref_cursor INTO emp_id, first_name, last_name, salary, department_id;
        EXIT WHEN emp_dev_ref_cursor%NOTFOUND;
        IF NOT has_employees THEN
            DBMS_OUTPUT.PUT_LINE('Employees in Development ' || development_id || ':');
            has_employees := TRUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_id || ', Name: ' || first_name || ' ' || last_name || ', Salary: ' || salary || ', Department ID: ' || department_id);
        total_salary := total_salary + salary; -- חישוב סכום המשכורות
    END LOOP;

    -- סגירת ה-cursor כדי שנוכל לפתוח אותו שוב להחזרה
    CLOSE emp_dev_ref_cursor;

    -- פתיחת ה-cursor שוב להחזרה
    OPEN emp_dev_ref_cursor FOR
        SELECT e.EmployeeID, e.First_Name, e.Last_Name, e.salary, e.DepartmentID
        FROM Employee e
        JOIN Development d ON e.DepartmentID = d.departmentID
        WHERE d.DevelopmentID = development_id;

    -- הדפסת סכום המשכורות הכולל אם יש עובדים
    IF has_employees THEN
        DBMS_OUTPUT.PUT_LINE('Total Salary for Development ' || development_id || ': ' || total_salary);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No employees found in Development ' || development_id || '.');
    END IF;

    RETURN emp_dev_ref_cursor;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in GetEmployeesByDevelopment: ' || SQLERRM);
        RETURN NULL;
END;
/
