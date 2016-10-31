declare @StartTest as datetime, @EndTest as datetime
set @StartTest = '09-05-2016'
set @EndTest = '09-06-2016'


use Amalthee;


select
	[id] = O.id,
	[BeginingDate] = O.BeginningDate,
	[EndingDate] = O.EndingDate,
	[id_operation] = OT.id,
	[name_operation] = OT.Name,
	[delta_sec] = DATEDIFF(ss, O.BeginningDate, O.EndingDate),
	[timeDiff] = CONVERT(nvarchar(30), O.EndingDate-O.BeginningDate, 114),
	[id_payment] = BP.id,
	[payment_date] = BP.PaymentDate,
	[comment] = BP.Comment,
	[user_name] = U.UserName,
	[br_code] = Br.BranchCode,
	[br_name] = Br.Name

from
	tmp.Operations as O
left join
	tmp.OperationTypes as OT
		on OT.gid = O.OperationTypeGID
left join
	Ganimed.dbo.BankPayments as BP
		on BP.gid = O.EntityGID
left join
	Himalia.dbo.Users as U
		on U.gid = O.UserGID
left join
	Himalia.dbo.Branches as Br
		on U.BranchGID = Br.gid
where
	O.BeginningDate between @StartTest and @EndTest
order by O.id desc