select distinct NAME, TITLE from combined_earnings order by NAME;

alter table EmployeeEarnings;
drop table combined_earnings;

CREATE TABLE combined_earnings (
    NAME VARCHAR(255),
    DEPARTMENT_NAME VARCHAR(255),
    TITLE VARCHAR(255),
    TOTAL_EARNINGS FLOAT,
	year INT
);

INSERT INTO combined_earnings (NAME, DEPARTMENT_NAME, TITLE, TOTAL_EARNINGS, year)
SELECT NAME, DEPARTMENT_NAME, TITLE, TOTAL_EARNINGS, year FROM employee_18
UNION ALL
SELECT NAME, DEPARTMENT_NAME, TITLE, TOTAL_EARNINGS, year FROM employee_19
UNION ALL
SELECT NAME, DEPARTMENT_NAME, TITLE, TOTAL_EARNINGS, year FROM employee_20
UNION ALL
SELECT NAME, DEPARTMENT_NAME, TITLE, TOTAL_GROSS, year FROM employee_21
UNION ALL
SELECT NAME, DEPARTMENT_NAME, TITLE, TOTAL_GROSS, year FROM employee_22
UNION ALL
SELECT NAME, DEPARTMENT_NAME, TITLE, TOTAL_GROSS, year FROM employee_23;

SELECT Name, TITLE, COUNT(*) AS RecordCount
FROM combined_earnings
GROUP BY Name, TITLE
ORDER BY Name, RecordCount DESC;

select distinct NAME from combined_earnings order by NAME;

CREATE TABLE EmployeeData (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,  
    EmployeeName NVARCHAR(255)                
);

insert into EmployeeData (EmployeeName)
select distinct NAME from combined_earnings order by NAME;

select * from EmployeeData;

SELECT ed.EmployeeID, ed.EmployeeName, e.DEPARTMENT_NAME, e.TITLE, e.Year
FROM combined_earnings e join EmployeeData ed on e.NAME=ed.EmployeeName WHERE Year='2018' ;

SELECT ed.EmployeeID,
       ed.EmployeeName,
       e.DEPARTMENT_NAME,
       e.TITLE,
       e.Year
INTO emp_rec_23
FROM combined_earnings e
JOIN EmployeeData ed ON e.NAME = ed.EmployeeName
WHERE e.Year = '2023';


	
