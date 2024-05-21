
[General]
Version=1

[Preferences]
Username=
Password=2446
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=HUMAN_RESOURCE_MANAGEMENT
Count=400

[Record]
Name=HRACTIONID
Type=NUMBER
Size=38
Data=Random(12, 13434)
Master=

[Record]
Name=ACTIONTYPE
Type=VARCHAR2
Size=255
Data=List('Recruitment', 'Training', 'Promotion', 'Termination', 'Performance Review', 'Employee Relations')
Master=

[Record]
Name=HRA_DATE
Type=DATE
Size=
Data=Random(01/05/2023, 01/05/2024)
Master=

[Record]
Name=DESCRIPTION
Type=LONG
Size=
Data=Text(200, 24, 30)
Master=

[Record]
Name=EMPLOYEEID
Type=NUMBER
Size=38
Data=SQL(SELECT * FROM (SELECT EmployeeID FROM Employee ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

