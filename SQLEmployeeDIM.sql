SELECT DISTINCT
 REPLACE(dept_name, ' ', '_') AS dept_name
 FROM combined_checkbook
UNION
 SELECT DISTINCT
 REPLACE(DEPARTMENT_NAME, ' ', '_') AS DEPARTMENT_NAME
 FROM combined_earnings;

 CREATE TABLE Department (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO Department (DepartmentName)
SELECT DISTINCT
 REPLACE(dept_name, ' ', '_') AS DepartmentName
FROM combined_checkbook
WHERE dept_name IS NOT NULL
UNION
SELECT DISTINCT
 REPLACE(DEPARTMENT_NAME, ' ', '_') AS DepartmentName
FROM combined_earnings
WHERE DEPARTMENT_NAME IS NOT NULL;

select DISTINCT(DEPARTMENT_NAME) from combined_earnings;

SELECT DISTINCT
 REPLACE(DEPARTMENT_NAME, ' ', '_') AS DepartmentName
FROM combined_earnings
UNION
SELECT DISTINCT
 REPLACE(dept_name, ' ', '_') AS DepartmentName
FROM combined_checkbook;

select * from Department;

create table EmployeeDIM (
	EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(255),
    DepartmentID INT,
	DepartmentName VARCHAR(255), 
    Title NVARCHAR(255),
    Year INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

drop table EmployeeDIM;

insert into EmployeeDIM(Name, DepartmentID, DepartmentName, Title, Year)
select ce.Name, d.DepartmentID, d.DepartmentName, ce.Title, ce.year from combined_earnings ce join Department d on ce.DEPARTMENT_NAME = d.DepartmentName;

select * from EmployeeDIM;
select DISTINCT(Name) from combined_earnings;

select * from Department where DepartmentName= 'Boston_Police_Department';

DELETE FROM EmployeeDIM WHERE EmployeeID IN (15, 25);

ALTER TABLE EmployeeDIM
DROP COLUMN Year;

