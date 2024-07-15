-- מבט ראשון על האגף שלנו
CREATE VIEW Employee_Initiatives_View AS
SELECT 
    e.EmployeeID, 
    e.First_Name, 
    e.Last_Name, 
    d.departmentName, 
    p.PositionsName,
    dev.initiative_type,
    dev.initiative_date
FROM 
    Employee e
JOIN 
    department d ON e.DepartmentID = d.departmentID
JOIN 
    Positions p ON e.PositionID = p.PositionsID
JOIN 
    Development dev ON e.DepartmentID = dev.departmentID;
--שאילתה ראשונה מבט ראשון
SELECT * FROM Employee_Initiatives_View
WHERE initiative_type ='&initiative_type';
-- שאילתה שנייה מבט ראשון
SELECT * FROM Employee_Initiatives_View
WHERE initiative_date >= ADD_MONTHS(SYSDATE, -12);
-- מבט שני על האגף שקיבלנו
CREATE VIEW Account_Transactions_View AS
SELECT 
    a.Account_ID, 
    a.Customer_ID, 
    a.Account_Type, 
    a.Balance, 
    a.Account_Opening_Date, 
    t.Transaction_ID, 
    t.Amount, 
    t.Transaction_Date
FROM 
    Accounts a
JOIN 
    Transactions t ON a.Account_ID = t.Account_ID;
--שאילתה ראשונה מבט שני
SELECT * FROM Account_Transactions_View
WHERE Account_ID ='&Account_ID';
--שאילתה שנייה מבט שני
WITH Debt AS (
    SELECT SUM(Balance) AS Total_Debt
    FROM Accounts
    WHERE Balance < 0
),
Credit AS (
    SELECT SUM(Balance) AS Total_Credit
    FROM Accounts
    WHERE Balance > 0
)
SELECT 
    d.Total_Debt, 
    c.Total_Credit,
    CASE 
        WHEN ABS(d.Total_Debt) > c.Total_Credit THEN 'More people owe money to the bank'
        ELSE 'The bank owes more money to the people'
    END AS Financial_Status
FROM 
    Debt d, 
    Credit c;
