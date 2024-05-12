# minip_basnat
זין בעין
הישויות בהם נעסוק
1. עובדים (Employees):
EmployeeID (מזהה העובד, INT)
First Name (שם פרטי, VARCHAR(50))
Last Name (שם משפחה, VARCHAR(50))
PositionID (מזהה התפקיד, INT)
Salary (משכורת, DECIMAL(10,2))
DepartmentID (מזהה מחלקה, INT)

2. מעמדים (Positions):
PositionID (מזהה התפקיד, INT)
Position Name (כותרת התפקיד, VARCHAR(100))
Responsibilities (אחריות עיקרית, TEXT)
Requirements (דרישות לתפקיד, TEXT)

3. מחלקה(department):
מזהה מחלקה (INT, מזהה ראשי)
שם מחלקה (VARCHAR(100))
תיאור מחלקה (TEXT)
           4.  פיתוח מחלקות(Development):   

 מזהה פיתוח מחלקות (INT, מזהה ראשי)
מזהה מחלקה (INT, מזהה חיצוני לטבלת מחלקה)
סוג יזמה (VARCHAR(100))
תאריך יזמה (DATE)


5. ניהול משאבי אנוש (Human Resource Management):
HRActionID (מזהה פעולת משאבי אנוש, INT PRIMARY KEY)
ActionType (סוג הפעולה, VARCHAR(100))
Date (תאריך, DATE)
Description (תיאור, TEXT)
EmployeeID (מזהה עובד, INT)


6. תאריך (DATE): 
Day(יום, INT)
Month(חודש, INT)
Year(שנה, INT)




סכמות
Employees( EmployeeID , PositionID, DepartmentID, First name, Last name, Salary).
Positions(PositionID,PositionName, Responsibilities, Requirements)
Departments(DepartmentID,DepartmentName, Description)
Development(DevelopmentID,DepartmentID, InitiativeType, InitiativeDate)
Human Resource Management(HRActionID,EmployeeID, ActionType, Date, Description)
Date(Day, Month, Year)




יצירת טבלאות 
CREATE TABLE Employee (
    EmployeeID     NUMBER(38) NOT NULL,
    FirstName      VARCHAR2 NOT NULL,
    LastName1      VARCHAR2 NOT NULL,
    PositionID     NUMBER(38) NOT NULL,
    Salary         NUMBER(38) NOT NULL,
    DepartmentID   NUMBER(38) NOT NULL,
    PositionsID    NUMBER(38) NOT NULL,
    DepartmentID1  NUMBER(38) NOT NULL,
CONSTRAINT pk_Employee PRIMARY KEY (EmployeeID),
CONSTRAINT fk_Employee FOREIGN KEY (PositionsID)
    REFERENCES Positions (PositionsID)
    ON DELETE CASCADE,
CONSTRAINT fk_Employee2 FOREIGN KEY (DepartmentID1)
    REFERENCES Department (DepartmentID)
    ON DELETE CASCADE)
###################################################################
CREATE TABLE Positions (
    PositionsID    NUMBER(38) NOT NULL,
    PositionsName  VARCHAR2 NOT NULL,
    Requirements   LONG NOT NULL,
CONSTRAINT pk_Positions PRIMARY KEY (PositionsID))


###################################################################


CREATE TABLE Department (
    DepartmentID   NUMBER(38) NOT NULL,
    DepartmentName VARCHAR2 NOT NULL,
    Numofworkers   NUMBER(38) NOT NULL,
CONSTRAINT pk_Department PRIMARY KEY (DepartmentID))
 
###################################################################


CREATE TABLE Development (
    DevelopmentID  NUMBER(38) NOT NULL,
    DepartmentID   NUMBER(38) NOT NULL,
    InitiativeType VARCHAR2(100) NOT NULL,
    ImplementationDate DATE NOT NULL,
    DepartmentID1  NUMBER(38),
    Day            NUMBER(38) NOT NULL,
    Month          NUMBER(38) NOT NULL,
    Year           NUMBER(38) NOT NULL,
CONSTRAINT pk_Development PRIMARY KEY (DevelopmentID),
CONSTRAINT fk_Development FOREIGN KEY (DepartmentID1)
    REFERENCES Department (DepartmentID),
CONSTRAINT fk_Development2 FOREIGN KEY (Day,Month,Year)
    REFERENCES Date (Day,Month,Year)
    ON DELETE CASCADE)


###################################################################

CREATE TABLE HumanResourceManagement (
    HRActionID     NUMBER(38) NOT NULL,
    ActionType     VARCHAR2 NOT NULL,
    Date           DATE NOT NULL,
    Day            NUMBER(38) NOT NULL,
    Month          NUMBER(38) NOT NULL,
    Year           NUMBER(38) NOT NULL,
    EmployeeID     NUMBER(38) NOT NULL,
    EmployeeID1    NUMBER(38),
    Description    LONG NOT NULL,
CONSTRAINT pk_HumanResourceManagement PRIMARY KEY (HRActionID),
CONSTRAINT fk_HumanResourceManagement FOREIGN KEY (Day,Month,Year)
    REFERENCES Date (Day,Month,Year),
CONSTRAINT fk_HumanResourceManagement2 FOREIGN KEY (EmployeeID1)
    REFERENCES Employee (EmployeeID))




###################################################################


CREATE TABLE Date (
    Day            NUMBER(38) NOT NULL,
    Month          NUMBER(38) NOT NULL,
    Year           NUMBER(38) NOT NULL,
CONSTRAINT pk_Date PRIMARY KEY (Day,Month,Year))


