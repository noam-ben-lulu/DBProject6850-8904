CREATE OR REPLACE PROCEDURE ReassignEmployeeToDevelopment(
    employee_id NUMBER,
    current_department_id NUMBER,
    target_department_id NUMBER
) 
IS
BEGIN
    -- �� ����� ���� ���� ������ �������, ����� �����
    IF target_department_id = current_department_id THEN
        DELETE FROM Employee
        WHERE EmployeeID = employee_id AND DepartmentID = current_department_id;
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employee_id || ' has been deleted from Department ID: ' || current_department_id);
    ELSE
        -- ����, ����� ����� ����
        UPDATE Employee
        SET DepartmentID = target_department_id
        WHERE EmployeeID = employee_id AND DepartmentID = current_department_id;
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employee_id || ' has been reassigned from Department ID: ' || current_department_id || ' to Department ID: ' || target_department_id);
    END IF;

    -- ����� ��������
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ReassignEmployeeToDevelopment: ' || SQLERRM);
        ROLLBACK; -- ����� �������� ����� �� �����
END;
/
