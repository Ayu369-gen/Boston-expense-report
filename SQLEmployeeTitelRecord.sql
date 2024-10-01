


	CREATE TABLE EmployeeTitleHistory (
    EmployeeTitleHistoryID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    EmployeeName NVARCHAR(255),
	EmployeeDept NVARCHAR(255),
    Title NVARCHAR(255),
    EffectiveDate DATE,
    EndDate DATE,
    IsCurrent BIT
);

DECLARE @CurrentYear INT = 2018;
DECLARE @MaxYear INT = 2023;
DECLARE @SQL NVARCHAR(MAX);

WHILE @CurrentYear <= @MaxYear
BEGIN
    -- Correctly format the table name according to your naming convention
    DECLARE @TableName NVARCHAR(50);
    SET @TableName = 'emp_rec_' + RIGHT(@CurrentYear, 2);  -- Extracts the last two digits of the year

    -- Dynamic SQL to handle SCD Type 2 updates
    SET @SQL = 'INSERT INTO EmployeeTitleHistory (EmployeeID, EmployeeName, EmployeeDept, Title, EffectiveDate, IsCurrent)
                SELECT e.EmployeeID, e.EmployeeName, e.DEPARTMENT_NAME, e.Title, ''' + CAST(@CurrentYear AS VARCHAR) + '-01-01'', 1
                FROM ' + @TableName + ' e
                LEFT JOIN EmployeeTitleHistory h ON e.EmployeeID = h.EmployeeID AND h.IsCurrent = 1
                WHERE h.Title IS NULL OR h.Title <> e.Title;

                UPDATE EmployeeTitleHistory
                SET EndDate = DATEADD(day, -1, ''' + CAST(@CurrentYear AS VARCHAR) + '-01-01''), IsCurrent = 0
                WHERE EmployeeID IN (SELECT EmployeeID FROM ' + @TableName + ') AND IsCurrent = 1 AND Title <> (SELECT TOP 1 Title FROM ' + @TableName + ' WHERE EmployeeID = EmployeeTitleHistory.EmployeeID ORDER BY EmployeeName DESC);';

    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL;

    -- Move to the next year
    SET @CurrentYear = @CurrentYear + 1;
END

select * from EmployeeTitleHistory;

UPDATE EmployeeTitleHistory
SET EndDate = '9999-12-31'
WHERE EndDate IS NULL;


