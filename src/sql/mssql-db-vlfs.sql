-- 
-- Author: Matticusau
-- Purpose: Provides insights into all VLFs in the current database
-- License: https://github.com/Matticusau/sqlops-mssql-instance-insights/blob/master/LICENSE
-- Original script: https://github.com/Microsoft/DataInsightsAsia/blob/Dev/Scripts/VLFs/VLFsReport.sql
-- 
-- When         Who         What
-- 2018-06-27   Matticusau  Friendly column names
--

-- check if we are running on Azure PaaS
DECLARE @isAzurePaaS BIT;
IF ((SELECT @@Version) LIKE 'Microsoft SQL Azure%')
    SET @isAzurePaaS = 1;
ELSE
    SET @isAzurePaaS = 0;


IF (@isAzurePaaS = 0)
BEGIN

    SET NOCOUNT ON;

    -- declare variables required
    DECLARE @majorVer SMALLINT, @minorVer SMALLINT, @build SMALLINT
    DECLARE @DatabaseId INT;
    DECLARE @TSQL varchar(MAX);
    DECLARE cur_DBs CURSOR FOR
        SELECT database_id
        FROM sys.databases
        --WHERE name NOT IN (N'master',N'model',N'msdb',N'tempdb');
        WHERE database_id = DB_ID();                                  -- filter to just the current
    OPEN cur_DBs;
    FETCH NEXT FROM cur_DBs INTO @DatabaseId

    -- Get the version
    SELECT @majorVer = (@@microsoftversion / 0x1000000) & 0xff, @minorVer = (@@microsoftversion / 0x10000) & 0xff, @build = @@microsoftversion & 0xffff

    -- These table variables will be used to store the data
    DECLARE @tblAllDBs Table (DBName sysname
        , FileId INT
        , FileSize BIGINT
        , StartOffset BIGINT
        , FSeqNo INT
        , Status TinyInt
        , Parity INT
        , CreateLSN NUMERIC(25,0)
    )
    IF ( @majorVer >= 11 )
    BEGIN
        DECLARE @tblVLFs2012 Table (RecoveryUnitId BIGINT
            , FileId INT
            , FileSize BIGINT
            , StartOffset BIGINT
            , FSeqNo INT
            , Status TinyInt
            , Parity INT
            , CreateLSN NUMERIC(25,0)
        );
    END
    ELSE
    BEGIN
        DECLARE @tblVLFs Table (
            FileId INT
            , FileSize BIGINT
            , StartOffset BIGINT
            , FSeqNo INT
            , Status TinyInt
            , Parity INT
            , CreateLSN NUMERIC(25,0)
        );
    END

    --loop through each database and get the info
    WHILE @@FETCH_STATUS = 0
    BEGIN
        
        PRINT 'DB: ' + CONVERT(varchar(200), DB_NAME(@DatabaseId));
        SET @TSQL = 'dbcc loginfo('+CONVERT(varchar(12), @DatabaseId)+');';

        IF ( @majorVer >= 11 )
        BEGIN
            DELETE FROM @tblVLFs2012;
            INSERT INTO @tblVLFs2012
            EXEC(@TSQL);
            INSERT INTO @tblAllDBs 
            SELECT DB_NAME(@DatabaseId)
                , FileId
                , FileSize
                , StartOffset
                , FSeqNo
                , Status
                , Parity
                , CreateLSN 
            FROM @tblVLFs2012;
        END
        ELSE
        BEGIN
            DELETE FROM @tblVLFs;
            INSERT INTO @tblVLFs 
            EXEC(@TSQL);
            INSERT INTO @tblAllDBs 
            SELECT DB_NAME(@DatabaseId)
                , FileId
                , FileSize
                , StartOffset
                , FSeqNo
                , Status
                , Parity
                , CreateLSN 
            FROM @tblVLFs;
        END

        FETCH NEXT FROM cur_DBs INTO @DatabaseId
    END
    CLOSE cur_DBs;
    DEALLOCATE cur_DBs;

    --just for formating if output to Text
    PRINT '';
    PRINT '';
    PRINT '';

    --Return the data based on what we have found
    SELECT --a.DBName
        --, 
        COUNT(a.FileId) AS [Total VLFs]
        , MAX(b.[ActiveVLFs]) AS [Active VLFs]
        --, (SUM(a.FileSize) / COUNT(a.FileId) / 1024) AS [Avg File Size Kb]
    FROM @tblAllDBs a
    INNER JOIN (
        SELECT DBName
            , COUNT(FileId) [ActiveVLFs]
        FROM @tblAllDBs 
        WHERE Status = 2
        GROUP BY DBName
        ) b
        ON b.DBName = a.DBName
    GROUP BY a.DBName
    ORDER BY COUNT(a.FileId) DESC;


    SET NOCOUNT OFF;

END
ELSE
BEGIN
    -- not supported on Azure so return an empty recordset
    SELECT --'NotSupportedOnAzure' AS [DBName]
        --,
        0 AS [Total VLFs]
        , 0 AS [Active VLFs]
        --, 0 AS [AvgFileSizeKb]
END