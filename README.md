# minip_basnat
## תיאור מילולי של המערכת 
מטרת התוכנית שאנו נבנה היא על מנת לאפשר לבנק לשלוט על מחלקת משאבי האנוש בבנק. 
התוכנית תאפשר לבנק לשלוט על ניהול העובדים שלו, ניהול תפקידי העובדים והמחלקות בהם הם נמצאים. 
בנוסף יתאפשר לעשות פיתוח מחלקות כאשר לכל יוזמה יהיה סוג יוזמה, מספר המחלקה, ותאריך היוזמה. 
בנוסף תיהיה אופציה לניהול משאבי אנוש עבור איש ספציפי במחלקה עם תיאור הפעולה הנעשית(כגון העלה בשכר ענישה וכדו). 

## ERD
![image](https://github.com/noam-ben-lulu/minip_basnat/assets/169597958/8cf9fead-3e2c-4065-95db-332ce7bba5fc)

## Entities:

1.**Employees:**:

- EmployeeID (מזהה העובד, INT).
- First Name (שם פרטי, VARCHAR(50)).
- Last Name (שם משפחה, VARCHAR(50))
- PositionID (מזהה התפקיד, INT)
- Salary (משכורת, DECIMAL(10,2))
- DepartmentID (מזהה מחלקה, INT)

2.**Positions**:
- PositionID (מזהה התפקיד, INT)
- Position Name (כותרת התפקיד, VARCHAR(100))
- Responsibilities (אחריות עיקרית, TEXT)
- Requirements (דרישות לתפקיד, TEXT)

3. **department**:
- departmentID(INT, מזהה ראשי)
- departmentName (VARCHAR(100))
- Description(TEXT)

4.**Development**:   

- DevelopmentID(INT, מזהה ראשי)
- departmentID (INT, מזהה חיצוני לטבלת מחלקה)
- initiative_type(VARCHAR(100))
- initiative_date(DATE)


5. **Human Resource Management**:
- HRActionID (מזהה פעולת משאבי אנוש, INT PRIMARY KEY)
- ActionType (סוג הפעולה, VARCHAR(100))
- Date (תאריך, DATE)
- Description (תיאור, TEXT)
- EmployeeID (מזהה עובד, INT)


6. **DATE**: 
- Day(יום, INT)
- Month(חודש, INT)
- Year(שנה, INT)




**Schemes**
- Employees( EmployeeID , PositionID, DepartmentID, First name, Last name, Salary).
- Positions(PositionID,PositionName, Responsibilities, Requirements)
- Departments(DepartmentID,DepartmentName, Description)
- Development(DevelopmentID,DepartmentID, InitiativeType, InitiativeDate)
- Human Resource Management(HRActionID,EmployeeID, ActionType, Date, Description)
- Date(Day, Month, Year)


## DSD
![image](https://github.com/noam-ben-lulu/minip_basnat/assets/169597958/fba2a857-209f-40d7-af18-2798370745f7)
