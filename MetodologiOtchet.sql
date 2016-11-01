use OrantaSch;

declare @BegDate datetime = '09-01-2016';
declare @EndDate datetime = '09-09-2016';
declare @BLId int = 4;
declare @DogDurationTime int = 15;


select
    [ProgTypeId] = PT.Code,
    [ProgTypeName] = PT.Name,
    [PolisNumber] = P.PolisNumber,
    [BeginingDate] = P.BeginingDate,
    [EndingDate] = P.EndingDate,
    [DogTimeDurationID] = CASE 
				    WHEN DATEDIFF(day, P.BeginingDate, P.EndingDate) < 15 THEN 1
				    WHEN 15 <= DATEDIFF(day, P.BeginingDate, P.EndingDate) AND DATEDIFF(day, P.BeginingDate, P.EndingDate) < 30 THEN 2
				    WHEN 30 <= DATEDIFF(day, P.BeginingDate, P.EndingDate) THEN 3
				    END,
    [InsuranceSum] = P.InsuranceSumUkr,
    [InsuranceSumPg] = Pg.CostValue,
    [PersonCount] =	TRY_CONVERT(int, PTPV.ParameterValue),
    [TZCount] = TRY_CONVERT(int, PTTZ.ParameterValue),
    [CGCount] = TRY_CONVERT(int, PTCG.ParameterValue),
    [CVCount] = TRY_CONVERT(int, PTCV.ParameterValue),
    [OCCount] = (SELECT CASE 
	WHEN PTOC.ParameterValue = '1' THEN '1'
	WHEN PTOC.ParameterValue IS NOT NULL THEN (CASE WHEN PPV.Value IS NULL THEN PTOC.ParameterValue ELSE PPV.Value END)
	END),
	[PlannedPayments] = Pay.PlanedValue,
	[RealPayments] = Pay.RealValue

from
    Products as P

inner join
    Programs as Pg
	   on Pg.ProductGID = P.gid
		  and Pg.Deleted = 0

inner join 
    meta.ProgramTypes as PT
	   on PT.gid = Pg.ProgramTypeGID

inner join
    ServiceBase.dbo.BusinessLinesToPrograms as BLTPg
	   on BLTPg.code = PT.Code
		  and BLTPg.businessLineId = @BLId
	   

LEFT JOIN
	dbo.ProgramToParameterValues AS PTPV
		ON PTPV.ProgramGID = Pg.gid
			AND PTPV.Deleted = 0 								
			AND PTPV.ParameterGID = '1388B04C-97B0-4E1D-B697-E363D009293E' 	--Кількість осіб

LEFT JOIN
	dbo.ProgramToParameterValues AS PTTZ
		ON PTTZ.ProgramGID = Pg.gid
			AND PTTZ.Deleted = 0 								
			AND PTTZ.ParameterGID = 'C2C90252-A580-4A6C-930A-85F48E78AA31' 	--Кількість ТЗ

LEFT JOIN
	dbo.ProgramToParameterValues AS PTCG
		ON PTCG.ProgramGID = Pg.gid
			AND PTCG.Deleted = 0 								
			AND PTCG.ParameterGID = '3FC83ED9-67E2-41DB-A5EA-4552BB6CB1CA' 	--Кількість голів

LEFT JOIN
	dbo.ProgramToParameterValues AS PTCV 
		ON PTCV.ProgramGID = Pg.gid
			AND PTCV.Deleted = 0 								
			AND PTCV.ParameterGID = '92EC78AC-9736-4E7D-B810-236BBFC29191'  	--Кількість водіїв

LEFT JOIN
	dbo.ProgramToParameterValues AS PTOC 
		ON PTOC.ProgramGID = Pg.gid
			AND PTOC.Deleted = 0 								
			AND PTOC.ParameterGID = 'F057ADCA-399D-4341-B6AB-5DD2F88E3012' 

LEFT JOIN
	meta.ProgramParameterValues AS PPV
		ON PTOC.ParameterValue = PPV.gid 							--Кількість ОС

INNER JOIN
	(SELECT
		ProgramGID = Payments.ProgramGID,
		PlanedValue = SUM(Payments.PlanedValue),
		RealValue = SUM(Payments.RealValue)

	FROM
		(SELECT
			[ProgramGID] = PPay.ProgramGID,
			[PlanedValue] = PPay.Value,
			[RealValue] = (SELECT SUM(PTR.Value) FROM PlanedToRealPayments AS PTR WHERE PTR.PlanedPaymentGID=PPay.gid AND PTR.Deleted = 0)

		FROM
			PlanedPayments AS PPay

		INNER JOIN
			PaymentPeriods AS PPer
				ON PPer.gid=PPay.PaymentPeriodGID
					AND PPer.Deleted=0
	
		) AS Payments
	
	GROUP BY
		Payments.ProgramGID
	
	) AS Pay
		ON Pay.ProgramGID = Pg.gid

where
    P.BeginingDate between @BegDate and @EndDate
    and P.Deleted = 0
    and P.SupplementaryAgreementTypeGID is NULL
order by P.PolisNumber    