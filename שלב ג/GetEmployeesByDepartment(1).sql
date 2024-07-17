CREATE OR REPLACE FUNCTION GetEmployeesByDepartment(dept_id NUMBER) 
RETURN SYS_REFCURSOR 
IS
    emp_ref_cursor SYS_REFCURSOR; -- Ref Cursor to return employee data
    emp_id Employee.EmployeeID%TYPE;
    salary Employee.Salary%TYPE;
    seniority Employee.Seniority%TYPE;
    has_employees BOOLEAN := FALSE;
BEGIN
    OPEN emp_ref_cursor FOR
        SELECT EmployeeID, Salary, Seniority 
        FROM Employee 
        WHERE DepartmentID = dept_id;
    
    -- הצגת העובדים הקיימים במחלקה
    LOOP
        FETCH emp_ref_cursor INTO emp_id, salary, seniority;
        EXIT WHEN emp_ref_cursor%NOTFOUND;
        IF NOT has_employees THEN
            DBMS_OUTPUT.PUT_LINE('Employees in Department ' || dept_id || ':');
            has_employees := TRUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_id || ', Salary: ' || salary || ', Seniority: ' || seniority);
    END LOOP;
    
    -- סגירת ה-cursor כדי שנוכל לפתוח אותו שוב להחזרה
    CLOSE emp_ref_cursor;

    -- פתיחת ה-cursor שוב להחזרה
    OPEN emp_ref_cursor FOR
        SELECT EmployeeID, Salary, Seniority 
        FROM Employee 
        WHERE DepartmentID = dept_id;
    
    RETURN emp_ref_cursor;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in GetEmployeesByDepartment: ' || SQLERRM);
        RETURN NULL;
END;
/
