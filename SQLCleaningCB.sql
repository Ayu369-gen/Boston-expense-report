SELECT * FROM checkbook_19
UNION ALL
SELECT * FROM checkbook_20
UNION ALL
SELECT * FROM checkbook_21
UNION ALL
SELECT * FROM checkbook_22
UNION ALL
SELECT * FROM checkbook_23
UNION ALL
SELECT * FROM checkbook_24;

SELECT * FROM checkbook_19

SELECT * FROM checkbook_20
UNION ALL
SELECT * FROM checkbook_21
UNION ALL
SELECT * FROM checkbook_22
UNION ALL
SELECT * FROM checkbook_23
UNION ALL
SELECT * FROM checkbook_24;

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'checkbook_24' 
ORDER BY ORDINAL_POSITION;

ALTER TABLE checkbook_24
ALTER COLUMN voucher INT;

SELECT 
  TRY_CAST(voucher AS INT) AS voucher
FROM 
  checkbook_24;


CREATE TABLE combined_checkbook AS
SELECT voucher AS voucher, voucher_line AS voucher_line, distribution_line AS distribution_line, entered AS entered, month_number AS month_number, fiscal_month AS fiscal_month,
month AS month, fiscal_year AS fiscal_year, year AS year, vendor_name AS vendor_name, account AS account, account_descr AS account_descr, dept AS desp_id, dept_name AS dept_name,
c6_digit_org_name AS Description, monetary_amount AS monetary_amount
FROM checkbook_19

UNION ALL

SELECT voucher AS voucher, voucher_line AS voucher_line, distribution_line AS distribution_line, entered AS entered, month_number AS month_number, fiscal_month AS fiscal_month,
month AS month, fiscal_year AS fiscal_year, year AS year, vendor_name AS vendor_name, account AS account, account_descr AS account_descr, dept AS desp_id, dept_name AS dept_name,
c6_digit_org_name AS Description, monetary_amount AS monetary_amount
FROM checkbook_20

UNION ALL

SELECT voucher AS voucher, voucher_line AS voucher_line, distribution_line AS distribution_line, entered AS entered, month_number AS month_number, fiscal_month AS fiscal_month,
month AS month, fiscal_year AS fiscal_year, year AS year, vendor_name AS vendor_name, account AS account, account_descr AS account_descr, dept AS desp_id, dept_name AS dept_name,
c6_digit_org_name AS Description, monetary_amount AS monetary_amount
FROM checkbook_21

UNION ALL

SELECT voucher AS voucher, voucher_line AS voucher_line, distribution_line AS distribution_line, entered AS entered, month_number AS month_number, fiscal_month AS fiscal_month,
month AS month, fiscal_year AS fiscal_year, year AS year, vendor_name AS vendor_name, account AS account, account_descr AS account_descr, dept AS desp_id, dept_name AS dept_name,
c6_digit_org_name AS Description, monetary_amount AS monetary_amount
FROM checkbook_22

UNION ALL

SELECT voucher AS voucher, voucher_line AS voucher_line, distribution_line AS distribution_line, entered AS entered, month_number AS month_number, fiscal_month AS fiscal_month,
month AS month, fiscal_year AS fiscal_year, year AS year, vendor_name AS vendor_name, account AS account, account_descr AS account_descr, dept AS desp_id, dept_name AS dept_name,
c6_digit_org_name AS Description, monetary_amount AS monetary_amount
FROM checkbook_23

UNION ALL

SELECT voucher AS voucher, voucher_line AS voucher_line, distribution_line AS distribution_line, entered AS entered, month_number AS month_number, fiscal_month AS fiscal_month,
month AS month, fiscal_year AS fiscal_year, year AS year, vendor_name AS vendor_name, account AS account, account_descr AS account_descr, dept AS desp_id, dept_name AS dept_name,
c6_digit_org_name AS Description, monetary_amount AS monetary_amount
FROM checkbook_24;

-- Add a new temporary column with the INT data type
ALTER TABLE checkbook_24 ADD Voucher_n INT;

-- Try to update the new column with the integer values of the original column
UPDATE checkbook_24
SET Voucher_n = TRY_CAST(Voucher AS INT);

-- Check for any NULL values that indicate a failed conversion
SELECT * FROM checkbook_24
WHERE Voucher_n IS NULL;

DELETE FROM checkbook_24
WHERE Voucher_n IS NULL;

-- If there are no NULL values and you're sure about the change, continue
-- Drop the original column
ALTER TABLE checkbook_24 DROP COLUMN Voucher;

-- Rename the temporary column to the original column name
EXEC sp_rename 'checkbook_24.Voucher_n', 'Voucher', 'COLUMN';

-- Now your originalColumn is effectively changed to an INT data type

CREATE TABLE combined_checkbook AS
SELECT voucher, voucher_line, distribution_line, entered, month_number, fiscal_month,
month, fiscal_year, year, vendor_name, account, account_descr, dept AS desp_id, dept_name,
c6_digit_org_name AS Description, monetary_amount
FROM checkbook_19

UNION ALL

SELECT voucher, voucher_line, distribution_line, entered, month_number, fiscal_month,
month, fiscal_year, year, vendor_name, account, account_descr, dept, dept_name,
c6_digit_org_name, monetary_amount
FROM checkbook_20

UNION ALL

SELECT voucher, voucher_line, distribution_line, entered, month_number, fiscal_month,
month, fiscal_year, year, vendor_name, account, account_descr, dept, dept_name,
c6_digit_org_name, monetary_amount
FROM checkbook_21

UNION ALL

SELECT voucher, voucher_line, distribution_line, entered, month_number, fiscal_month,
month, fiscal_year, year, vendor_name, account, account_descr, dept, dept_name,
c6_digit_org_name, monetary_amount
FROM checkbook_22

UNION ALL

SELECT voucher, voucher_line, distribution_line, entered, month_number, fiscal_month,
month, fiscal_year, year, vendor_name, account, account_descr, dept, dept_name,
c6_digit_org_name, monetary_amount
FROM checkbook_23

UNION ALL

SELECT voucher, voucher_line, distribution_line, entered, month_number, fiscal_month,
month, fiscal_year, year, vendor_name, account, account_descr, dept, dept_name,
c6_digit_org_name, monetary_amount
FROM checkbook_24;












