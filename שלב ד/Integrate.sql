-- קשר בין עובד לחשבונות
ALTER TABLE Accounts ADD (EmployeeID INT);
ALTER TABLE Accounts ADD CONSTRAINT fk_Accounts_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);
BEGIN
    FOR rec IN (SELECT Account_ID, EmployeeID
                FROM (SELECT a.Account_ID, e.EmployeeID,
                             ROW_NUMBER() OVER (PARTITION BY a.Account_ID ORDER BY DBMS_RANDOM.VALUE) AS rnd
                      FROM Accounts a, Employee e)
                WHERE rnd = 1)
    LOOP
        UPDATE Accounts
        SET EmployeeID = rec.EmployeeID
        WHERE Account_ID = rec.Account_ID;
        COMMIT;
    END LOOP;
END;
SELECT * FROM Accounts;
--קשר בין עובד לכרטיסי אשראי
ALTER TABLE Credit_Cards ADD (EmployeeID INT);
ALTER TABLE Credit_Cards ADD CONSTRAINT fk_Credit_Cards_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);


BEGIN
    FOR rec IN (SELECT Card_ID, EmployeeID
                FROM (SELECT c.Card_ID, e.EmployeeID,
                             ROW_NUMBER() OVER (PARTITION BY c.Card_ID ORDER BY DBMS_RANDOM.VALUE) AS rnd
                      FROM Credit_Cards c, Employee e)
                WHERE rnd = 1)
    LOOP
        UPDATE Credit_Cards
        SET EmployeeID = rec.EmployeeID
        WHERE Card_ID = rec.Card_ID;
        COMMIT;
    END LOOP;
END;
SELECT * FROM Credit_Cards;
-- קשר בין מחלקה להלוואות
ALTER TABLE Loans ADD (DepartmentID INT);
ALTER TABLE Loans ADD CONSTRAINT fk_Loans_Department FOREIGN KEY (DepartmentID) REFERENCES department(departmentID);

BEGIN
    FOR rec IN (SELECT Loan_ID, DepartmentID
                FROM (SELECT l.Loan_ID, d.departmentID,
                             ROW_NUMBER() OVER (PARTITION BY l.Loan_ID ORDER BY DBMS_RANDOM.VALUE) AS rnd
                      FROM Loans l, department d)
                WHERE rnd = 1)
    LOOP
        UPDATE Loans
        SET DepartmentID = rec.departmentID
        WHERE Loan_ID = rec.Loan_ID;
        COMMIT;
    END LOOP;
END;
/
SELECT * FROM Loans;
--קשר בין עובד לפקדונות
ALTER TABLE Deposits ADD (EmployeeID INT);
ALTER TABLE Deposits ADD CONSTRAINT fk_Deposits_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);

BEGIN
    FOR rec IN (SELECT DepositID, EmployeeID
                FROM (SELECT d.DepositID, e.EmployeeID,
                             ROW_NUMBER() OVER (PARTITION BY d.DepositID ORDER BY DBMS_RANDOM.VALUE) AS rnd
                      FROM Deposits d, Employee e)
                WHERE rnd = 1)
    LOOP
        UPDATE Deposits
        SET EmployeeID = rec.EmployeeID
        WHERE DepositID = rec.DepositID;
        COMMIT;
    END LOOP;
END;
/
SELECT * FROM Deposits;
