CREATE TABLE Employee (
    EmployeeID     NUMBER(38) NOT NULL,
    FirstName      VARCHAR2(255) NOT NULL,
    LastName1      VARCHAR2(255) NOT NULL,
    PositionsID     NUMBER(38) NOT NULL,
    Salary         NUMBER(38) NOT NULL,
    DepartmentID   NUMBER(38) NOT NULL,
    CONSTRAINT pk_Employee PRIMARY KEY (EmployeeID),
    CONSTRAINT fk_Employee FOREIGN KEY (PositionsID)
        REFERENCES Positions (PositionsID)
        ON DELETE CASCADE,
    CONSTRAINT fk_Employee2 FOREIGN KEY (DepartmentID1)
        REFERENCES Department (DepartmentID)
        ON DELETE CASCADE
);

CREATE TABLE Positions (
    PositionsID    NUMBER(38) NOT NULL,
    PositionsName  VARCHAR2(255) NOT NULL,
    Requirements   LONG NOT NULL,
    CONSTRAINT pk_Positions PRIMARY KEY (PositionsID)
);

CREATE TABLE Department (
    DepartmentID   NUMBER(38) NOT NULL,
    DepartmentName VARCHAR2(255) NOT NULL,
    Numofworkers   NUMBER(38) NOT NULL,
    CONSTRAINT pk_Department PRIMARY KEY (DepartmentID)
);

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
        REFERENCES Department (DepartmentID)
        ON DELETE CASCADE,
    CONSTRAINT fk_Development2 FOREIGN KEY (Day, Month, Year)
        REFERENCES DateInfo (Day, Month, Year)
        ON DELETE CASCADE
);

CREATE TABLE HumanResourceManagement (
    HRActionID     NUMBER(38) NOT NULL,
    ActionType     VARCHAR2(255) NOT NULL,
    DateInfo           DATE NOT NULL,
    Day            NUMBER(38) NOT NULL,
    Month          NUMBER(38) NOT NULL,
    Year           NUMBER(38) NOT NULL,
    EmployeeID     NUMBER(38) NOT NULL,
    EmployeeID1    NUMBER(38),
    Description    LONG NOT NULL,
    CONSTRAINT pk_HumanResourceManagement PRIMARY KEY (HRActionID),
    CONSTRAINT fk_HumanResourceManagement FOREIGN KEY (Day, Month, Year)
        REFERENCES DateInfo (Day, Month, Year)
        ON DELETE CASCADE,
    CONSTRAINT fk_HumanResourceManagement2 FOREIGN KEY (EmployeeID1)
        REFERENCES Employee (EmployeeID)
);

CREATE TABLE DateInfo (
    Day            NUMBER(38) NOT NULL,
    Month          NUMBER(38) NOT NULL,
    Year           NUMBER(38) NOT NULL,
    CONSTRAINT pk_DateInfo PRIMARY KEY (Day, Month, Year)
);
