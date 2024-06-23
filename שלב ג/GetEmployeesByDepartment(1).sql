CREATE OR REPLACE FUNCTION GetEmployeesByDepartment(dept_id NUMBER) 
RETURN SYS_REFCURSOR 
IS
    emp_ref_cursor SYS_REFCURSOR; -- Ref Cursor to return employee data
BEGIN
    

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
