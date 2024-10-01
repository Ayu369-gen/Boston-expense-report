select * from combined_checkbook;


INSERT INTO CheckbookTransaction (VendorName, Entered, MonthNumber, FiscalMonth, Month, FiscalYear, Year, DeptName, MonetaryAmount)
SELECT 
    vendor_name, 
    entered, 
    month_number, 
    fiscal_month, 
    month, 
    fiscal_year, 
    year, 
    dept_name, 
    monetary_amount
FROM 
    combined_checkbook;

	CREATE TABLE CheckbookTransaction (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    VendorName NVARCHAR(255),
    Entered DATETIME,
    MonthNumber INT,
    FiscalMonth INT,
    Month NVARCHAR(50),
    FiscalYear INT,
    Year INT,
    DeptName NVARCHAR(255),
    MonetaryAmount DECIMAL(19, 4)
);

select * from CheckbookTransaction;

ALTER TABLE CheckbookTransaction
ADD VendorID INT;

-- Assuming that VendorName is the column that matches vendor_name in VendorDim
UPDATE ct
SET ct.VendorID = vd.vendor_id
FROM CheckbookTransaction ct
INNER JOIN vendorDIM vd ON ct.VendorName = vd.vendor_name;

ALTER TABLE CheckbookTransaction
ADD DepartmentID INT;


-- Assuming dept_name matches DepartmentName between CheckbookTransaction and Department tables
UPDATE ct
SET ct.DepartmentID = d.DepartmentID
FROM CheckbookTransaction ct
INNER JOIN Department d ON ct.DeptName = d.DepartmentName;
