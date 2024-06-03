-- 1 - הכנסת תאריך מסוים וקבלת הנתונים על כל העובדים שנכחו באותו תאריך (תעודת זהות העובד , שם העובד , משכורת ומחלקה שעובד בה)
SELECT 
    E.EmployeeID, 
    E.First_Name, 
    E.Last_Name, 
    E.salary, 
    D.departmentName
FROM 
    Employee E
JOIN 
    department D ON E.DepartmentID = D.departmentID
JOIN 
    Attendance A ON E.EmployeeID = A.EmployeeID
WHERE 
    A.Aten_Date = TO_DATE('&attendance_date', 'YYYY-MM-DD') 
    AND A.Status = 'Present'
;

-- 2 -   בהחזרת כל הפרטים על עובד מסוים כאשר הקלט הוא שם העובד המבוקש (נקבל את המשכורת שלו , המחלקה שלו סוג היוזמה שהוא ביצע התאריך שהוא ביצע וכמובן הפעולות שהוא ביצע והתאריך שהוא ביצע) 
SELECT
    E.EmployeeID, E.First_Name, E.Last_Name,  E.salary, 
    D.departmentName, 
    DEV.initiative_type, DEV.initiative_date, 
    HRM.ActionType, HRM.HRA_Date, HRM.Description
FROM
    Employee E
JOIN
    department D ON E.DepartmentID = D.departmentID
LEFT JOIN
    Development DEV ON D.departmentID = DEV.departmentID
LEFT JOIN
    Human_Resource_Management HRM ON E.EmployeeID = HRM.EmployeeID
WHERE
    E.First_Name = '&firstName'
    AND E.Last_Name = '&lastName'
ORDER BY
    DEV.initiative_date DESC,
    HRM.HRA_Date DESC;

-- 3 -החזרת מספרי עובדים של מחלקה מסוימת והמשכורת הממצועת של המחלקה כאשר הפמרטר הנקלט יכול להיות גם רשימה של מחלקות
SELECT
    D.departmentName,
    COUNT(E.EmployeeID) AS NumOfEmployees,
    AVG(E.salary) AS AvgSalary
FROM
    Employee E
JOIN
    department D ON E.DepartmentID = D.departmentID
WHERE
    D.departmentName IN (&departmentList)
GROUP BY
    D.departmentName
ORDER BY
    D.departmentName;

-- 4 -קבלת שם משרה והחזרה של המשכורת המינימלית והמקסימלית שמקבלים במשרה הזו( כמובן על סמך העובדים שעובדים שם נכון לעת ביצוע הפעולה..)
SELECT
    P.PositionsName,
    MIN(E.salary) AS MinSalary,
    MAX(E.salary) AS MaxSalary
FROM
    Employee E
JOIN
    Positions P ON E.PositionID = P.PositionsID
WHERE
    P.PositionsName = '&positionName'
GROUP BY
    P.PositionsName;
