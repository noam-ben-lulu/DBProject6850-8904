import random
from faker import Faker

# Faker object to generate fake data
fake = Faker()

# Function to generate fake data for Employee table
def generate_employee_data(num_records):
    data = []
    for _ in range(num_records):
        employee_id = ''.join([str(random.randint(0, 9)) for _ in range(9)])
        first_name = fake.first_name()
        last_name = fake.last_name()
        position_id = random.randint(1, 5)
        salary = random.randint(30000, 100000)
        department_id = random.randint(1, 3)
        data.append((employee_id, first_name, last_name, position_id, salary, department_id))
    return data

# Function to generate fake data for Positions table
def generate_positions_data(num_records):
    data = []
    for i in range(1, num_records + 1):
        position_name = f"Position{i}"
        requirements = fake.text(max_nb_chars=200)
        data.append((i, position_name, requirements))
    return data

# Function to generate fake data for Department table
def generate_department_data(num_records):
    data = []
    for i in range(1, num_records + 1):
        department_name = f"Department{i}"
        num_of_workers = random.randint(10, 100)
        data.append((i, department_name, num_of_workers))
    return data

# Function to generate fake data for Development table
def generate_development_data(num_records):
    data = []
    for i in range(1,num_records+1):
        department_id = random.randint(1, 3)
        initiative_type = fake.text(max_nb_chars=50)
        implementation_date = fake.date_this_year()
        day, month, year = implementation_date.day, implementation_date.month, implementation_date.year
        data.append((i, department_id, initiative_type, implementation_date,  day, month, year))
    return data

# Function to generate fake data for HumanResourceManagement table
def generate_hr_data(num_records):
    data = []
    for i in range(1,num_records+1):
        action_type = random.choice(["Recruitment", "Promotion", "Termination"])
        date = fake.date_this_year()
        day, month, year = date.day, date.month, date.year
        employee_id = random.randint(1, 100)
        description = fake.text(max_nb_chars=200)
        data.append((i, action_type, date, day, month, year, employee_id, description))
    return data

# Function to generate fake data for Date table
def generate_date_data(num_records):
    data = []
    for _ in range(num_records):
        day = random.randint(1, 31)
        month = random.randint(1, 12)
        year = random.randint(2022, 2023)
        data.append((day, month, year))
    return data

# Function to write SQL INSERT statements to a file
def write_sql_inserts(table_name, data, columns, filename):
    with open(filename, 'a') as f:
        for row in data:
            values = ', '.join([f"'{str(value)}'" if isinstance(value, str) else str(value) for value in row])
            insert_statement = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({values});\n"
            f.write(insert_statement)
    print(f"Data for {table_name} exported to {filename} successfully.")

# Generate and write data for Employee table
employee_data = generate_employee_data(400)
employee_columns = ["EmployeeID", "FirstName", "LastName", "PositionsID", "Salary", "DepartmentID"]
write_sql_inserts("Employee", employee_data, employee_columns, "inserts.sql")

# Generate and write data for Positions table
positions_data = generate_positions_data(400)
positions_columns = ["PositionsID", "PositionsName", "Requirements"]
write_sql_inserts("Positions", positions_data, positions_columns, "inserts.sql")

# Generate and write data for Department table
department_data = generate_department_data(400)
department_columns = ["DepartmentID", "DepartmentName", "Numofworkers"]
write_sql_inserts("Department", department_data, department_columns, "inserts.sql")

# Generate and write data for Development table
development_data = generate_development_data(400)
development_columns = ["DevelopmentID", "DepartmentID", "InitiativeType", "ImplementationDate",  "Day", "Month", "Year"]
write_sql_inserts("Development", development_data, development_columns, "inserts.sql")

# Generate and write data for HumanResourceManagement table
hr_data = generate_hr_data(400)
hr_columns = ["HRActionID", "ActionType", "DateInfo", "Day", "Month", "Year", "EmployeeID", "Description"]
write_sql_inserts("HumanResourceManagement", hr_data, hr_columns, "inserts.sql")

# Generate and write data for Date table
date_data = generate_date_data(400)
date_columns = ["Day", "Month", "Year"]
write_sql_inserts("DateInfo", date_data, date_columns, "inserts.sql")
