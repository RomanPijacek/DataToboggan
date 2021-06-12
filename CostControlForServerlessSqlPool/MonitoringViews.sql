USE DataTobogganDB;
GO

--------------------------------------------------------------------------------------------------------------------------------------
-- Top 3 most expensive queries:
--------------------------------------------------------------------------------------------------------------------------------------

CREATE OR ALTER VIEW dbo.vMostExpensiveQueries
AS
    SELECT TOP(3)
        erh.query_hash,
        erh.query_text,
        MAX(erh.data_processed_mb) AS data_processed_mb
    FROM
        sys.dm_exec_requests_history AS erh
    WHERE
        erh.query_text != '*** Global stats query ***'    
    GROUP BY
        erh.query_hash,
        erh.query_text
    ORDER BY
        data_processed_mb DESC;
GO

SELECT * FROM dbo.vMostExpensiveQueries;
GO

--------------------------------------------------------------------------------------------------------------------------------------
-- Top 3 most active users:
--------------------------------------------------------------------------------------------------------------------------------------

CREATE OR ALTER VIEW dbo.vMostActiveUsers
AS
    SELECT TOP(3)
        erh.login_name,
        SUM(erh.data_processed_mb) AS total_data_processed_mb 
    FROM 
        sys.dm_exec_requests_history AS erh
    WHERE
        erh.login_name != 'sqladminuser' -- remove the WHERE clause to include the sqladminuser as well
    GROUP BY
        erh.login_name
    ORDER BY    
        total_data_processed_mb DESC;
GO

SELECT * FROM dbo.vMostActiveUsers;
GO

--------------------------------------------------------------------------------------------------------------------------------------
-- EOF
--------------------------------------------------------------------------------------------------------------------------------------
