
[General]
Version=1

[Preferences]
Username=
Password=2807
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=POSITIONS
Count=400

[Record]
Name=POSITIONSID
Type=NUMBER
Size=38
Data=Random(1111111, 22222222)
Master=

[Record]
Name=POSITIONSNAME
Type=VARCHAR2
Size=255
Data=List('Manager', 'Engineer', 'Analyst', 'Technician', 'Consultant')
Master=

[Record]
Name=REQUIREMENTS
Type=LONG
Size=
Data=Text(100, 20, 5)
Master=

