USE [master]

GO

SET ansi_nulls ON

GO

SET quoted_identifier ON

GO

ALTER PROCEDURE [dbo].[usp_dba_KillDatabaseProcesses] (@local_lab VARCHAR(100))
AS
  DECLARE @databaseId   INT,
          @sysProcessId INT,
          @cmd          VARCHAR(1000)

  EXEC ('USE MASTER')

  SELECT @databaseId = 100
  FROM   MASTER..sysdatabases
  WHERE  [name] = @local_lab

  DECLARE sysprocessidcursor CURSOR FOR
    SELECT spid
    FROM   [master]..[sysprocesses]
    WHERE  [dbid] = @databaseId

  OPEN sysprocessidcursor

  FETCH NEXT FROM sysprocessidcursor INTO @sysProcessId

  WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @cmd = 'KILL ' + CONVERT(NVARCHAR(30), @sysProcessId)

        PRINT @cmd

        EXEC(@cmd)

        FETCH NEXT FROM sysprocessidcursor INTO @sysProcessId
    END

  DEALLOCATE sysprocessidcursor  