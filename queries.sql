USE hr_payroll_mis;

-- ==========================================
-- BASIC QUERIES
-- ==========================================

-- 1. Total Employees
SELECT COUNT(*) AS TotalEmployees
FROM Employees;

-- 2. Total Departments
SELECT COUNT(*) AS TotalDepartments
FROM Departments;

-- 3. Active Employees
SELECT COUNT(*) AS ActiveEmployees
FROM Employees
WHERE Status='Active';

-- 4. Inactive Employees
SELECT COUNT(*) AS InactiveEmployees
FROM Employees
WHERE Status='Inactive';

-- 5. Gender Distribution
SELECT Gender, COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Gender;

-- 6. Average Age
SELECT ROUND(AVG(Age),2) AS AverageAge
FROM Employees;

-- ==========================================
-- DEPARTMENT QUERIES
-- ==========================================

-- 7. Department-wise Employee Count
SELECT d.DepartmentName,
COUNT(e.EmployeeID) AS TotalEmployees
FROM Departments d
JOIN Employees e
ON d.DepartmentID=e.DepartmentID
GROUP BY d.DepartmentName;

-- 8. Employees in each Department
SELECT DepartmentID,
COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;

-- 9. Department-wise Average Salary
SELECT d.DepartmentName,
ROUND(AVG(p.NetSalary),2) AS AvgSalary
FROM Departments d
JOIN Employees e
ON d.DepartmentID=e.DepartmentID
JOIN Payroll p
ON e.EmployeeID=p.EmployeeID
GROUP BY d.DepartmentName;

-- ==========================================
-- PAYROLL QUERIES
-- ==========================================

-- 10. Total Payroll Cost
SELECT SUM(NetSalary) AS TotalPayroll
FROM Payroll;

-- 11. Average Net Salary
SELECT ROUND(AVG(NetSalary),2) AS AverageSalary
FROM Payroll;

-- 12. Highest Salary
SELECT MAX(NetSalary) AS HighestSalary
FROM Payroll;

-- 13. Lowest Salary
SELECT MIN(NetSalary) AS LowestSalary
FROM Payroll;

-- 14. Top 10 Highest Paid Employees
SELECT e.EmployeeName,
p.NetSalary
FROM Employees e
JOIN Payroll p
ON e.EmployeeID=p.EmployeeID
ORDER BY p.NetSalary DESC
LIMIT 10;

-- 15. Total Bonus Paid
SELECT SUM(Bonus) AS TotalBonus
FROM Payroll;

-- 16. Total PF Contribution
SELECT SUM(PF) AS TotalPF
FROM Payroll;

-- ==========================================
-- ATTENDANCE QUERIES
-- ==========================================

-- 17. Average Present Days
SELECT ROUND(AVG(PresentDays),2) AS AvgPresentDays
FROM Attendance;

-- 18. Average Leave Days
SELECT ROUND(AVG(LeaveDays),2) AS AvgLeaveDays
FROM Attendance;

-- 19. Average Overtime Hours
SELECT ROUND(AVG(OvertimeHours),2) AS AvgOvertime
FROM Attendance;

-- 20. Employees with Highest Attendance
SELECT EmployeeID,
PresentDays
FROM Attendance
ORDER BY PresentDays DESC
LIMIT 10;

-- ==========================================
-- LEAVE QUERIES
-- ==========================================

-- 21. Leave Type Count
SELECT LeaveType,
COUNT(*) AS Total
FROM Leave_Records
GROUP BY LeaveType;

-- 22. Total Leave Days
SELECT SUM(Days) AS TotalLeaveDays
FROM Leave_Records;

-- ==========================================
-- JOIN QUERIES
-- ==========================================

-- 23. Employee with Department
SELECT e.EmployeeID,
e.EmployeeName,
d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID=d.DepartmentID;

-- 24. Employee Salary Report
SELECT e.EmployeeName,
d.DepartmentName,
p.NetSalary
FROM Employees e
JOIN Departments d
ON e.DepartmentID=d.DepartmentID
JOIN Payroll p
ON e.EmployeeID=p.EmployeeID;

-- 25. Employee Attendance Report
SELECT e.EmployeeName,
a.PresentDays,
a.LeaveDays,
a.OvertimeHours
FROM Employees e
JOIN Attendance a
ON e.EmployeeID=a.EmployeeID;

-- ==========================================
-- ADVANCED QUERIES
-- ==========================================

-- 26. Employees earning above Average Salary
SELECT e.EmployeeName,
p.NetSalary
FROM Employees e
JOIN Payroll p
ON e.EmployeeID=p.EmployeeID
WHERE p.NetSalary >
(
SELECT AVG(NetSalary)
FROM Payroll
);

-- 27. Department-wise Payroll
SELECT d.DepartmentName,
SUM(p.NetSalary) AS PayrollCost
FROM Departments d
JOIN Employees e
ON d.DepartmentID=e.DepartmentID
JOIN Payroll p
ON e.EmployeeID=p.EmployeeID
GROUP BY d.DepartmentName;

-- 28. Employees Joined After 2023
SELECT EmployeeName,
JoiningDate
FROM Employees
WHERE JoiningDate>'2023-12-31';

-- 29. Employee Count by Employment Type
SELECT EmploymentType,
COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY EmploymentType;

-- 30. Complete Employee Report
SELECT
e.EmployeeID,
e.EmployeeName,
d.DepartmentName,
e.Designation,
a.PresentDays,
a.LeaveDays,
p.NetSalary
FROM Employees e
JOIN Departments d
ON e.DepartmentID=d.DepartmentID
JOIN Attendance a
ON e.EmployeeID=a.EmployeeID
JOIN Payroll p
ON e.EmployeeID=p.EmployeeID;