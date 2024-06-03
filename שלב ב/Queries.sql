-- Select Queries
-- 1 -השאילתה מחזירה את שמות העובדים, המחלקה שלהם והמשכורת, ממיינת לפי שם המחלקה ולאחר מכן לפי המשכורת בסדר יורד
SELECT E.EmployeeID, E.First_Name, E.Last_Name, D.departmentName, E.salary
FROM Employee E
JOIN department D ON E.DepartmentID = D.departmentID
ORDER BY D.departmentName, E.salary DESC;
-- 2 -השאילתה מחזירה את ימי הנוכחות של כל עובד ממוינת לפי ימי הנוכחות בסדר יורד ( כלומר בהתחלה נראה את כל מי שהיה מספר ימים הכי גבוה)
SELECT E.EmployeeID, E.First_Name, E.Last_Name, COUNT(A.Aten_Date) AS AttendanceCount
FROM Employee E
JOIN Attendance A ON E.EmployeeID = A.EmployeeID
GROUP BY E.EmployeeID, E.First_Name, E.Last_Name
ORDER BY AttendanceCount DESC;
-- 3 -השאילתה הזו מחזירה לנו בעצם את מספר העובדים שנכחו בכל חודש בכל שנה( לדוגמא כפי שניתן לראות בשנת 2020 בחודש ינואר (1) נכחו 6 עובדים וכן על זאת הדרך..)
SELECT
    EXTRACT(YEAR FROM A.Aten_Date) AS Year,
    EXTRACT(MONTH FROM A.Aten_Date) AS Month,
    COUNT(A.EmployeeID) AS EmployeeCount
FROM Attendance A
GROUP BY EXTRACT(YEAR FROM A.Aten_Date), EXTRACT(MONTH FROM A.Aten_Date)
ORDER BY Year, Month;
-- 4 -השאילתה בעצם מראה לנו את ממוצע המשכורות של כל מחלקה התוצאה היא שם המחלקה מספר העובדים בה וממוצע המשכורות של העובדים במחלקה
SELECT D.departmentName,
       COUNT(E.EmployeeID) AS EmployeeCount,
       AVG(E.salary) AS AvgSalary
FROM Employee E
JOIN department D ON E.DepartmentID = D.departmentID
GROUP BY D.departmentName
ORDER BY AvgSalary DESC;

-- Delete Queries
-- 1 - מחיקת כל העובדים שלא ביצעו שום יוזמה (initiative) בטבלת Development

DELETE FROM Employee
WHERE EmployeeID NOT IN (
    SELECT DISTINCT E.EmployeeID
    FROM Employee E
    JOIN Development D ON E.DepartmentID = D.departmentID
);
-- 2 -מחיקת כל העובדים שאין לנו עליהם רישום בטבלת נוכחות שלנו
DELETE FROM Employee
WHERE EmployeeID NOT IN (
    SELECT DISTINCT A.EmployeeID
    FROM Attendance A
);
-- Update Queries
-- 1 - עדכון משכורת של עובדים במחלקת HR ב-10% בעקבות עבודתם הקשה בפרויקט
UPDATE Employee
SET salary = salary * 1.1
WHERE DepartmentID IN (
    SELECT departmentID
    FROM department
    WHERE departmentName = 'Human Resources'
);
-- 2 - עדכון נוכחות לעובד שנרשם לו חיסור בתאריך 19.04.21 ושינוי רישום לזה שהוא היה כמובן שאפשר לשנות את התאריך לכל תאריך לבחירתו של המנהל
UPDATE Attendance
SET Status = 'Present'
WHERE Aten_Date = DATE '2021-04-19';
