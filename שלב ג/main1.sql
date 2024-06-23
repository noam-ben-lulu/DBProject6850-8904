DECLARE
    dept_id NUMBER;
    base_salary NUMBER := &Enter_Base_Salary;
    emp_cursor SYS_REFCURSOR;
    emp_id Employee.EmployeeID%TYPE;
    salary Employee.Salary%TYPE;
    seniority Employee.Seniority%TYPE;
    has_employees BOOLEAN := FALSE;
    
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
        has_employees := FALSE;  -- אתחול המשתנה לכל מחלקה חדשה

        -- סריקת ה-cursor והדפסת נתונים
        LOOP
            FETCH emp_cursor INTO emp_id, salary, seniority;
            EXIT WHEN emp_cursor%NOTFOUND;
            IF NOT has_employees THEN
                DBMS_OUTPUT.PUT_LINE('Employees in Department ' || dept_id || ':');
                has_employees := TRUE;
            END IF;
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_id || ', Salary: ' || salary || ', Seniority: ' || seniority);
        END LOOP;

        -- סגור את ה-cursor כדי למנוע שגיאות בעת קריאה לפרוצדורה
        CLOSE emp_cursor;

        -- אם יש עובדים במחלקה, קריאה לפרוצדורה לעדכון המשכורות
        IF has_employees THEN
            emp_cursor := GetEmployeesByDepartment(dept_id);

            -- קריאה לפרוצדורה UpdateEmployeeSalariesWithCursor
            UpdateEmployeeSalariesWithCursor(emp_cursor, base_salary); -- Update salary based on seniority and base salary

            DBMS_OUTPUT.PUT_LINE('Employee salaries updated for Department ' || dept_id || '.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No employees found in Department ' || dept_id || '.');
        END IF;
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
