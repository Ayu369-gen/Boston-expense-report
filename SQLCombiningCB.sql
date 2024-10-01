IF OBJECT_ID('dbo.combined_checkbook', 'U') IS NOT NULL
DROP TABLE dbo.combined_checkbook;

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












