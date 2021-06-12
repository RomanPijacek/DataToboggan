USE DataTobogganDB;
GO

--------------------------------------------------------------------------------------
-- Review External Data Process
--------------------------------------------------------------------------------------

SELECT 
    edp.* 
FROM 
    sys.dm_external_data_processed AS edp;
GO

--------------------------------------------------------------------------------------
-- Review the Data Process Daily/Weekly/Monthly limits configuration 
--------------------------------------------------------------------------------------

SELECT 
    cfg.* 
FROM 
    sys.configurations AS cfg
WHERE 
    cfg.name LIKE 'Data processed %';
GO

--------------------------------------------------------------------------------------
-- Set the Data Process Daily/Weekly/Monthly limits
--------------------------------------------------------------------------------------

EXECUTE dbo.sp_set_data_processed_limit	@type = N'daily', @limit_tb = 1;
GO

EXECUTE dbo.sp_set_data_processed_limit @type= N'weekly', @limit_tb = 7;
GO

EXECUTE dbo.sp_set_data_processed_limit	@type= N'monthly', @limit_tb = 28;
GO

--------------------------------------------------------------------------------------
-- EOF
--------------------------------------------------------------------------------------
