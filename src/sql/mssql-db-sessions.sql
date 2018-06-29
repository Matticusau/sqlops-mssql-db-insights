-- 
-- Author: Matticusau
-- Purpose: Provides insights into open sessions in the current database
-- License: https://github.com/Matticusau/sqlops-mssql-db-insights/blob/master/LICENSE
-- 
-- When         Who         What
-- 2018-06-27   Matticusau  Friendly column names
--

SELECT es.[status] [Status]
    , COUNT(es.[session_id]) [Count]
FROM [sys].[dm_exec_sessions] es
WHERE es.[database_id] = DB_ID()
GROUP BY es.[status]
ORDER BY es.[status]
