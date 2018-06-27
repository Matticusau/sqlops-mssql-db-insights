-- 
-- Author: Matticusau
-- Purpose: Provides insights into session resource usage in the current database
-- License: https://github.com/Matticusau/sqlops-mssql-db-insights/blob/master/LICENSE
-- 
-- When         Who         What
-- 2018-06-27   Matticusau  Friendly column names
--

SELECT er.[status]
	, SUM(er.[cpu_time]) [CPU]
	, SUM(er.[reads]) [Reads]
	, SUM(er.[logical_reads]) [Logical Reads]
	, SUM(er.[writes]) [Writes]
FROM [sys].[dm_exec_requests] er
WHERE er.[database_id] = DB_ID()
GROUP BY er.[status]
ORDER BY SUM(er.[cpu_time]) DESC, er.[status]
