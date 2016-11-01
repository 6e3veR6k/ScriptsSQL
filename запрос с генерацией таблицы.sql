select convert(datetime, datediff(d, 31, getdate()), 104) , getdate()

SELECT DATEDIFF(millisecond, GETDATE(), SYSDATETIME());  

declare @sp datetime = '09-01-2016';
declare @ep datetime = '09-09-2016';

CREATE TABLE #dt(
	d date NOT NULL,
	bg nvarchar(4) NOT NULL,
	BranchName nvarchar(200) NOT NULL
	PRIMARY KEY CLUSTERED(d, bg)
);

WITH Dates(SD)
AS(
SELECT CONVERT(date, @sp) AS SD
UNION ALL
SELECT DATEADD(D, 1, D.SD)
FROM Dates AS D
WHERE D.SD<@ep
)
INSERT INTO #dt(bg, d, BranchName)
SELECT B.BranchCode, D.SD, B.Name
FROM OrantaSch.dbo.Branches AS B, Dates AS D
WHERE 
LEN(B.BranchCode)=4
	AND B.BranchCode IS NOT NULL
select * from #dt
DROP TABLE #dt
/*
SELECT T.d AS [День], T.BranchName AS [Відділення], COUNT(P.EntityGID) AS [Кількість]
FROM #dt AS T
	LEFT JOIN(
		SELECT CONVERT(date, P.CreateDate) AS ADate, LEFT(B.BranchCode, 4) AS BranchCode, P.gid AS EntityGID
		FROM Products AS P
			INNER JOIN Branches AS B ON B.gid=P.BranchGID
		WHERE P.CreateDate BETWEEN @sp AND @ep
	) AS P ON P.ADate=T.d
		AND P.BranchCode=T.bg COLLATE Cyrillic_General_CI_AS
GROUP BY T.d, T.BranchName
ORDER BY T.d, T.BranchName
DROP TABLE #dt
*/