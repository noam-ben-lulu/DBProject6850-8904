# minip_basnat
## ERD
![image](https://github.com/noam-ben-lulu/minip_basnat/assets/169597958/1671315a-0c3a-4259-ab17-1f6385f1149f)

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




![image](https://github.com/noam-ben-lulu/minip_basnat/assets/169597958/c0914acb-f31a-4e6f-a551-401d7c8c53b5)
