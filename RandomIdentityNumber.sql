--create type NumbersTable as table(
--Id tinyint,
--Number tinyint
--)


--create view GetRand
--as
--SELECT RAND() AS VALUE


create function IdentityNumber()
returns char(11)
as
begin


declare @sum int, @i int, @identityNumber char(11), @temp int, @rand float
declare @Numbers NumbersTable
select @rand = Value from GetRand
SET @temp = convert(int, @rand * 9 + 1)
INSERT INTO @Numbers values(1, @temp)

set @i=2
while @i<11
begin
select @rand = VALUE FROM GetRand
set @temp=CONVERT(int, @rand*10)
select @temp
INSERT INTO @Numbers values(@i, @temp)
set @i=@i+1
end


select @sum=SUM(Number) from @Numbers where Id in (1,2,3,4,5,6,7,8,9,10)

set @temp=@sum % 10
insert into @Numbers values(11, @temp)


select @identityNumber = SUBSTRING(( select '' + cast(Number as varchar) from @Numbers for xml path('')), 0, 2000)

return @identityNumber
END
