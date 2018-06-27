-- 
-- Author: Matticusau
-- Purpose: Provides detailed data for the DB Space Used Insights Widget
-- License: https://github.com/Matticusau/sqlops-widgets/blob/master/LICENSE
-- 
-- When         Who         What
-- 2018-06-27   Matticusau  Friendly column names
--
SELECT file_id [File Id]
    , name [Logical Name]
    , type_desc [Type]
    , physical_name [Physical Name]
    , CONVERT(decimal(18,2), size/128.0) [File Size Mb]
    , CONVERT(decimal(18,2), max_size/128.0) [Max Growth Size Mb]
    , CONVERT(decimal(18,2), FILEPROPERTY(name, 'SpaceUsed')/128.0) [Used Mb]
    , CONVERT(decimal(18,2), size/128.0) - CONVERT(decimal(18,2), FILEPROPERTY(name,'SpaceUsed')/128.0) AS [Free Mb] 
    , CONVERT(decimal(18,2), (FILEPROPERTY(name, 'SpaceUsed')/128.0) / (size/128.0) * 100) [% Used]
    , 100 - CONVERT(decimal(18,2), (FILEPROPERTY(name, 'SpaceUsed')/128.0) / (size/128.0) * 100) AS [% Free] 
FROM sys.database_files
ORDER BY type_desc
    , file_id