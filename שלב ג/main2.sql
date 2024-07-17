DECLARE
    development_id NUMBER;
    employee_id NUMBER;
    current_department_id NUMBER;
    target_department_id NUMBER;
    emp_dev_cursor SYS_REFCURSOR;
    emp_id Employee.EmployeeID%TYPE;
    first_name Employee.First_Name%TYPE;
    last_name Employee.Last_Name%TYPE;
    salary Employee.salary%TYPE;
    department_id Employee.DepartmentID%TYPE;
    make_changes CHAR(1);
    show_details  CHAR(1);
    
    CURSOR development_cursor IS
        SELECT DevelopmentID FROM Development;

BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
    -- שאלת המשתמש אם הוא רוצה לבצע שינויים
    make_changes := '&Make_Changes';
    
    IF make_changes = 'Y' THEN
       DBMS_OUTPUT.PUT_LINE('wanna make changes');
        -- בקשת פרטי העברת עובד
        employee_id := &Enter_Employee_ID;
        current_department_id := &Enter_Current_Department_ID;
        target_department_id := &Enter_Target_Department_ID;

        IF employee_id IS NOT NULL AND current_department_id IS NOT NULL AND target_department_id IS NOT NULL THEN
            ReassignEmployeeToDevelopment(employee_id, current_department_id, target_department_id);
        END IF;
    END IF;
    
    show_details := '&show_details';
    
    IF show_details = 'Y' THEN
        DBMS_OUTPUT.PUT_LINE('Starting to manage development assignments.');

        -- לולאה על כל יוזמות הפיתוח
        FOR dev_record IN development_cursor LOOP
            development_id := dev_record.DevelopmentID;

            -- קבלת רשימת העובדים וסכום המשכורות ליוזמת הפיתוח
            emp_dev_cursor := GetEmployeesByDevelopment(development_id);
            
            -- סגירת הקורסור
            CLOSE emp_dev_cursor;

            -- ריקון המאגר לאחר כל איטרציה של הלולאה
            DBMS_OUTPUT.NEW_LINE;
        END LOOP;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Finished managing development assignments.');
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
