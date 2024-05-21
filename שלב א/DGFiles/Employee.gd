
[General]
Version=1

[Preferences]
Username=
Password=2928
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=EMPLOYEE
Count=400

[Record]
Name=EMPLOYEEID
Type=NUMBER
Size=38
Data=Random(1000000, 99999999)
Master=

[Record]
Name=FIRSTNAME
Type=VARCHAR2
Size=255
Data=FirstName
Master=

[Record]
Name=LASTNAME1
Type=VARCHAR2
Size=255
Data=LastName
Master=

[Record]
Name=POSITIONSID
Type=NUMBER
Size=38
Data=SQL(SELECT * FROM (SELECT PositionsID FROM Positions ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

[Record]
Name=SALARY
Type=NUMBER
Size=38
Data=Random(10600, 30000
=)
Master=

[Record]
Name=DEPARTMENTID
Type=NUMBER
Size=38
Data=SQL(SELECT * FROM (SELECT DepartmentID FROM Department ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1)
Master=

