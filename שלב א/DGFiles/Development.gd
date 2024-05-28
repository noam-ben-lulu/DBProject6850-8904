
[General]
Version=1

[Preferences]
Username=
Password=2423
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
Data=List(select DepartmentID from Department)
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

