import random
from faker import Faker
from openpyxl import Workbook

# Faker object to generate fake data
fake = Faker()

# Function to generate fake data for Employee table
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
        positions_id = random.randint(1, 5)
        data.append((employee_id, first_name, last_name, position_id, salary, department_id, positions_id))
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

# Function to export data to Excel
def export_to_excel(data, headers, filename):
    wb = Workbook()
    ws = wb.active
    ws.append(headers)
    for row in data:
        ws.append(row)
    wb.save(filename)
    print(f"Data exported to {filename} successfully.")

# Generate fake data for Employee table and export to Excel
employee_data = generate_employee_data(200)
employee_headers = ["Employee ID", "First Name", "Last Name", "Position ID", "Salary", "Department ID", "Positions ID"]
export_to_excel(employee_data, employee_headers, "Employee.xlsx")

# Generate fake data for Positions table and export to Excel
positions_data = generate_positions_data(200)
positions_headers = ["Position ID", "Position Name", "Requirements"]
export_to_excel(positions_data, positions_headers, "Positions.xlsx")

# Generate fake data for Department table and export to Excel
department_data = generate_department_data(200)
department_headers = ["Department ID", "Department Name", "Num of Workers"]
export_to_excel(department_data, department_headers, "Department.xlsx")

# Generate fake data for Development table and export to Excel
development_data = generate_development_data(200)
development_headers = ["Development ID", "Department ID", "Initiative Type", "Implementation Date",  "Day", "Month", "Year"]
export_to_excel(development_data, development_headers, "Development.xlsx")

# Generate fake data for HumanResourceManagement table and export to Excel
hr_data = generate_hr_data(200)
hr_headers = ["HR Action ID", "Action Type", "Date", "Day", "Month", "Year", "Employee ID", "Description"]
export_to_excel(hr_data, hr_headers, "HumanResourceManagement.xlsx")

# Generate fake data for Date table and export to Excel
date_data = generate_date_data(200)
date_headers = ["Day", "Month", "Year"]
export_to_excel(date_data, date_headers, "Date.xlsx")
