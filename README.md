# mini project in data base
Menachem Kishon 214938904.

Noam Ben-Lulu 327796850.
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


