
CREATE OR REPLACE FUNCTION GetEmployeesByDevelopment(development_id NUMBER) 
RETURN SYS_REFCURSOR 
IS
    emp_dev_ref_cursor SYS_REFCURSOR; -- Ref Cursor to return employee data
BEGIN
    OPEN emp_dev_ref_cursor FOR
        SELECT e.EmployeeID, e.First_Name, e.Last_Name, e.salary, e.DepartmentID
        FROM Employee e
        JOIN Development d ON e.DepartmentID = d.departmentID
        WHERE d.DevelopmentID = development_id;
    RETURN emp_dev_ref_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in GetEmployeesByDevelopment: ' || SQLERRM);
        RETURN NULL;
END;
/
