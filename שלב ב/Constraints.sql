--אילוץ CHECK בטבלת Employee לעמודה salary בכדי לוודא שהמשכורת חיובית (גדולה מ-0)

ALTER TABLE Employee
ADD CONSTRAINT chk_salary_positive CHECK (salary > 0);

-- אילוץ NOT NULL בטבלת department לעמודה departmentName

ALTER TABLE department
ADD CONSTRAINT nn_departmentName CHECK (departmentName IS NOT NULL);

-- אילוץ DEFAULT בטבלת department לעמודה departmentName עם ערך ברירת מחדל 'Sales'

ALTER TABLE department
MODIFY (departmentName DEFAULT 'Sales');

-- אילוץ CHECK בטבלת department לעמודה departmentName

ALTER TABLE department
ADD CONSTRAINT chk_DepartmentName CHECK (departmentName IN ('Sales', 'Marketing', 'Human Resources', 'Finance'));

