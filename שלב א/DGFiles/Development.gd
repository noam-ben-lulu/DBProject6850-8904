
[General]
Version=1

[Preferences]
Username=
Password=2637
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=DEVELOPMENT
Count=400

[Record]
Name=DEVELOPMENTID
Type=NUMBER
Size=38
Data=Random(1, 56)
Master=

[Record]
Name=DEPARTMENTID
Type=NUMBER
Size=38
Data=SQL(SELECT * FROM (SELECT DepartmentID FROM Department ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

[Record]
Name=INITIATIVE_TYPE
Type=VARCHAR2
Size=255
Data=Text(200, 30, 6)
Master=

[Record]
Name=INITIATIVE_DATE
Type=DATE
Size=
Data=Random(01/05/2023, 01/05/2024)
Master=

