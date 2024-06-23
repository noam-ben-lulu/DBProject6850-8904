-- הוספת שדה ותק (Seniority) לטבלת Employee
ALTER TABLE Employee
ADD Seniority NUMBER(2);

-- עדכון הערכים הקיימים עם ערכים רנדומליים עבור שדה הוותק (Seniority)
UPDATE Employee
SET Seniority = ROUND(DBMS_RANDOM.VALUE(1, 30));

-- הצגת הנתונים לאחר העדכון
--SELECT EmployeeID, First_Name, Last_Name, salary, Seniority
--FROM Employee;
