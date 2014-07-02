del "C:\Database Backups\*.*" /q
"C:\Program Files (x86)\Microsoft SQL Server\90\Tools\Binn\SQLCMD.EXE" -Slocalhost\SQLExpress -Usa -P<sa password> -i"C:\inetpub\SQL Backup Script All Databases.sql"