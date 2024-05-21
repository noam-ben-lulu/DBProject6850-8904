
[General]
Version=1

[Preferences]
Username=
Password=2491
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=DEPARTMENT
Count=400

[Record]
Name=DEPARTMENTID
Type=NUMBER
Size=38
Data=Random(1, 10)
Master=

[Record]
Name=DEPARTMENTNAME
Type=VARCHAR2
Size=255
Data=List('HR', 'IT', 'Finance', 'Marketing', 'Sales', 'Legal', 'Customer Service', 'Research and Development', 'Production', 'Supply Chain')
Master=

[Record]
Name=NUMOFWORKERS
Type=NUMBER
Size=38
Data=Random(5, 20)
Master=

