-- ����� ��� ��� (Seniority) ����� Employee
ALTER TABLE Employee
ADD Seniority NUMBER(2);

-- ����� ������ ������� �� ����� ��������� ���� ��� ����� (Seniority)
UPDATE Employee
SET Seniority = ROUND(DBMS_RANDOM.VALUE(1, 30));

-- ���� ������� ���� ������
--SELECT EmployeeID, First_Name, Last_Name, salary, Seniority
--FROM Employee;
