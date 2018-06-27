-- 
-- Author: Matticusau
-- Purpose: Provides summary data for the DB Space Used Insights Widget
-- License: https://github.com/Matticusau/sqlops-widgets/blob/master/LICENSE
-- 
-- When         Who         What
-- 2018-06-27   Matticusau  Friendly column names
--
SELECT type_desc
    -- , CONVERT(decimal(18,2), SUM(size)/128.0) [file_size_mb]
    -- , CONVERT(decimal(18,2), SUM(max_size)/128.0) [max_growth_size_mb]
    -- , CONVERT(decimal(18,2), SUM(FILEPROPERTY(name, 'SpaceUsed'))/128.0) [used_space_mb]
    -- , CONVERT(decimal(18,2), SUM(size)/128.0) - CONVERT(decimal(18,2), SUM(FILEPROPERTY(name,'SpaceUsed'))/128.0) AS [free_space_mb] 
    , CONVERT(decimal(18,2), (SUM(FILEPROPERTY(name, 'SpaceUsed'))/128.0) / (SUM(size)/128.0) * 100) [% Used]
    , 100 - CONVERT(decimal(18,2), (SUM(FILEPROPERTY(name, 'SpaceUsed'))/128.0) / (SUM(size)/128.0) * 100) AS [% Free] 
FROM sys.database_files
WHERE type_desc IN ('ROWS','LOG')
GROUP BY type_desc
ORDER BY type_desc