USE master
EXEC sp_configure 'show advanced options', 1
RECONFIGURE WITH OVERRIDE 

USE master
EXEC sp_configure 'max server memory (MB)' , 16384

USE master
EXEC sp_configure 'show advanced options', 0
RECONFIGURE WITH OVERRIDE 