-- ==========================================
-- HR Payroll MIS Database
-- ==========================================

DROP DATABASE IF EXISTS hr_payroll_mis;
CREATE DATABASE hr_payroll_mis;
USE hr_payroll_mis;

-- ==========================================
-- Departments Table
-- ==========================================

CREATE TABLE Departments (
    DepartmentID VARCHAR(10) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- ==========================================
-- Employees Table
-- ==========================================

CREATE TABLE Employees (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    Gender ENUM('Male','Female'),
    Age INT,
    DepartmentID VARCHAR(10),
    Designation VARCHAR(100),
    JoiningDate DATE,
    EmploymentType VARCHAR(30),
    Status VARCHAR(20),
    Manager VARCHAR(100),
    Location VARCHAR(100),

    CONSTRAINT fk_department
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

-- ==========================================
-- Attendance Table
-- ==========================================

CREATE TABLE Attendance (
    AttendanceID VARCHAR(10) PRIMARY KEY,
    EmployeeID VARCHAR(10),
    Month VARCHAR(20),
    PresentDays INT,
    AbsentDays INT,
    LeaveDays INT,
    WFHDays INT,
    OvertimeHours INT,

    CONSTRAINT fk_attendance_employee
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);

-- ==========================================
-- Payroll Table
-- ==========================================

CREATE TABLE Payroll (
    PayrollID VARCHAR(10) PRIMARY KEY,
    EmployeeID VARCHAR(10),
    Month VARCHAR(20),
    BasicSalary DECIMAL(10,2),
    HRA DECIMAL(10,2),
    Bonus DECIMAL(10,2),
    PF DECIMAL(10,2),
    ProfessionalTax DECIMAL(10,2),
    NetSalary DECIMAL(10,2),

    CONSTRAINT fk_payroll_employee
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);

-- ==========================================
-- Leave Records Table
-- ==========================================

CREATE TABLE Leave_Records (
    LeaveID VARCHAR(10) PRIMARY KEY,
    EmployeeID VARCHAR(10),
    LeaveType VARCHAR(50),
    Days INT,
    Status VARCHAR(20),

    CONSTRAINT fk_leave_employee
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);



