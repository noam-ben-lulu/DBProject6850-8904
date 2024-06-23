
![image](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/708b6ede-de54-4220-ac07-a200576416dd)

## תיאור מילולי של המערכת 
מטרת התוכנית שאנו נבנה היא על מנת לאפשר לבנק לשלוט על מחלקת משאבי האנוש בבנק. 
התוכנית תאפשר לבנק לשלוט על ניהול העובדים שלו, ניהול תפקידי העובדים והמחלקות בהם הם נמצאים. 
בנוסף יתאפשר לעשות פיתוח מחלקות כאשר לכל יוזמה יהיה סוג יוזמה, מספר המחלקה, ותאריך היוזמה. 
בנוסף תיהיה אופציה לניהול משאבי אנוש עבור איש ספציפי במחלקה עם תיאור הפעולה הנעשית(כגון העלה בשכר ענישה וכדו). 
בעצם כמו שאמרנו בשער הפתיחה של הפרויקט אנחנו נתעסק בתוך ארגון גדול של בנק כאשר הפרויקט שלנו ייקח מחלקה מתוך הבנק וזה מחלקת משאבי אנוש על כל פרטיה עובדים מחלקות מעמדות משאבי אנוש ונוכחות

## ERD
![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/169597958/ac2f178e-73dc-4180-bb86-1638190a8fe6)


## Entities:

1.**Employees:**:

- **EmployeeID** (מזהה העובד, INT).
- First Name (שם פרטי, VARCHAR2(255)).
- Last Name (שם משפחה, VARCHAR2(255))
- PositionID FK (מזהה התפקיד, INT)
- Salary (משכורת, DECIMAL(10,2))
- DepartmentID FK (מזהה מחלקה, INT)

2.**Positions**:
- **PositionID** (מזהה התפקיד, INT)
- Position Name (כותרת התפקיד, VARCHAR2(255))
- Responsibilities (אחריות עיקרית, TEXT)
- Requirements (דרישות לתפקיד, TEXT)

3. **department**:
- **departmentID**(INT, מזהה ראשי)
- departmentName (VARCHAR2(255))
- Description(TEXT)

4.**Development**:   

- **DevelopmentID**(INT, מזהה ראשי)
- departmentID FK (INT, מזהה חיצוני לטבלת מחלקה)
- initiative_type(VARCHAR2(255))
- initiative_date(DATE)


5. **Human Resource Management**:
- **HRActionID** (מזהה פעולת משאבי אנוש, INT PRIMARY KEY)
- ActionType (סוג הפעולה, VARCHAR2(255))
- Date (תאריך, DATE)
- Description (תיאור, TEXT)
- EmployeeID FK (מזהה עובד, INT)


6. **Attendance**: 
- **EmployeeID** FK(מזהה העובד, INT PRIMARY KEY)
- **Aten_Date**(תאריך, DATE PRIMARY KEY)
- Status(VARCHAR2(255))




**Schemes**
- Employees( EmployeeID , PositionID, DepartmentID, First name, Last name, Salary).
- Positions(PositionID,PositionName, Responsibilities, Requirements)
- Departments(DepartmentID,DepartmentName, Description)
- Development(DevelopmentID,DepartmentID, InitiativeType, InitiativeDate)
- Human Resource Management(HRActionID,EmployeeID, ActionType, Date, Description)
- Attendance(EmployeeID, Aten_Date, Status)


## DSD
![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/169597958/ea6c9ed7-cba5-4858-8958-597ed428c851)

## נימוקים לעיצוב:
נורמליזציה: הטבלאות נורמליזציות כדי למנוע כפילות נתונים ולאפשר גישה ותחזוקה יעילים יותר של הנתונים.

קשרים לוגיים: המודל מגדיר קשרים ברורים בין הטבלאות באמצעות מפתחות זרים, מה שמבטיח שלמות נתונים והקפדה על מבנה לוגי ברור.

גמישות: המודל מאפשר גמישות בשינויים עתידיים במבנה הארגוני מבלי להשפיע משמעותית על מבנה הנתונים הקיים.

## CreatTable

CREATE TABLE Positions (

    PositionsID     NUMBER(38) NOT NULL,
    
    PositionsName  VARCHAR2(255) NOT NULL,
    
    Requirements   VARCHAR2(600) NOT NULL,
    
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
    
    Description    VARCHAR2(600) NOT NULL,
    
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
![WhatsApp Image 2024-05-28 at 17 37 44](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/83bda7f1-91bf-4f7b-94ca-25c3b4c937d7)

![WhatsApp Image 2024-05-20 at 21 26 45](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/94e38e4d-1cca-4278-b4cd-e5f44b9adcdd)

![WhatsApp Image 2024-05-27 at 18 50 37](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/03049901-b4d1-46e7-a876-495b524c932c)

![WhatsApp Image 2024-05-27 at 18 47 35](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/a4c8a8d8-0067-420c-83b3-500adab1c194)



![WhatsApp Image 2024-05-20 at 21 27 37](https://github.com/noam-ben-lulu/minip_basnat/assets/128416447/eda0e882-2e07-4211-8e31-e225a96d81d5)
![WhatsApp Image 2024-05-28 at 17 40 18](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/5bb660a8-9507-4c16-a84f-adb06f8f83bd)



## Text Importer(from csv files)
the csv files created by mockaroo 
![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/127217c5-60ae-4bd9-9f57-36efcaf6f56f)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/14ed6743-4484-448c-a3a8-f9f6e3a0e87b)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/0678fee0-e4ae-4fe7-836a-71fecd20bb9c)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/03c92381-0eaf-4bfc-ae40-00769de19113)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/6fa97a5a-b51e-4dc7-90b5-a12c0f0a6af3)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/5ac67d52-bd5c-4a3f-b775-4bfbe57ed357)

## Backup and restore
![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/790c2549-4e72-4e8e-a323-dd619f26be67)


![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/e56972b4-c926-44ff-bc8b-6cd6100461c1)

   ## Restore
   ![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/ad6b9543-c569-40fc-8f0b-efdf036cbc21)
   ![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/c3d17467-074f-47cb-9853-29bc554fbe4b)

## שלב 2
 ## שאילתות ללא פרמטרים
 
 ----  שאילתות select ----
  
 שאילתה 1:
 
 ![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/cc8faba7-262e-46ea-a642-eded9ab6300e)

 
 
 הסבר: 

 
 השאילתה מחזירה את שמות העובדים, המחלקה שלהם והמשכורת, ממיינת לפי שם המחלקה ולאחר מכן לפי המשכורת בסדר יורד 
 
 שאילתה 2: 

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/bd293a70-189c-4b32-a1c1-60b214e812f1)
 
 
הסבר:

השאילתה מחזירה את ימי הנוכחות של כל עובד ממוינת לפי ימי הנוכחות בסדר יורד ( כלומר בהתחלה נראה את כל מי שהיה מספר ימים הכי גבוה)

שאילתה 3:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/9a1da763-4914-40c1-aaa8-a8a8b00f2d7f)


הסבר:

השאילתה הזו מחזירה לנו בעצם את מספר העובדים שנכחו בכל חודש בכל שנה( לדוגמא כפי שניתן לראות בשנת 2020 בחודש ינואר (1) נכחו 6 עובדים וכן על זאת הדרך..)

שאילתה 4:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/bbf1f1bf-1f48-4719-b941-8ecb666632bb)


הסבר:

השאילתה בעצם מראה לנו את ממוצע המשכורות של כל מחלקה התוצאה היא שם המחלקה מספר העובדים בה וממוצע המשכורות של העובדים במחלקה

---- שאילתות delete: ----

בהתחלה כדי לראות את מסד הנתונים לפני ואחרי כלומר כדי לראות שבאמת הפעולה בוצעה נריץ שאילתה כדי להראות את הבסיס לאחר מכן נבצע את השאילתה שלנו ולאחר מכן נריץ את אותה שאילתה כדי לודא שבאמת היה מחיקה ממסד הנתונים.

שאילתה 1:
 מחיקת כל העובדים שלא ביצעו שום יוזמה (initiative) בטבלת Development

 בדיקת הנתונים:

 ![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/4e5cecdd-5227-4473-b309-2839c45b7afd)

מחיקת העובדים האלו (נשים לב שקיימים 175 כאלו שלא ביצעו שום יוזמה)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/247b105f-fc98-44d2-a352-c90394b73c0c)

נשים לב שביצענו מחיקה גם מטבלת הנוכחות מפני שהתעודת זהות של העובדים היא מפתח זר בטבלה הזו

בדיקה שהמחיקה התקיימה כראוי:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/6ecbb590-377c-48ec-a404-5201c5d9f7b0)

באמת אפשר לראות שלא קיימים עכשיו עובדים כאלו כלומר המחיקה בוצעה כראוי.

שאילתה 2:

מחיקת כל העובדים שאין לנו עליהם רישום בטבלת נוכחות שלנו

בדיקת הנתונים:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/e59e746d-1272-40aa-b51c-020c9eb48c7c)

מחיקת העובדים האלו (נשים לב שקיימים 90 כאלו שאין לנו עליהם רישום בטבלת נוכחות)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/9e0c4a47-304c-4875-9839-50ad496a1f86)

בדיקה שהמחיקה התקיימה כראוי:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/df6ee7e9-2bdd-4a65-a80e-e8a2987b08c6)

באמת אפשר לראות שהמחיקה התקיימה כראוי

---- שאילתות update: ----

גם כאן נבצע שאילתה להראות את מסד הנתונים לפני נעשה שאילתת עדכון ולאחר מכן שאילת להראות את מסד הנתונים לאחר העדכון

שאילתה 1: עדכון משכורת של עובדים במחלקת HR ב-10% בעקבות עבודתם הקשה בפרויקט

בדיקת הנתונים:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/52a0f103-f5e3-497a-8b9b-8099d09c32f3)

ביצוע העדכון:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/02a0b737-c49e-4f89-b589-c0edfeef2266)

בדיקת העדכון:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/44e43038-2a98-45b2-9fba-98b8310abbec)
נסתכל על לדוגמא העובד הראשון בהתחלה המשכורת שלו הייתה 14,067 ועכשיו היא מעודכנת להיות 15474

שאילתה 2: עדכון נוכחות לעובד שנרשם לו חיסור בתאריך 19.04.21  ושינוי רישום לזה שהוא היה

בדיקת הנתונים:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/5097ec2b-9fe5-479c-9134-292362d42720)

ביצוע העדכון:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/ed43f0e0-0b20-46db-9fb7-f44c818bbe5c)

בדיקת העדכון:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/7f4efabe-cfe6-46fa-9d8c-62fefad17d57)

כל השאילתות מופיעות בקובץ sql
## שאילתות עם פרמטרים

שאילתה 1: הכנסת תאריך מסוים וקבלת הנתונים על כל העובדים שנכחו באותו תאריך (תעודת זהות העובד , שם העובד , משכורת ומחלקה שעובד בה)
![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/dace5827-8f79-4864-9db0-5efea259b34b)


לדוגמא כאשר נכניס את התאריך 2024-05-08 (לפי הפורמט של אורקל) נקבל:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/c0c8cffc-7cd0-4fcd-badd-d8f69fa0be2d)


שאילתה 2: החזרת כל הפרטים על עובד מסוים כאשר הקלט הוא שם העובד המבוקש (נקבל את המשכורת שלו , המחלקה שלו סוג היוזמה שהוא ביצע התאריך שהוא ביצע וכמובן הפעולות שהוא ביצע והתאריך שהוא ביצע)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/2a4903b2-9776-43d6-93d1-094ce9f9e857)


לדוגמא כאשר נכניס את שם העובדת לריסה טינר:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/7fd9a8cd-d09e-48f0-aeec-2b3aa3d88f12)

שאילתה 3: החזרת מספרי עובדים של מחלקה מסוימת והמשכורת הממצועת של המחלקה כאשר הפמרטר הנקלט יכול להיות גם רשימה של מחלקות

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/1f1ed225-e4fa-4e7d-ba3c-cd39f538edb7)

לדוגמא כאשר נכניס את המחלקות מכירות ושיווק:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/e4d591d2-ac23-46e1-85a3-5f24c0b000f8)

שאילתה 4: קבלת שם משרה והחזרה של המשכורת המינימלית והמקסימלית שמקבלים במשרה הזו( כמובן על סמך העובדים שעובדים שם נכון לעת ביצוע הפעולה..)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/aa3dee54-b6f4-4dd2-aa00-1edfa868d948)

לדוגמא כאשר נכניס את המשרה של מפקח:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/74b7ee49-3387-4420-a433-aeca3edebede)


## אילוצים
נבצע אילוצים שונים ולאחר מכן לכל אילוץ נראה שבאמת מקיימת הודעת שגיאה שמנסים לסתור את האילוץ

אילוץ CHECK בטבלת Employee לעמודה salary בכדי לוודא שהמשכורת חיובית (גדולה מ-0)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/2648cc6d-e8e8-4c17-9a25-b18ae4faa07b)

נבדוק השאילוץ מתקיים:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/c47d2c93-b50e-44d4-ba66-20e4753ef858)

אילוץ NOT NULL בטבלת department לעמודה departmentName

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/920cdcee-b52f-4953-888c-69f80ec6972c)

נבדוק שהאילוץ מתקיים:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/24f8a499-10f2-4867-a293-c8bdf49b0393)

אילוץ DEFAULT בטבלת department לעמודה departmentName עם ערך ברירת מחדל 'Sales'
![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/f2e2e442-edd2-4217-85da-c3b9a6a81958)

בדיקה שהאילוץ מתקיים:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/99484dd7-367d-49c7-a77a-c0b09608b037)

אילוץ CHECK בטבלת department לעמודה departmentName

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/6cb8c5fb-e8ff-4750-ad0c-a4476c11c3d0)

בדיקה שהאילוץ מתקיים:
![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/eafe090f-af26-4144-857f-8075adfda316)

## שלב 3:

# תוכנית ראשונה:
בעצם יש לנו פונקציה שבה אנחנו מקבלים את הנתונים על כל העובדים הנמצאים במחלקה הנתונים הם מספר עובד משכורת ווותק ובנוסף יש לנו פרוצדורה שמעדכנת לכל עובד במחלקה הזו את המשכורת שלה להיות משופרת בהתאם לותק שלו ככל השותק גבוה יותר כך גם המשכורת כמובן. בתוכנית שלנו אנחנו רצים על כל המחלקות בבסיס הנתוניים שקיימים בהם עובדים ומעדכנים לכל אחד את המשכורת אנחנו מקבלים מהמשתמש שיכול להיות במקרה שלנו הבנק מה הוא המשכורת ההתחלתית של כל עובד ולאחר מכן אנחנו שולחים את זה לפרוצדורה שמקבל את הCURSOR הנוצר מהפונקציה שמכילה את פרטי העובדים ועושה שם עדכונים בעצם התוכנית שלנו בשיתוף פעולה עם הפונקציה והפרוצדורה אחראית על עדכוני המשכורות של העובדים כך שלדוגמא בתחילת כל שנה אזרחית חדשה כלומר בראשון לינואר נריץ שאילתה אחת של עדכון של הותק של כל העובדים שיעלה ב-1 ולאחר מכן נריץ את התוכנית שלנו ונעדכן את המשכורות של העובדים כמובן שלא כל שנה המשכורת מתעדכנת אלא לפי ההסתעפות הקיימת בפונקציה

כעת נספק את הקודים של התוכנית הראשית לאחר מכן נספק תמונה של הפונקציה והפרודצורה כמובן שאת הקוד עצמו מסופק בגיט בתוך התיקייה בשלב ג

תוכנית ראשית:

DECLARE
    dept_id NUMBER;
    base_salary NUMBER := &Enter_Base_Salary;
    emp_cursor SYS_REFCURSOR;
    emp_id Employee.EmployeeID%TYPE;
    salary Employee.Salary%TYPE;
    seniority Employee.Seniority%TYPE;
    has_employees BOOLEAN := FALSE;
    
    CURSOR dept_cursor IS
        SELECT departmentID FROM department;
    
BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.PUT_LINE('Starting the main: Update all the salaries in the database.');

    -- לולאה על כל המחלקות
    FOR dept_record IN dept_cursor LOOP
        dept_id := dept_record.departmentID;

        -- קריאה לפונקציה GetEmployeesByDepartment
        emp_cursor := GetEmployeesByDepartment(dept_id);
        has_employees := FALSE;  -- אתחול המשתנה לכל מחלקה חדשה

        -- סריקת ה-cursor והדפסת נתונים
        LOOP
            FETCH emp_cursor INTO emp_id, salary, seniority;
            EXIT WHEN emp_cursor%NOTFOUND;
            IF NOT has_employees THEN
                DBMS_OUTPUT.PUT_LINE('Employees in Department ' || dept_id || ':');
                has_employees := TRUE;
            END IF;
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_id || ', Salary: ' || salary || ', Seniority: ' || seniority);
        END LOOP;

        -- סגור את ה-cursor כדי למנוע שגיאות בעת קריאה לפרוצדורה
        CLOSE emp_cursor;

        -- אם יש עובדים במחלקה, קריאה לפרוצדורה לעדכון המשכורות
        IF has_employees THEN
            emp_cursor := GetEmployeesByDepartment(dept_id);

            -- קריאה לפרוצדורה UpdateEmployeeSalariesWithCursor
            UpdateEmployeeSalariesWithCursor(emp_cursor, base_salary); -- Update salary based on seniority and base salary

            DBMS_OUTPUT.PUT_LINE('Employee salaries updated for Department ' || dept_id || '.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No employees found in Department ' || dept_id || '.');
        END IF;
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/




פונקציה:
CREATE OR REPLACE FUNCTION GetEmployeesByDepartment(dept_id NUMBER) 
RETURN SYS_REFCURSOR 
IS
    emp_ref_cursor SYS_REFCURSOR; -- Ref Cursor to return employee data
BEGIN
    

    OPEN emp_ref_cursor FOR
          SELECT EmployeeID, Salary, Seniority 
        FROM Employee 
        WHERE DepartmentID = dept_id;
        
    
    RETURN emp_ref_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in GetEmployeesByDepartment: ' || SQLERRM);
        RETURN NULL;
END;


פרוצדורה:

CREATE OR REPLACE PROCEDURE UpdateEmployeeSalariesWithCursor(
    emp_ref_cursor SYS_REFCURSOR,
    base_salary NUMBER
) 
IS
    
    emp_id Employee.EmployeeID%TYPE;
    salary Employee.Salary%TYPE;
    seniority Employee.Seniority%TYPE;
    new_salary Employee.Salary%TYPE;
BEGIN

    
    
    LOOP
        FETCH emp_ref_cursor INTO emp_id, salary, seniority;
        EXIT WHEN emp_ref_cursor%NOTFOUND;
        
        
        
        -- Update salary based on seniority
        IF seniority BETWEEN 1 AND 3 THEN
            new_salary := base_salary;
        ELSIF seniority BETWEEN 4 AND 7 THEN
            new_salary := base_salary * 1.15;
        ELSIF seniority BETWEEN 8 AND 15 THEN
            new_salary := base_salary * 1.25;
        ELSIF seniority BETWEEN 16 AND 22 THEN
            new_salary := base_salary * 1.33;
        ELSIF seniority BETWEEN 23 AND 29 THEN
            new_salary := base_salary * 1.4;
        ELSIF seniority = 30 THEN
            new_salary := base_salary * 1.5;
        END IF;
        
        -- Update the employee's salary
        UPDATE Employee
        SET salary = new_salary
        WHERE EmployeeID = emp_id;
        
        DBMS_OUTPUT.PUT_LINE('Updated salary for Employee ID: ' || emp_id || ' to ' || new_salary);
    END LOOP;
    
    -- Close the cursor
    CLOSE emp_ref_cursor;


    -- Commit the changes
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK; -- Rollback in case of error
END;
/


נראה שהתוכנית עובדת נבחר שהסכום ההתחלתי הוא לדוגמא 15000 ונראה את תוצאות ההתוכנית:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/d31bc553-1cea-430d-b8c4-09f4775fe33f)

תוצאות התוכנית:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/13ba2346-f7fa-407e-b714-9686767f6079)

כפי שרואים לדוגמא לעובד מספר 266 המשכורת שלו הייתה 15000 ובעקבות הותק שלו של ה27 שנים הוכפל המשכורת ההתחלתית 15000 ב1.4 כמו שרשום בפרודצורה והמשכורת העדכנית היא 21000

נראה שהתוכנית מעדכנת כמובן גם בבסיס הנתונים נראה לפני ואחרי

לפני:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/6b0b8ffc-a0da-4b9f-8995-9e51ee7b299f)

אחרי:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/25e09fe1-4bf3-4e9f-8ed5-eb4bb29d11df)

כלומר התוכנית עובדת ניתן לבצע ככה לכל העובדים.

## תוכנית שנייה:

התוכנית הנוכחית נועדה לנהל הקצאות יוזמות פיתוח (Development) של עובדים בתוך הארגון. התוכנית עושה שימוש בפונקציה ובפרוצדורה כדי לקבל מידע על עובדים ולבצע שינויים במידת הצורך. כלומר אנחנו על ידי התוכנית שלנו נוכל לדעת גם מה המצב של הפיתוחים שלנו מי העובדים שקיימים שם וכמה בעצם אנחנן מוציאים על הפיתוח הזה כסף (מוגדר להיות סכום המשכורות של העובדים המשתתפים) ובעצם השימוש שלנו בפונקציה הוא לקבלת הפרטים של העובדים והדפסת על ידי הcursor שמוחזר והשימוש בפרוצדורה הוא במידה ונרצה לעדכן עובדים מסוימים כלומר להזיז אותם מפיתוח כזה או אחר או אפילו למחוק אותם מהעבודה על הפיתוח כלומר למחוק אותם מבסיס הנתונים נוכל לבצע את זה בתוכנית שלנו

נספק כעת את קוד התוכנית הראשית ואת קוד הפונקציה והפרוצדורה

תוכנית ראשית:


DECLARE

    development_id NUMBER;
    
    employee_id NUMBER;
    
    current_department_id NUMBER;
    
    target_department_id NUMBER;
    
    emp_dev_cursor SYS_REFCURSOR;
    
    emp_id Employee.EmployeeID%TYPE;
    
    first_name Employee.First_Name%TYPE;
    
    last_name Employee.Last_Name%TYPE;
    
    salary Employee.salary%TYPE;
    
    department_id Employee.DepartmentID%TYPE;
    
    total_salary NUMBER;
    
    make_changes CHAR(1);
    
    show_details  CHAR(1);
    
    
    
    CURSOR development_cursor IS
    
        SELECT DevelopmentID FROM Development;
        
        

BEGIN


    DBMS_OUTPUT.ENABLE(1000000);
    
    
    make_changes := '&Make_Changes';

    
    
    IF make_changes = 'Y' THEN

    
       DBMS_OUTPUT.PUT_LINE('wanna make changes');
       
      
        employee_id := &Enter_Employee_ID;
        
        current_department_id := &Enter_Current_Department_ID;
        
        target_department_id := &Enter_Target_Department_ID;
        

        IF employee_id IS NOT NULL AND current_department_id IS NOT NULL AND target_department_id IS NOT NULL THEN
        
            ReassignEmployeeToDevelopment(employee_id, current_department_id, target_department_id);
            
        END IF;
        
    END IF;
    
    show_details := '&show_details';
    
    
   IF show_details = 'Y' THEN
   
        DBMS_OUTPUT.PUT_LINE('Starting to manage development assignments.');
        

       
        FOR dev_record IN development_cursor LOOP
        
            development_id := dev_record.DevelopmentID;
            

          
            emp_dev_cursor := GetEmployeesByDevelopment(development_id);
            
            DBMS_OUTPUT.PUT_LINE('Employees in Development ' || development_id || ':');
            
            
            total_salary := 0; 
            

           
            LOOP
            
                FETCH emp_dev_cursor INTO emp_id, first_name, last_name, salary, department_id;
                
                EXIT WHEN emp_dev_cursor%NOTFOUND;
                
                DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_id || ', Name: ' || first_name || ' ' || last_name || ', Salary: ' || salary || ', Department ID: ' || department_id);
                
                total_salary := total_salary + salary;
                
            END LOOP;
            

          
            DBMS_OUTPUT.PUT_LINE('Total Salary for Development ' || development_id || ': ' || total_salary);
            

      
            CLOSE emp_dev_cursor;
            
            
      
            DBMS_OUTPUT.NEW_LINE;
            
        END LOOP;
        
    END IF;
    
    

    

    DBMS_OUTPUT.PUT_LINE('Finished managing development assignments.');

    
EXCEPTION


    WHEN OTHERS THEN 
    

    
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);

        
END;



פונקציה:


CREATE OR REPLACE FUNCTION GetEmployeesByDevelopment(development_id NUMBER) 

RETURN SYS_REFCURSOR 

IS

    emp_dev_ref_cursor SYS_REFCURSOR; -- Ref Cursor to return employee data
    
BEGIN

    OPEN emp_dev_ref_cursor FOR
    
        SELECT e.EmployeeID, e.First_Name, e.Last_Name, e.salary, e.DepartmentID
        
        FROM Employee e
        
        JOIN Development d ON e.DepartmentID = d.departmentID
        
        WHERE d.DevelopmentID = development_id;
        
    RETURN emp_dev_ref_cursor;
    
EXCEPTION

    WHEN OTHERS THEN
    
        DBMS_OUTPUT.PUT_LINE('Error in GetEmployeesByDevelopment: ' || SQLERRM);

        RETURN NULL;
        
END;




פרוצדורה:

CREATE OR REPLACE PROCEDURE ReassignEmployeeToDevelopment
(
    employee_id NUMBER,
    
    current_department_id NUMBER,
    
    target_department_id NUMBER
    
) 
IS

BEGIN

   
    IF target_department_id = current_department_id THEN
    
        DELETE FROM Employee
        
        WHERE EmployeeID = employee_id AND DepartmentID = current_department_id;
        
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employee_id || ' has been deleted from Department ID: ' || current_department_id);
        
    ELSE
    
      
        UPDATE Employee
        
        SET DepartmentID = target_department_id
        
        WHERE EmployeeID = employee_id AND DepartmentID = current_department_id;
        
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employee_id || ' has been reassigned from Department ID: ' || current_department_id || ' to Department ID: ' || target_department_id);
        
    END IF;
    

 
    COMMIT;
    
EXCEPTION

    WHEN OTHERS THEN
    
        DBMS_OUTPUT.PUT_LINE('Error in ReassignEmployeeToDevelopment: ' || SQLERRM);
        
        ROLLBACK; 
        
END;

כמו שניתן לראות הקוד לא עולה בצורה טובה אבל כמובן שיש את הקוד בקובץ SQL כמו שצריך בגיט תחת תיקיה ששמה שלב ג

כעת נראה שהתוכנית באמת עובדת נראה שתי דוגמאות 
1. העברת עובד מחלקה
2. מחיקת עובד

   נתחיל עם הדוגמא הראשונה: נעביר את עובד מספר 99999 ממחלקה 1 למחלקה 168

לפני:

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/3b244642-8d99-417b-8d3d-64c5cd2140d3)

נבחר את זה שאנחנו רוצים באמת לבצע שינויים בארגון וגם נבחר לראות את כל הפרטים על המחלקות וכו לאחר העדכון

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/8ab5c083-5ea4-4ee0-9bf1-84ec62736aeb)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/91e90aae-e5ac-4b33-9f3e-f3ce8feab6a9)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/f63697ec-9e5e-41ae-9c99-dc7ad8b3afc0)

ובאמת קרה העדכון והעובד עבר מחלקה
עכשיו נמחק את העובד  לשם כך נגדיר את מחלקת היעד כאותו ערך של מחלקת המקור נבחר לא להציג את כל הפרטים לשם נוחות

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/5b4435c4-eb13-4079-853a-1d7266fe126e)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/f3829024-1ad2-49d1-a8a8-2af68522355e)

![image](https://github.com/noam-ben-lulu/DBProject6850-8904/assets/128416447/4ae14c2d-2f3b-496e-8703-a9f67de43eb1)

ובאמת העדכון התבצע
כלומר הראנו שהתוכנית עובדת


## סוף שלב ג
