declare @StartTest as datetime, @EndTest as datetime
set @StartTest = '09-05-2016'
set @EndTest = '09-06-2016'


use Himalia;

select
	P.id,
	PolisNumber,
	CreateDate,
	SelectDate,
	OnSaveDate,
	convert(nvarchar(30), OnSaveDate-SelectDate,   114) as save_select,
	convert(nvarchar(30), CreateDate-OnSaveDate,   114) as create_save,
	U.UserName,
	Br.BranchCode,
	Br.Name
from
	dbo.Products as P
left join
	Himalia.dbo.Users as U
		on U.gid = P.CreatorUserGID
left join
	Himalia.dbo.Branches as Br
		on U.BranchGID = Br.gid
where
	P.CreateDate between @StartTest and @EndTest

order by P.id desc