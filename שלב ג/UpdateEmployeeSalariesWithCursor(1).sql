CREATE OR REPLACE PROCEDURE UpdateEmployeeSalariesWithCursor(
    emp_ref_cursor SYS_REFCURSOR,
    base_salary NUMBER
) 
IS
    
    emp_id Employee.EmployeeID%TYPE;
    salary Employee.Salary%TYPE;
    seniority Employee.Seniority%TYPE;
    new_salary Employee.Salary%TYPE;
BEGIN

    
    
    LOOP
        FETCH emp_ref_cursor INTO emp_id, salary, seniority;
        EXIT WHEN emp_ref_cursor%NOTFOUND;
        
        
        
        -- Update salary based on seniority
        IF seniority BETWEEN 1 AND 3 THEN
            new_salary := base_salary;
        ELSIF seniority BETWEEN 4 AND 7 THEN
            new_salary := base_salary * 1.15;
        ELSIF seniority BETWEEN 8 AND 15 THEN
            new_salary := base_salary * 1.25;
        ELSIF seniority BETWEEN 16 AND 22 THEN
            new_salary := base_salary * 1.33;
        ELSIF seniority BETWEEN 23 AND 29 THEN
            new_salary := base_salary * 1.4;
        ELSIF seniority = 30 THEN
            new_salary := base_salary * 1.5;
        END IF;
        
        -- Update the employee's salary
        UPDATE Employee
        SET salary = new_salary
        WHERE EmployeeID = emp_id;
        
        DBMS_OUTPUT.PUT_LINE('Updated salary for Employee ID: ' || emp_id || ' to ' || new_salary);
    END LOOP;
    
    -- Close the cursor
    CLOSE emp_ref_cursor;


    -- Commit the changes
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rollback in case of error
END;
/
