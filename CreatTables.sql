CREATE TABLE Positions (
    PositionsID     NUMBER(38) NOT NULL,
    PositionsName  VARCHAR2(255) NOT NULL,
    Requirements   LONG NOT NULL,
    CONSTRAINT pk_Positions PRIMARY KEY (PositionID)
)
/

CREATE TABLE department (
    departmentID   NUMBER(38) NOT NULL,
    departmentName VARCHAR2(255) NOT NULL,
    Description    LONG NOT NULL,
    CONSTRAINT pk_department PRIMARY KEY (departmentID)
)
/

CREATE TABLE Employee (
    EmployeeID     NUMBER(38) NOT NULL,
    PositionID     NUMBER(38) NOT NULL,
    First_Name     VARCHAR2(255) NOT NULL,
    Last_Name      VARCHAR2(255) NOT NULL,
    DepartmentID   NUMBER(38) NOT NULL,
    salary         NUMBER(38) NOT NULL,
    CONSTRAINT pk_Employee PRIMARY KEY (EmployeeID),
    CONSTRAINT fk_Employee_Position FOREIGN KEY (PositionID)
        REFERENCES Positions (PositionID)
        ON DELETE CASCADE,
    CONSTRAINT fk_Employee_Department FOREIGN KEY (DepartmentID)
        REFERENCES department (departmentID)
        ON DELETE CASCADE
)
/

CREATE TABLE Development (
    DevelopmentID  NUMBER(38) NOT NULL,
    departmentID   NUMBER(38) NOT NULL,
    initiative_type VARCHAR2(255) NOT NULL,
    initiative_date DATE NOT NULL,
    CONSTRAINT pk_Development PRIMARY KEY (DevelopmentID),
    CONSTRAINT fk_Development FOREIGN KEY (departmentID)
        REFERENCES department (departmentID)
)
/

CREATE TABLE Human_Resource_Management (
    HRActionID     NUMBER(38) NOT NULL,
    ActionType     VARCHAR2(255) NOT NULL,
    HRA_Date       DATE NOT NULL,
    Description    LONG NOT NULL,
    EmployeeID     NUMBER(38) NOT NULL,
    CONSTRAINT pk_Human_Resource_Management PRIMARY KEY (HRActionID),
    CONSTRAINT fk_Human_Resource_Management FOREIGN KEY (EmployeeID)
        REFERENCES Employee (EmployeeID)
        ON DELETE CASCADE
)
/

CREATE TABLE Attendance (
    EmployeeID     NUMBER(38) NOT NULL,
    Aten_Date      DATE NOT NULL,
    Status         VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_Attendance PRIMARY KEY (EmployeeID, Aten_Date),
    CONSTRAINT fk_Attendance FOREIGN KEY (EmployeeID)
        REFERENCES Employee (EmployeeID)
)
/
