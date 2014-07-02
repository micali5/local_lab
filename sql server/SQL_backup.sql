declare @name varchar(128) -- db
declare @path varchar(512) -- path
declare @fname varchar(512) -- fname bkp
declare @fdate varchar(50) --fname

select @fdate = convert(varchar(50),getdate(),112)
set @path = 'C:\DBBKP\'

declare db_cursor cursor for
select name
from master.dbo.sysdatabases
where name not in ('tempdb')

open db_cursor
fetch next from db_cursor into @name

while @@fetch_status = 0
begin
	set @fname = @path + @name + '_' + @fdate + '.bak'
	backup database @name to disk = @fname
	
	fetch next from db_cursor into @name
end

close db_cursor
deallocate db_cursor
