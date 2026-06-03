USE [library]

ALTER DATABASE [library]
SET QUERY_STORE = ON;


DBCC FREEPROCCACHE;

SELECT * FROM reserve_borrow;

SELECT 
    [object_name] AS [CounterName], 
    [cntr_value] AS [Value]
FROM 
    sys.dm_os_performance_counters
WHERE 
    [object_name] LIKE '%Plan Cache%'
    AND [counter_name] = 'Cache Hit Ratio';

	SELECT TOP 10
		query_stats.query_hash AS "Query Hash",
		SUM(query_stats.execution_count) AS "Execution Count",
		MIN(query_stats.creation_time) AS "Creation Time",
		MAX(query_stats.last_execution_time) AS "Last Execution Time",
		query_text.text AS "Query Text"
	FROM sys.dm_exec_query_stats AS query_stats
	CROSS APPLY sys.dm_exec_sql_text(query_stats.sql_handle) AS query_text
	GROUP BY query_stats.query_hash, query_text.text
	ORDER BY SUM(query_stats.execution_count) DESC;

SELECT
    database_id,
    file_id,
    page_id,
    page_level,
    allocation_unit_id,
    page_type,
    COUNT(*) AS record_count
FROM sys.dm_os_buffer_descriptors
WHERE database_id = DB_ID('library')
GROUP BY 
    database_id, 
    file_id, 
    page_id, 
    page_level, 
    allocation_unit_id, 
    page_type;

SELECT *
FROM sys.dm_os_process_memory;


