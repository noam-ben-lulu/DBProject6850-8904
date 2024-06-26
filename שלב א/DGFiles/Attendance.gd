
[General]
Version=1

[Preferences]
Username=
Password=2984
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=ATTENDANCE
Count=400

[Record]
Name=EMPLOYEEID
Type=NUMBER
Size=38
Data=List(select EmployeeID from Employee)
Master=

[Record]
Name=ATEN_DATE
Type=DATE
Size=
Data=Random(01/05/2023, 01/05/2024)
Master=

[Record]
Name=STATUS
Type=VARCHAR2
Size=255
Data=List('Present', 'Absent', 'Sick', 'Vacation', 'Late', 'Work From Home')
Master=

