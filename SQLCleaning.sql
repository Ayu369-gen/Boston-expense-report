SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'combined_checkbook' 
ORDER BY ORDINAL_POSITION;

-- Add a new temporary column with the INT data type
ALTER TABLE employee_20 ADD earnings FLOAT;

-- Try to update the new column with the integer values of the original column
UPDATE employee_20
SET earnings = TRY_CAST(TOTAL_EARNINGS AS FLOAT);

-- Check for any NULL values that indicate a failed conversion
SELECT * FROM employee_20
WHERE earnings IS NULL;

DELETE FROM employee_20
WHERE earnings IS NULL;

-- If there are no NULL values and you're sure about the change, continue
-- Drop the original column
ALTER TABLE employee_20 DROP COLUMN TOTAL_EARNINGS;

-- Rename the temporary column to the original column name
EXEC sp_rename 'employee_20.earnings', 'TOTAL_EARNINGS', 'COLUMN';

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


select * from combined_earnings;

ALTER TABLE employee_18 ADD YEAR INT;
ALTER TABLE employee_19 ADD YEAR INT;
ALTER TABLE employee_20 ADD YEAR INT;
ALTER TABLE employee_21 ADD YEAR INT;
ALTER TABLE employee_22 ADD YEAR INT;
ALTER TABLE employee_23 ADD YEAR INT;

UPDATE employee_18 SET YEAR = 2018;
UPDATE employee_19 SET YEAR = 2019;
UPDATE employee_20 SET YEAR = 2020;
UPDATE employee_21 SET YEAR = 2021;
UPDATE employee_22 SET YEAR = 2022;
UPDATE employee_23 SET YEAR = 2023;


DROP TABLE combined_earnings;

select * from combined_checkbook;
select * from combined_earnings;

CREATE TABLE vendorDIM (
		vendor_id INT IDENTITY(1,1) PRIMARY KEY,
		vendor_name VARCHAR(255),
		ServiceProvided VARCHAR(255),
);

SELECT DISTINCT
 REPLACE(vendor_name, ' ', '_') AS vendor_name,
 REPLACE(account_descr, ' ', '_') AS account_descr
 FROM combined_checkbook;

 INSERT INTO vendorDIM (vendor_name, ServiceProvided)
 SELECT DISTINCT
 REPLACE(vendor_name, ' ', '_') AS vendor_name,
 REPLACE(account_descr, ' ', '_') AS account_descr
 FROM combined_checkbook;

 select * from vendorDIM;

SELECT DISTINCT
 REPLACE(dept_name, ' ', '_') AS dept_name
 FROM combined_checkbook
UNION
 SELECT DISTINCT
 REPLACE(DEPARTMENT_NAME, ' ', '_') AS DEPARTMENT_NAME
 FROM combined_earnings;

 SELECT DISTINCT a.dept_name
FROM (
    SELECT REPLACE(dept_name, ' ', '_') AS dept_name
    FROM combined_checkbook
) a
JOIN (
    SELECT REPLACE(DEPARTMENT_NAME, ' ', '_') AS DEPARTMENT_NAME
    FROM combined_earnings
) b ON a.dept_name = b.DEPARTMENT_NAME;

SELECT DISTINCT
    REPLACE(dept_name, ' ', '_') AS dept_name,
    Description
FROM combined_checkbook

UNION

SELECT DISTINCT
    REPLACE(DEPARTMENT_NAME, ' ', '_') AS DEPARTMENT_NAME,
    NULL AS Description  -- Assuming there is no Description column in combined_earnings
FROM combined_earnings;

