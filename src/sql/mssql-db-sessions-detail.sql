-- 
-- Author: Matticusau
-- Purpose: Provides insights into open sessions in the current database
-- License: https://github.com/Matticusau/sqlops-mssql-db-insights/blob/master/LICENSE
-- 
-- When         Who         What
-- 2018-06-27   Matticusau  Friendly column names
--

SELECT es.[session_id] [Session Id]
    , es.[status] [Status]
	, es.[login_name] [Login Name]
	, es.[login_time] [Login Time]
	, es.[host_name] [Host Name]
	, es.[program_name] [Program Name]
	, es.[client_interface_name] [Client Interface Name]
	, es.[cpu_time] [CPU Time]
	, es.[memory_usage] [Memory Usage]
	, es.[reads] [Reads]
	, es.[writes] [Writes]
	, es.[logical_reads] [Logical Reads]
	, es.[last_request_start_time] [Last Request Start Time]
	, es.[last_request_end_time] [Last Request End Time]
	, es.[total_elapsed_time] [Total Elapsed Time]
	, es.[open_transaction_count] [Open Transaction Count]
FROM [sys].[dm_exec_sessions] es
WHERE es.[database_id] = DB_ID()
ORDER BY es.[session_id]
