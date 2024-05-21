
![image](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/708b6ede-de54-4220-ac07-a200576416dd)

## תיאור מילולי של המערכת 
מטרת התוכנית שאנו נבנה היא על מנת לאפשר לבנק לשלוט על מחלקת משאבי האנוש בבנק. 
התוכנית תאפשר לבנק לשלוט על ניהול העובדים שלו, ניהול תפקידי העובדים והמחלקות בהם הם נמצאים. 
בנוסף יתאפשר לעשות פיתוח מחלקות כאשר לכל יוזמה יהיה סוג יוזמה, מספר המחלקה, ותאריך היוזמה. 
בנוסף תיהיה אופציה לניהול משאבי אנוש עבור איש ספציפי במחלקה עם תיאור הפעולה הנעשית(כגון העלה בשכר ענישה וכדו). 

## ERD
![image](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/fcfc28d1-c465-454c-a7b2-3cbab48f706c)


## Entities:

1.**Employees:**:

- EmployeeID (מזהה העובד, INT).
- First Name (שם פרטי, VARCHAR2(255)).
- Last Name (שם משפחה, VARCHAR2(255))
- PositionID (מזהה התפקיד, INT)
- Salary (משכורת, DECIMAL(10,2))
- DepartmentID (מזהה מחלקה, INT)

2.**Positions**:
- PositionID (מזהה התפקיד, INT)
- Position Name (כותרת התפקיד, VARCHAR2(255))
- Responsibilities (אחריות עיקרית, TEXT)
- Requirements (דרישות לתפקיד, TEXT)

3. **department**:
- departmentID(INT, מזהה ראשי)
- departmentName (VARCHAR2(255))
- Description(TEXT)

4.**Development**:   

- DevelopmentID(INT, מזהה ראשי)
- departmentID (INT, מזהה חיצוני לטבלת מחלקה)
- initiative_type(VARCHAR2(255))
- initiative_date(DATE)


5. **Human Resource Management**:
- HRActionID (מזהה פעולת משאבי אנוש, INT PRIMARY KEY)
- ActionType (סוג הפעולה, VARCHAR2(255))
- Date (תאריך, DATE)
- Description (תיאור, TEXT)
- EmployeeID (מזהה עובד, INT)


6. **Attendance**: 
- EmployeeID(מזהה העובד, INT PRIMARY KEY)
- Aten_Date(תאריך, DATE PRIMARY KEY)
- Status(VARCHAR2(255))




**Schemes**
- Employees( EmployeeID , PositionID, DepartmentID, First name, Last name, Salary).
- Positions(PositionID,PositionName, Responsibilities, Requirements)
- Departments(DepartmentID,DepartmentName, Description)
- Development(DevelopmentID,DepartmentID, InitiativeType, InitiativeDate)
- Human Resource Management(HRActionID,EmployeeID, ActionType, Date, Description)
- Attendance(EmployeeID, Aten_Date, Status)


## DSD
![image](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/542193ec-dee5-4a2f-b462-7081b4a8cffc)

## CreatTable

CREATE TABLE Positions (

    PositionsID     NUMBER(38) NOT NULL,
    
    PositionsName  VARCHAR2(255) NOT NULL,
    
    Requirements   LONG NOT NULL,
    
    CONSTRAINT pk_Positions PRIMARY KEY (PositionsID)
)
/

CREATE TABLE department (

    departmentID   NUMBER(38) NOT NULL,
    
    departmentName VARCHAR2(255) NOT NULL,
    
    Numofworkers   NUMBER(38) NOT NULL,
    
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
        REFERENCES Positions (PositionsID)
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
![image](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/a4a4211c-a18a-453f-8388-624487184344)

## Data-Generator(screenshots)

![WhatsApp Image 2024-05-20 at 21 26 28](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/30749049-541e-4301-8709-dd762ed812bb)


![WhatsApp Image 2024-05-20 at 21 26 45](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/94e38e4d-1cca-4278-b4cd-e5f44b9adcdd)

![WhatsApp Image 2024-05-20 at 21 27 04](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/6a40dbfc-f4a0-4e25-b3f6-16eb4773b423)
![WhatsApp Image 2024-05-20 at 21 27 22](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/d2039dae-01e8-452c-8ec1-1028114cabc5)

![WhatsApp Image 2024-05-20 at 21 27 37](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/eda0e882-2e07-4211-8e31-e225a96d81d5)
![WhatsApp Image 2024-05-20 at 21 33 09](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/4d982eb8-4ae2-4275-ab1c-c254d25c8351)


