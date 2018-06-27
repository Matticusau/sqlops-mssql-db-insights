-- 
-- Author: Matticusau
-- Purpose: Provides insights into WAITING sessions in the current database
-- License: https://github.com/Matticusau/sqlops-mssql-db-insights/blob/master/LICENSE
-- 
-- When         Who         What
-- 2018-06-27   Matticusau  Friendly column names
--

SELECT er.[session_id] [Session Id]
	, er.[wait_type] [Wait Type]
	, er.[wait_time] [Wait Time]
FROM [sys].[dm_exec_requests] er
WHERE er.[database_id] = DB_ID()
GROUP BY er.[wait_type]
HAVING er.[wait_type] <> 'NULL'
ORDER BY er.[wait_time] DESC
	, er.[wait_type]
