import random
from faker import Faker

# Faker object to generate fake data
fake = Faker()

# Function to generate fake data for Employee table
def generate_employee_data(num_records, max_position_id, max_department_id):
    data = []
    for _ in range(num_records):
        employee_id = random.randint(1, 999999999)
        first_name = fake.first_name()
        last_name = fake.last_name()
        position_id = random.randint(1, max_position_id)
        department_id = random.randint(1, max_department_id)
        salary = random.randint(30000, 100000)
        data.append((employee_id, position_id, first_name, last_name, department_id, salary))
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
def generate_development_data(num_records, max_department_id):
    data = []
    for i in range(1, num_records + 1):
        department_id = random.randint(1, max_department_id)
        initiative_type = fake.text(max_nb_chars=50)
        initiative_date = fake.date_this_year().strftime('%Y-%m-%d')
        data.append((i, department_id, initiative_type, initiative_date))
    return data

# Function to generate fake data for Human_Resource_Management table
def generate_hr_data(num_records, max_employee_id):
    data = []
    action_types = ['Recruitment', 'Promotion', 'Termination']
    for i in range(1, num_records + 1):
        action_type = random.choice(action_types)
        hra_date = fake.date_this_year().strftime('%Y-%m-%d')
        description = fake.text(max_nb_chars=200)
        employee_id = random.randint(1, max_employee_id)
        data.append((i, action_type, hra_date, description, employee_id))
    return data

# Function to generate fake data for Attendance table
def generate_attendance_data(num_records, max_employee_id):
    data = []
    statuses = ['Present', 'Absent', 'Sick', 'Vacation', 'Late']
    for _ in range(num_records):
        employee_id = random.randint(1, max_employee_id)
        aten_date = fake.date_this_year().strftime('%Y-%m-%d')
        status = random.choice(statuses)
        data.append((employee_id, aten_date, status))
    return data

# Function to write SQL INSERT statements to a file
def write_sql_inserts(table_name, data, columns, filename):
    with open(filename, 'w') as f:
        for row in data:
            values = ', '.join([f"TO_DATE('{value}', 'YYYY-MM-DD')" if isinstance(value, str) and '-' in value else f"'{value}'" if isinstance(value, str) else str(value) for value in row])
            insert_statement = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({values});\n"
            f.write(insert_statement)
    print(f"Data for {table_name} exported to {filename} successfully.")

# Number of records
num_records = 5

# Generate and write data for Positions table
positions_data = generate_positions_data(num_records)
positions_columns = ["PositionsID", "PositionsName", "Requirements"]
write_sql_inserts("Positions", positions_data, positions_columns, "inserts.sql")

# Generate and write data for Department table
department_data = generate_department_data(num_records)
department_columns = ["departmentID", "departmentName", "Numofworkers"]
write_sql_inserts("department", department_data, department_columns, "inserts.sql")

# Generate and write data for Employee table
employee_data = generate_employee_data(num_records, num_records, num_records)
employee_columns = ["EmployeeID", "PositionID", "First_Name", "Last_Name", "DepartmentID", "salary"]
write_sql_inserts("Employee", employee_data, employee_columns, "inserts.sql")

# Generate and write data for Development table
development_data = generate_development_data(num_records, num_records)
development_columns = ["DevelopmentID", "departmentID", "initiative_type", "initiative_date"]
write_sql_inserts("Development", development_data, development_columns, "inserts.sql")

# Generate and write data for Human_Resource_Management table
hr_data = generate_hr_data(num_records, 999999999)
hr_columns = ["HRActionID", "ActionType", "HRA_Date", "Description", "EmployeeID"]
write_sql_inserts("Human_Resource_Management", hr_data, hr_columns, "inserts.sql")

# Generate and write data for Attendance table
attendance_data = generate_attendance_data(num_records, 999999999)
attendance_columns = ["EmployeeID", "Aten_Date", "Status"]
write_sql_inserts("Attendance", attendance_data, attendance_columns, "inserts.sql")
