USE local_lab
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ustp_SQLServerJobs] as
SET NOCOUNT ON

SELECT DISTINCT substring(a.name,1,100) AS [Job Name], 
	'Enabled'=case 
	WHEN a.enabled = 0 THEN 'No'
	WHEN a.enabled = 1 THEN 'Yes'
	end, 
    	substring(b.name,1,30) AS [Name of the schedule],
	'Frequency of the schedule execution'=case
	WHEN b.freq_type = 1 THEN 'Once'
	WHEN b.freq_type = 4 THEN 'Daily'
	WHEN b.freq_type = 8 THEN 'Weekly'
	WHEN b.freq_type = 16 THEN 'Monthly'
	WHEN b.freq_type = 32 THEN 'Monthly relative'	
	WHEN b.freq_type = 32 THEN 'Execute when SQL Server Agent starts'
	END,	
	'Units for the freq_subday_interval'=case
	WHEN b.freq_subday_type = 1 THEN 'At the specified time' 
	WHEN b.freq_subday_type = 2 THEN 'Seconds' 
	WHEN b.freq_subday_type = 4 THEN 'Minutes' 
	WHEN b.freq_subday_type = 8 THEN 'Hours' 
	END,	
	cast(cast(b.active_start_date as varchar(15)) as datetime) as active_start_date,	
	cast(cast(b.active_end_date as varchar(15)) as datetime) as active_end_date,	
	Stuff(Stuff(right('000000'+Cast(c.next_run_time as Varchar),6),3,0,':'),6,0,':') as Run_Time,	
	convert(varchar(24),b.date_created) as Created_Date
	
FROM  msdb.dbo.sysjobs a 
INNER JOIN msdb.dbo.sysJobschedules c ON a.job_id = c.job_id 
INNER JOIN msdb.dbo.SysSchedules b on b.Schedule_id=c.Schedule_id
GO