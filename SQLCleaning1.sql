
INSERT INTO combined_checkbook (voucher, voucher_line, distribution_line, entered, month_number, fiscal_month, month, fiscal_year, year, vendor_name, account, account_descr, desp_id, dept_name, Description, monetary_amount)
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

select * from combined_checkbook where fiscal_year=2023