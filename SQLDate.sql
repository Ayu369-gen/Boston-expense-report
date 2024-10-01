select * from combined_earnings;
select * from combined_checkbook;
select * from vendorDIM;

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'combined_checkbook' 
ORDER BY ORDINAL_POSITION;

-- Start of the script
drop table DateDimension;

-- Create the Date Dimension table with the appropriate columns
CREATE TABLE DateDimension (
    DateKey INT PRIMARY KEY,
    Date DATE NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    Month INT NOT NULL,
    DayOfMonth INT NOT NULL,
    DayOfWeek INT NOT NULL,
    WeekOfYear INT NOT NULL,
    FiscalYear INT NOT NULL,
    FiscalQuarter INT NOT NULL,
    FiscalMonth INT NOT NULL,
    FiscalDayOfYear INT NOT NULL
);

-- Declare your starting and ending dates
DECLARE @StartDate DATE = '2018-01-01';
DECLARE @EndDate DATE = '2023-12-31';

-- Declare your fiscal year start month
DECLARE @FiscalYearStartMonth INT = 7;

-- Declare a variable to hold the current date being processed
DECLARE @CurrentDate DATE = @StartDate;

-- Loop through each day and insert into the date dimension table
WHILE @CurrentDate <= @EndDate
BEGIN
    INSERT INTO DateDimension (
        DateKey,
        Date,
        Year,
        Quarter,
        Month,
        DayOfMonth,
        DayOfWeek,
        WeekOfYear,
        FiscalYear,
        FiscalQuarter,
        FiscalMonth,
        FiscalDayOfYear
    )
    VALUES (
        CONVERT(INT, REPLACE(CONVERT(VARCHAR(10), @CurrentDate, 112), '-', '')), -- DateKey as INT YYYYMMDD
        @CurrentDate, -- Date
        YEAR(@CurrentDate), -- Year
        DATEPART(QUARTER, @CurrentDate), -- Quarter
        MONTH(@CurrentDate), -- Month
        DAY(@CurrentDate), -- DayOfMonth
        DATEPART(WEEKDAY, @CurrentDate), -- DayOfWeek
        DATEPART(WEEK, @CurrentDate), -- WeekOfYear
        -- Calculate FiscalYear
CASE 
    WHEN MONTH(@CurrentDate) >= @FiscalYearStartMonth 
    THEN YEAR(@CurrentDate) + 1 
    ELSE YEAR(@CurrentDate) 
END,

-- Calculate FiscalQuarter
CASE
    WHEN MONTH(@CurrentDate) >= @FiscalYearStartMonth THEN (MONTH(@CurrentDate) - @FiscalYearStartMonth + 3) / 3
    WHEN MONTH(@CurrentDate) < @FiscalYearStartMonth THEN (MONTH(@CurrentDate) + 9) / 3
END,


-- Calculate FiscalMonth
CASE 
    WHEN MONTH(@CurrentDate) >= @FiscalYearStartMonth 
    THEN MONTH(@CurrentDate) - @FiscalYearStartMonth + 1 
    ELSE MONTH(@CurrentDate) - @FiscalYearStartMonth + 13 
END,

-- Calculate the FiscalDayOfYear
(DATEDIFF(DAY, 
    CASE 
        WHEN MONTH(@CurrentDate) >= @FiscalYearStartMonth 
        THEN DATEFROMPARTS(YEAR(@CurrentDate), @FiscalYearStartMonth, 1)
        ELSE DATEFROMPARTS(YEAR(@CurrentDate) - 1, @FiscalYearStartMonth, 1)
    END, 
    @CurrentDate) + 1
)

    );

    -- Increment the current date by 1 day
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END;

-- End of the script


select * from DateDimension; 

DECLARE @FiscalYearStartMonth INT = 7;

UPDATE DateDimension
SET FiscalQuarter = CASE 
    WHEN MONTH(Date) >= @FiscalYearStartMonth AND MONTH(Date) <= @FiscalYearStartMonth + 2 THEN 1
    WHEN MONTH(Date) >= @FiscalYearStartMonth + 3 AND MONTH(Date) <= @FiscalYearStartMonth + 5 THEN 2
    WHEN MONTH(Date) >= @FiscalYearStartMonth + 6 AND MONTH(Date) <= @FiscalYearStartMonth + 8 THEN 3
    WHEN MONTH(Date) >= @FiscalYearStartMonth + 9 OR MONTH(Date) < @FiscalYearStartMonth THEN 4
END
WHERE Date >= '2018-01-01' AND Date <= '2023-12-31';

UPDATE DateDimension
SET FiscalQuarter = CASE 
    WHEN MONTH(Date) BETWEEN 7 AND 9 THEN 1 -- Q1: July to September
    WHEN MONTH(Date) BETWEEN 10 AND 12 THEN 2 -- Q2: October to December
    WHEN MONTH(Date) BETWEEN 1 AND 3 THEN 3 -- Q3: January to March
    WHEN MONTH(Date) BETWEEN 4 AND 6 THEN 4 -- Q4: April to June
    ELSE FiscalQuarter -- No change for dates outside this range, just in case
END;

select * from combined_earnings; 

CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    DepartmentID INT NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    TotalEarnings DECIMAL(19, 4) NOT NULL,
    Year INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);


INSERT INTO Employee (FirstName, LastName, DepartmentID, Title, TotalEarnings, Year)
SELECT 
    -- If there's a comma, take everything after it as the first name; otherwise, take everything after the first space.
    LTRIM(RTRIM(
        CASE 
            WHEN CHARINDEX(',', Name) > 0 THEN SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name))
            ELSE SUBSTRING(Name, CHARINDEX(' ', Name) + 1, LEN(Name))
        END
    )) AS FirstName,
    
    -- If there's a comma, take everything before it as the last name; otherwise, take the whole name as the last name.
    CASE 
        WHEN CHARINDEX(',', Name) > 0 THEN LEFT(Name, CHARINDEX(',', Name) - 1)
        ELSE Name
    END AS LastName,

    -- The DepartmentID would come from a subquery or another table.
    -- For this example, we're using a placeholder value.
    (SELECT TOP 1 DepartmentID FROM Department WHERE DepartmentName = st.DEPARTMENT_NAME) AS DepartmentID,
    
    Title,
    TOTAL_EARNINGS,
    Year
FROM 
    combined_earnings st
WHERE
    Name IS NOT NULL AND LTRIM(RTRIM(Name)) <> '';  -- Ensure the name is not null or empty

	