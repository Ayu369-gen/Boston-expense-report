CREATE TABLE AnnualDateDimension (
    DateKey INT PRIMARY KEY,
    CalendarYear INT NOT NULL,
    FiscalYear INT NOT NULL
);

-- Populate the table with years from 2018 to 2023
DECLARE @StartYear INT = 2018;
DECLARE @EndYear INT = 2023;

WHILE @StartYear <= @EndYear
BEGIN
    INSERT INTO AnnualDateDimension (DateKey, CalendarYear, FiscalYear)
    VALUES (
        @StartYear, -- DateKey
        @StartYear, -- CalendarYear
        CASE 
            WHEN @StartYear >= 2018 AND @StartYear <= @EndYear THEN @StartYear + 1 
            ELSE @StartYear
        END -- FiscalYear calculation
    );
    SET @StartYear = @StartYear + 1;
END;
drop table AnnualDateDimension;

select * from combined_earnings;

INSERT INTO EmployeeEarnings (EmployeeDimID, DateDimID, DepartmentID, TotalEarnings, FiscalYear)
SELECT 
    ed.EmployeeID, 
    ad.DateKey, 
    ed.DepartmentID, 
    ce.TOTAL_EARNINGS,
    ad.FiscalYear
FROM 
    combined_earnings ce
INNER JOIN 
    EmployeeDim ed ON ce.NAME = ed.Name  -- Assuming the NAME is the common key
INNER JOIN 
    AnnualDateDimension ad ON ce.year = ad.CalendarYear  -- Assuming year matches CalendarYear

	CREATE TABLE EmployeeEarnings (
    EarningsID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeDimID INT,
    DateDimID INT,
    DepartmentID INT,
    TotalEarnings DECIMAL(19, 4),
    FiscalYear INT,
    -- Other fields can be added as needed
    FOREIGN KEY (EmployeeDimID) REFERENCES EmployeeDim(EmployeeID),
    FOREIGN KEY (DateDimID) REFERENCES AnnualDateDimension(DateKey),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);
select * from EmployeeEarnings;