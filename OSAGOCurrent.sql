--Select @@version
declare @SD datetime = convert(datetime, datediff(d, 3, GETDATE()), 104);
declare @ED datetime = GETDATE();
declare @Br nvarchar(2) = '08';

SELECT DISTINCT
	CAST(PolisData.PolisNumber AS nvarchar(150)) AS PolisNumber,
	CAST(PolisData.BranchCode AS nchar(10)) AS BranchCode,
	CAST(PolisData.sagr AS nvarchar(2)) AS sagr,
--	CAST(PolisData.nagr AS int) AS nagr,
	PolisData.nagr AS nagr,
	PolisData.compl,
	PolisData.d_beg,
	PolisData.d_end,
	PolisData.c_term,
	PolisData.d_distr,
	PolisData.is_active1,
	PolisData.is_active2,
	PolisData.is_active3,
	PolisData.is_active4,
	PolisData.is_active5,
	PolisData.is_active6,
	PolisData.is_active7,
	PolisData.is_active8,
	PolisData.is_active9,
	PolisData.is_active10,
	PolisData.is_active11,
	PolisData.is_active12,
	PolisData.c_privileg,
	CONVERT(int, ISNULL(PolisData.c_discount, 0))/5 AS c_discount,
	CAST(PolisData.zone AS nvarchar(10)) AS zone,
	CASE PolisData.b_m
		WHEN 99 THEN CONVERT(int, 14)
		ELSE PolisData.b_m
	END AS b_m,
	PolisData.K1,
	PolisData.K2,
	PolisData.K3,
	PolisData.K4,
	PolisData.K5,
	PolisData.K6,
	PolisData.K7,
	PolisData.limit_life,
	PolisData.limit_prop,
	PolisData.franchise,
	CAST(PolisData.t_agr AS nchar(10)) AS t_agr,
	PolisData.payment,
	PolisData.paym_bal,
	CONVERT(nvarchar(4), PolisData.BranchCode) AS note,
	PolisData.d_abort,
	PolisData.retpayment,
	CAST(PolisData.chng_sagr AS nvarchar(2)) AS chng_sagr,
	CAST(PolisData.chng_nagr AS int) AS chng_nagr,
	CASE PolisData.resident
		WHEN 1 THEN CONVERT(nvarchar(5), 'TRUE')
		ELSE 'False'
	END AS resident,
	CASE PolisData.status_prs
		WHEN 1 THEN 'Ф'
		ELSE 'Ю'
	END AS status_prs,
	CAST(PolisData.numb_ins AS nchar(12)) AS numb_ins,
	PolisData.f_name,
	PolisData.s_name,
	PolisData.p_name,
	PolisData.birth_date,
	CAST(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(PolisData.phone, '-', ''), ')', ''), '(', ''), ' ', ''), '+', '') AS nvarchar(30)) AS phone,
	'' AS doc_name,
	LEFT(PolisData.InsPassNumber, 2) AS doc_series,
	SUBSTRING(PolisData.InsPassNumber, 4, 10) AS doc_no,
	CASE PolisData.person_s
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s,
	PolisData.c_city,
	PolisData.city_name,
	PolisData.ser_ins AS ser_ins,
	PolisData.num_ins,
	PolisData.exprn_ins,
	PolisData.drv_cnt,
	CASE PolisData.person_s1
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s1,
	PolisData.f_name1,
	PolisData.s_name1,
	PolisData.p_name1,
	PolisData.ins1,
	PolisData.exprn_ins1,
	CASE PolisData.person_s2
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s2,
	PolisData.f_name2,
	PolisData.s_name2,
	PolisData.p_name2,
	PolisData.ins2,
	PolisData.exprn_ins2,
	CASE PolisData.person_s3
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s3,
	PolisData.f_name3,
	PolisData.s_name3,
	PolisData.p_name3,
	PolisData.ins3,
	PolisData.exprn_ins3,
	CASE PolisData.person_s4
		WHEN 0 THEN 'Ж'
		WHEN 1 THEN 'М'
	END AS person_s4,
	PolisData.f_name4,
	PolisData.s_name4,
	PolisData.p_name4,
	PolisData.ins4,
	PolisData.exprn_ins4,
	PolisData.c_mark+' '+PolisData.model_txt,
	PolisData.reg_no,
	PolisData.vin,
	CASE PolisData.c_type
		WHEN 'B1' THEN 1
		WHEN 'B2' THEN 2
		WHEN 'B3' THEN 3
		WHEN 'B4' THEN 4
		WHEN 'A1' THEN 5
		WHEN 'A2' THEN 6
		WHEN 'C1' THEN 7
		WHEN 'C2' THEN 8
		WHEN 'D1' THEN 9
		WHEN 'D2' THEN 10
		WHEN 'F' THEN 11
		WHEN 'E' THEN 12
		WHEN 'B' THEN 13
		WHEN 'A' THEN 14
		WHEN 'C' THEN 15
		WHEN 'D' THEN 16
	END AS c_type,
	PolisData.c_mark,
	PolisData.mark_txt,
	PolisData.model_txt,
	PolisData.prod_year,
	CASE PolisData.sphere_use
		WHEN 'Таксі' THEN 2
		ELSE 1
	END AS sphere_use,
	CASE PolisData.need_to
		WHEN 'Так' THEN CONVERT(nvarchar(5), 'TRUE')
		ELSE 'False'
	END AS need_to,
	PolisData.date_next_to,
	PolisData.c_exp,
	PolisData.ErrorFlag
FROM(
	SELECT PolisData.PolisNumber,
		PolisData.BranchCode,
		LEFT(PolisData.PolisNumber, 2) AS sagr,
	--	SUBSTRING(PolisData.PolisNumber, 4, 7) AS nagr,
		PolisData.PolisNumber AS nagr,
		PolisData.compl,
		PolisData.d_beg,
		PolisData.d_end,
		CASE d_end
			WHEN DATEADD(D, -1, DATEADD(YY, 1, d_beg)) THEN 13
			WHEN DATEADD(D, -1, DATEADD(MM, 11, d_beg)) THEN 12
			WHEN DATEADD(D, -1, DATEADD(MM, 10, d_beg)) THEN 11
			WHEN DATEADD(D, -1, DATEADD(MM, 9, d_beg)) THEN 10
			WHEN DATEADD(D, -1, DATEADD(MM, 8, d_beg)) THEN 9
			WHEN DATEADD(D, -1, DATEADD(MM, 7, d_beg)) THEN 8
			WHEN DATEADD(D, -1, DATEADD(MM, 6, d_beg)) THEN 7
			WHEN DATEADD(D, -1, DATEADD(MM, 5, d_beg)) THEN 6
			WHEN DATEADD(D, -1, DATEADD(MM, 4, d_beg)) THEN 5
			WHEN DATEADD(D, -1, DATEADD(MM, 3, d_beg)) THEN 4
			WHEN DATEADD(D, -1, DATEADD(MM, 2, d_beg)) THEN 3
			WHEN DATEADD(D, -1, DATEADD(MM, 1, d_beg)) THEN 2
			WHEN DATEADD(D, 14, d_beg) THEN 1
			ELSE 0
		END AS c_term,
		PolisData.d_distr,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active1, 'FALSE')
		END AS is_active1,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active2, 'FALSE')
		END AS is_active2,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active3, 'FALSE')
		END AS is_active3,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active4, 'FALSE')
		END AS is_active4,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active5, 'FALSE')
		END AS is_active5,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active6, 'FALSE')
		END AS is_active6,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active7, 'FALSE')
		END AS is_active7,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active8, 'FALSE')
		END AS is_active8,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active9, 'FALSE')
		END AS is_active9,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active10, 'FALSE')
		END AS is_active10,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active11, 'FALSE')
		END AS is_active11,
		CASE PolisData.K5
			WHEN 1 THEN NULL
			ELSE ISNULL(PolisData.is_active12, 'FALSE')
		END AS is_active12,
		PolisData.c_privileg,
		PolisData.c_discount,
		PolisData.zone,
		PolisData.b_m,
		PolisData.K1,
		PolisData.K2,
		PolisData.K3,
		PolisData.K4,
		PolisData.K5,
		PolisData.K6,
		PolisData.K7,
		PolisData.limit_life,
		PolisData.limit_prop,
		PolisData.franchise,
		PolisData.t_agr,
		PolisData.payment,
		PolisData.paym_bal,
		PolisData.d_abort,
		PolisData.retpayment,
		LEFT(PolisData.PrevPolisNumber, 2) AS chng_sagr,
		SUBSTRING(PolisData.PrevPolisNumber, 4, 7) AS chng_nagr,
		PolisData.resident,
		PolisData.status_prs,
		PolisData.numb_ins,
		PolisData.f_name,
		PolisData.s_name,
		PolisData.p_name,
		PolisData.birth_date,
		PolisData.phone,
		'' AS doc_name,
		PolisData.InsPassNumber,
		PolisData.person_s,
		PolisData.c_city,
		PolisData.city_name,
		PolisData.ser_ins,
		PolisData.num_ins,
		PolisData.exprn_ins,
		PolisData.drv_cnt,
		PolisData.person_s1,
		PolisData.f_name1,
		PolisData.s_name1,
		PolisData.p_name1,
		PolisData.ins1,
		PolisData.exprn_ins1,
		PolisData.person_s2,
		PolisData.f_name2,
		PolisData.s_name2,
		PolisData.p_name2,
		PolisData.ins2,
		PolisData.exprn_ins2,
		PolisData.person_s3,
		PolisData.f_name3,
		PolisData.s_name3,
		PolisData.p_name3,
		PolisData.ins3,
		PolisData.exprn_ins3,
		PolisData.person_s4,
		PolisData.f_name4,
		PolisData.s_name4,
		PolisData.p_name4,
		PolisData.ins4,
		PolisData.exprn_ins4,
		PolisData.[auto],
		PolisData.reg_no,
		PolisData.vin,
		PolisData.c_type,
		PolisData.c_mark,
		PolisData.mark_txt,
		PolisData.model_txt,
		PolisData.prod_year,
		PolisData.sphere_use,
		PolisData.need_to,
		PolisData.date_next_to,
		PolisData.c_exp,
		COUNT(PolisData.gid) OVER (PARTITION BY PolisData.[PolisNumber]) AS ErrorFlag,
		PolisData.gid
    FROM
	   (SELECT 
		  P.PolisNumber, 
		  P.gid,
		  B.BranchCode,
		  CASE
			 WHEN BP.gid IS NULL THEN 1
			 ELSE
				    CASE ISNULL(BP.Value, -1)
					   WHEN -1 THEN -1
					   WHEN 0 THEN 3 --Дубликат
					   ELSE 4 --Переоформление
				    END
		  END AS compl,
		  CONVERT(date, P.BeginingDate) AS d_beg,
		  CONVERT(date, DATEADD(MI, -1, P.EndingDate)) AS d_end,
		  CONVERT(date, P.RegisteredDate) AS d_distr,
		  ProgramData.IsActive1 AS is_active1,
		  ProgramData.IsActive2 AS is_active2,
		  ProgramData.IsActive3 AS is_active3,
		  ProgramData.IsActive4 AS is_active4,
		  ProgramData.IsActive5 AS is_active5,
		  ProgramData.IsActive6 AS is_active6,
		  ProgramData.IsActive7 AS is_active7,
		  ProgramData.IsActive8 AS is_active8,
		  ProgramData.IsActive9 AS is_active9,
		  ProgramData.IsActive10 AS is_active10,
		  ProgramData.IsActive11 AS is_active11,
		  ProgramData.IsActive12 AS is_active12,
		  ProgramData.c_privileg,
		  ProgramData.c_discount,
		  CASE ProgramData.zone
			 WHEN '1' THEN '1'
			 WHEN '2' THEN '6'
			 WHEN '3' THEN '2'
			 WHEN '4' THEN '3'
			 WHEN '5' THEN '4'
			 WHEN '6' THEN '5'
			 WHEN '7' THEN '7'
			 ELSE ''
		  END AS zone,
		  ISNULL(ProgramData.b_m, 3) AS b_m,
		  ProgramData.K1,
		  ProgramData.K2,
		  ProgramData.K3,
		  ProgramData.K4,
		  ProgramData.K5,
		  ProgramData.K6,
		  ProgramData.K7,
		  CoverFranchise.HealthCover AS limit_life,
		  CoverFranchise.EstateCover AS limit_prop,
		  CoverFranchise.Franchise AS franchise,
		  ProgramData.t_agr,
		  PPay.PValue AS payment,
		  PPay.RValue AS paym_bal,
		  CONVERT(date, NULL) AS d_abort,
		  CONVERT(decimal(18, 2), NULL) AS retpayment,
		  CONVERT(nvarchar(100), BP.PolisNumber) AS PrevPolisNumber,
		  CASE O.CountryGID
			 WHEN '0F52ADF4-F544-42D6-BEA6-AD656AB683DF' THEN CONVERT(bit, 1)
			 ELSE CONVERT(bit, 0)
		  END AS resident,
		  CASE F.PersonTypeID
			 WHEN 2 THEN 2
			 ELSE 1
		  END AS status_prs,
		  CASE ISNULL(JPer.EDRPOU, '')
			 WHEN '' THEN F.IdentificationCode
			 ELSE JPer.EDRPOU
		  END AS numb_ins,
		  CASE F.PersonTypeID
			 WHEN 2 THEN JPer.FullName
			 ELSE Pers.Lastname
		  END AS f_name,
		  ISNULL(Pers.Firstname, '') AS s_name,
		  ISNULL(Pers.Secondname, '') AS p_name,
		  Pers.Birthdate AS birth_date,
		  F.PhoneNumber AS phone,
		  '' AS doc_name,
		  DPers.InsPass AS InsPassNumber,
		  Pers.IsMan AS person_s,
		  CASE ProgramData.zone
			 WHEN '7' THEN 3345
			 ELSE ISNULL(S.MTSBUID, 0)
		  END AS c_city,
		  CASE ISNULL(S.MTSBUID, 0)
			 WHEN 0 THEN S.FullName
			 ELSE NULL
		  END AS city_name,
		  LEFT(DPers.DLic, 3) AS ser_ins,
		  SUBSTRING(REPLACE(DPers.DLic, '-',''), 4, 10) AS num_ins,
		  Pers.DriverFrom AS exprn_ins,
		  CONVERT(int, NULL) AS drv_cnt,
		  CONVERT(int, NULL) AS person_s1,
		  CONVERT(nvarchar(100), '') AS f_name1,
		  CONVERT(nvarchar(100), '') AS s_name1,
		  CONVERT(nvarchar(100), '') AS p_name1,
		  CONVERT(nvarchar(100), NULL) AS ins1,
		  CONVERT(int, NULL) AS exprn_ins1,
		  CONVERT(int, NULL) AS person_s2,
		  CONVERT(nvarchar(100), '') AS f_name2,
		  CONVERT(nvarchar(100), '') AS s_name2,
		  CONVERT(nvarchar(100), '') AS p_name2,
		  CONVERT(nvarchar(100), '') AS ins2,
		  CONVERT(int, NULL) AS exprn_ins2,
		  CONVERT(int, NULL) AS person_s3,
		  CONVERT(nvarchar(100), '') AS f_name3,
		  CONVERT(nvarchar(100), '') AS s_name3,
		  CONVERT(nvarchar(100), '') AS p_name3,
		  CONVERT(nvarchar(100), '') AS ins3,
		  CONVERT(int, NULL) AS exprn_ins3,
		  CONVERT(int, NULL) AS person_s4,
		  CONVERT(nvarchar(100), '') AS f_name4,
		  CONVERT(nvarchar(100), '') AS s_name4,
		  CONVERT(nvarchar(100), '') AS p_name4,
		  CONVERT(nvarchar(100), NULL) AS ins4,
		  CONVERT(int, NULL) AS exprn_ins4,
		  V.TechDocModel AS [auto],
		  V.RegistrationNumber AS reg_no,
		  V.BodyNumber AS vin,
		  RTRIM(LEFT(OT.Name, 2)) AS c_type,
		  VMan.Name AS c_mark,
		  VMan.Name AS mark_txt,
		  VMod.Name AS model_txt,
		  V.ProducedDate AS prod_year,
		  ProgramData.sphere_use,
		  ProgramData.need_to,
		  ProgramData.date_next_to,
		  CASE F.PersonTypeID
			 WHEN 2 THEN CONVERT(int, NULL)
			 ELSE ProgramData.c_exp
		  END AS c_exp
	   FROM 
		  Products AS P
	   INNER JOIN 
		  Branches AS B 
			 ON B.gid=P.BranchGID
				AND B.BranchCode IS NOT NULL
--				AND LEFT(B.BranchCode, 2) = @Br
	   INNER JOIN
			 (SELECT 
				Pg.gid AS ProgramGID, 
				Pg.ProductGID,
				MAX(CASE PC.CoeficientNumber
				    WHEN 1 THEN CONVERT(decimal(18, 2), C.Value)
				    ELSE CONVERT(decimal(18, 2), 0)
				END) AS K1,
				MAX(CASE PC.CoeficientNumber
				    WHEN 2 THEN CONVERT(decimal(18, 2), C.Value)
				    ELSE CONVERT(decimal(18, 2), 0)
				END) AS K2,
				MAX(CASE PC.CoeficientNumber
				    WHEN 3 THEN CONVERT(decimal(18, 2), C.Value)
				    ELSE CONVERT(decimal(18, 2), 0)
				END) AS K3,
				MAX(CASE PC.CoeficientNumber
				    WHEN 4 THEN CONVERT(decimal(18, 2), C.Value)
				    ELSE CONVERT(decimal(18, 2), 0)
				END) AS K4,
				MAX(CASE PC.CoeficientNumber
				    WHEN 5 THEN CONVERT(decimal(18, 2), C.Value)
				    ELSE CONVERT(decimal(18, 2), 0)
				END) AS K5,
				MAX(CASE PC.CoeficientNumber
				    WHEN 6 THEN CONVERT(decimal(18, 2), C.Value)
				    ELSE CONVERT(decimal(18, 2), 0)
				END) AS K6,
				MAX(CASE PC.CoeficientNumber
				    WHEN 7 THEN CONVERT(decimal(18, 2), C.Value)
				    ELSE CONVERT(decimal(18, 2), 0)
				END) AS K7,
				MAX(CASE PTPV.ParameterGID
				    WHEN 'D3CC1D06-C28E-47D3-8180-61921FFCBE84' THEN CONVERT(int, PPV.Value)
				END) AS b_m,
				MAX(CASE PTPV.ParameterGID
				    WHEN 'AF37DC18-E364-4A84-87B1-2554FE4ACC69' THEN CAST(PPV.Value AS nvarchar(1))
				    ELSE ''
				END) AS zone,
				MAX(CASE PTPV.ParameterGID
				    WHEN '3DEB4004-BAF2-459F-9C8C-48187B6DF028' THEN CONVERT(int, PPV.Value)
				    ELSE 0
				END) AS c_discount,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN CAST('1A575700-80D1-411E-8AB2-A5A25BA6602F' AS uniqueidentifier) THEN 1
					   WHEN CAST('25F03D33-C4F3-4907-A371-2B16EB5DD46F' AS uniqueidentifier) THEN 2
					   WHEN CAST('11C7DF7C-B1C1-466E-8718-F45A97E57794' AS uniqueidentifier) THEN 3
					   WHEN CAST('F2A242B5-5B5F-4963-836F-90D912E6473C' AS uniqueidentifier) THEN 4
					   WHEN CAST('8E2D7383-3415-40EE-BD66-EE9BCAF5CBA7' AS uniqueidentifier) THEN 4
					   ELSE 0
				END) AS c_privileg,
				MAX(CASE PTPV.ParameterGID
				    WHEN '42E4AB3E-536B-42E2-8EFB-495BE93A1E23' THEN CAST(PPV.Value AS nvarchar(1))
				    ELSE ''
				END) AS t_agr,
				MAX(CASE PTPV.ParameterGID
				    WHEN 'B9AAB147-0891-486D-B7AA-BCF1658844E4' THEN CAST(PPV.Value AS nvarchar(5))
				    ELSE ''
				END) AS sphere_use,
				MAX(CASE PTPV.ParameterGID
				    WHEN '8855ECEF-0EA1-4B8A-9EC8-B03800437A73' THEN CAST(PPV.Value AS nvarchar(5))
				    ELSE ''
				END) AS need_to,
				MAX(CASE PTPV.ParameterGID
				    WHEN 'D42F6AA7-09B6-4B64-A43D-3C241B41C202' THEN PTPV.ParameterValue
				    ELSE CAST(NULL AS date)
				END) AS date_next_to,
				MAX(CASE PTPV.ParameterGID
				    WHEN 'E681EBF3-B5A1-436E-852F-AB1C288B8A0B' THEN PTPV.ParameterValue
				    WHEN '0C65CBBB-5895-48B9-9A28-B820853A71C7' THEN
					   CASE PTPV.ParameterValue
						  WHEN CAST('AA32FEFC-1929-401F-8E7D-BF0F87EDC565' AS uniqueidentifier) THEN 2
						  WHEN CAST('70827752-6A95-471F-8D02-91EB13D1BDB2' AS uniqueidentifier) THEN 2
						  WHEN CAST('B1871293-7295-469D-B3DE-56B17A55EAF9' AS uniqueidentifier) THEN 2
						  WHEN CAST('68DF34EA-A79E-47AF-AC61-CB21648C9332' AS uniqueidentifier) THEN 1
						  WHEN CAST('74FAB0F9-A5A0-4664-9BF0-690D605C8A13' AS uniqueidentifier) THEN 1
						  WHEN CAST('B228E36F-020F-4849-9A75-3EA023248F89' AS uniqueidentifier) THEN 1
						  ELSE NULL
					   END
				    ELSE NULL
				END) AS c_exp,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN 'FEBDCAFC-B091-4C5D-B57C-23C22CCC2668' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive1,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN 'B4BD362B-F84D-4E04-8C78-733863B0D6B0' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive2,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN 'CC22D3AF-1AFB-401C-B7F0-5644993AA7E8' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive3,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN 'A3EFA11B-718F-4EB9-A4CE-5BF92275FA48' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive4,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN 'F3DD57F8-E9D6-4566-9F0A-F5E4532D09D9' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive5,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN '967B27B1-6653-45E6-96F0-2DDC60E7453D' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive6,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN '7A8FA023-7737-40F9-8CF9-069800879586' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive7,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN '85247AEF-CEA1-4C18-8FE0-FBB1A46113C0' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive8,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN '0C1E84EA-0785-4AF5-84E1-951D6B85D7E0' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive9,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN '33EC3C81-A617-4F7B-9757-FD6AE747C5DF' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive10,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN 'AFA2F77C-0057-4754-9BC3-969FF90C1450' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive11,
				MAX(CASE PTPV.ParameterValueGUIDKey
					   WHEN 'AB2D5B7D-3E76-4E9A-B51B-0AA4A5C875DD' THEN CONVERT(nvarchar(5), 'TRUE')
				END) AS IsActive12
	   
			 FROM
				Programs AS Pg

			 INNER JOIN
				Coefficients AS C 
				    ON C.ProgramGID=Pg.gid
					   AND C.Deleted=0

			 INNER JOIN
				meta.ProgramCoefficients AS PC 
				ON PC.gid=C.ProgramCoefficientGID

			 INNER JOIN 
				ProgramToParameterValues AS PTPV 
				    ON PTPV.ProgramGID=Pg.gid
					   AND PTPV.Deleted=0

			 LEFT JOIN 
				meta.ProgramParameterValues AS PPV 
				    ON PPV.gid=PTPV.ParameterValueGUIDKey
					   AND PPV.ProgramParameterGID=PTPV.ParameterGID

			 WHERE 
				Pg.Deleted=0 
				AND Pg.ProgramTypeGID IN   
							 (select PT.gid 
							 from meta.ProgramTypes as PT 
							 where PT.InsuranceTypeGID in 
								    ('FF7CBC5D-D3E6-4A5D-BF7A-1415FCD61A5B', 
								    '4EFB1FF8-995B-47F0-844F-930648933896',
								    '346F1793-3D48-49D1-AB00-9637A5208CFD')
							 )
					   

			 GROUP BY
				Pg.gid,
				Pg.ProductGID
		  ) AS ProgramData 
			 ON ProgramData.ProductGID=P.gid

	   --Автомобиль
	   INNER JOIN 
		  InsuranceObjects AS IOb
			 ON IOb.ProgramGID=ProgramData.ProgramGID
				AND IOb.Deleted=0
				AND IOb.InsuranceObjectTypeGID='20D876F3-F4F0-4A00-BF7B-9B3730496D15'
	   INNER JOIN 
		  meta.ObjectTypes AS OT 
			 ON OT.gid=IOb.ObjectTypeGID

	   LEFT JOIN( hq01sdb3.Metis.dbo.Vehicles AS V
		  LEFT JOIN hq01db05.DWH.Metis.Settlements AS S ON S.gid=V.SettlementGID
		  INNER JOIN hq01db05.Metis.meta.VehicleManufacturers AS VMan ON VMan.gid=V.ManufacturerGID
		  INNER JOIN hq01db05.Metis.meta.VehicleModels AS VMod ON VMod.gid=V.ModelGID
	   ) ON V.gid=IOb.ObjectGID

	   --Разбираем платежи
	   INNER JOIN
			 (SELECT 
				PPay.ProgramGID, 
				SUM(PPay.Value) AS PValue, 
				SUM(ISNULL(PTR.Value, 0)) AS RValue
			 FROM
				PlanedPayments AS PPay
			 LEFT JOIN
				    (SELECT PTR.PlanedPaymentGID, SUM(PTR.Value) AS Value
				    FROM PlanedToRealPayments AS PTR
				    WHERE PTR.Deleted=0
				    AND PTR.RealPaymentGID IN(
										  SELECT M.ToGID
										  FROM Ganimed.dbo.BankPayments AS BP
										  INNER JOIN Ganimed.dbo.Moneys AS M ON M.FromGID=BP.gid AND M.Deleted=0 
										  WHERE BP.Deleted=0
										  )
				    GROUP BY PTR.PlanedPaymentGID
				    ) AS PTR 
					   ON PTR.PlanedPaymentGID=PPay.gid
			 WHERE PPay.Deleted=0
			 GROUP BY PPay.ProgramGID
			 ) AS PPay 
				ON PPay.ProgramGID=ProgramData.ProgramGID

	   --Покрытие
	   INNER JOIN
			 ( SELECT 
				C.InsuredObjectGID,
				MAX(CASE C.RiskGID
				    WHEN 'CAEBC7AB-9DD5-45E6-9ADC-A0FF3BDE6B0E' THEN C.CoverLimit
				    ELSE 0 END) AS EstateCover,
				MAX(CASE C.RiskGID
				    WHEN 'C1133FB1-BCE1-4AEC-B544-E00870602AFF' THEN C.CoverLimit
				    ELSE 0 END) AS HealthCover,
				MAX(CONVERT(int, ISNULL(CONVERT(nvarchar(40), FTV.Value), ISNULL(CONVERT(nvarchar(40), F.FranchiseValue), '0')))) AS Franchise
	   
			 FROM
				Covers AS C
	   
			 LEFT JOIN
				Franchises AS F 
				    ON F.CoverGID=C.gid
					   AND F.Deleted=0
					   AND F.FranchiseTypeGID='0A661876-8224-4278-9FA0-88C5275AB420'

			 LEFT JOIN 
				meta.FranchiseTypeValues AS FTV 
				    ON FTV.FranchiseTypeGID=F.FranchiseTypeGID
					   AND CONVERT(nvarchar(40), FTV.gid)=CONVERT(nvarchar(40), F.FranchiseValue)

			 WHERE 
				C.Deleted=0
			 GROUP BY 
				C.InsuredObjectGID

			 ) AS CoverFranchise 
				ON CoverFranchise.InsuredObjectGID=IOb.gid

	   INNER JOIN 
		  Signers AS Ins
			 ON Ins.gid=P.InsurerGID
				AND Ins.Deleted=0
	   INNER JOIN  
		  hq01sdb3.Metis.dbo.Objects AS O 
			 ON O.gid=Ins.FaceGID

	   INNER JOIN
		  hq01sdb3.Metis.dbo.Faces AS F
			 ON F.gid=O.gid

	   LEFT JOIN 
		  hq01sdb3.Metis.dbo.Persons AS Pers 
			 ON Pers.gid=F.gid

	   LEFT JOIN	  
		  hq01sdb3.Metis.dbo.JuridicalPersons AS JPer
			 ON JPer.gid=F.gid

	   LEFT JOIN
			 (SELECT 
				D.ObjectGID,
				MAX(CASE D.DocumentTypeGID
					   WHEN '357BED28-00FC-479A-B3AB-A8FC8B2DE094' THEN D.Number
				    ELSE '' END) AS InsPass,
				MAX(CASE D.DocumentTypeGID
					   WHEN '7ACAE121-776B-467C-8FDC-C47F09C184EE' THEN D.Number
				    ELSE '' END) AS DLic

				FROM hq01sdb3.Metis.dbo.Documents AS D
				WHERE 
				    D.Deleted=0
				AND D.DocumentTypeGID IN ('7ACAE121-776B-467C-8FDC-C47F09C184EE',
									   '357BED28-00FC-479A-B3AB-A8FC8B2DE094')
				GROUP BY 
				    D.ObjectGID

			 ) AS DPers 
				ON DPers.ObjectGID=O.gid

	   --Current Status
	   LEFT JOIN
			 (SELECT 
				P.gid, 
				BP.PolisNumber, 
				COUNT(ESAF.ProductGID) AS Value
			 FROM 
				Products AS P
			 LEFT JOIN 
				EditsSupplementaryAgreementFields AS ESAF 
				    ON ESAF.ProductGID=P.gid
				    AND ESAF.SupplementaryAgreementFieldGID NOT IN('F08678F7-039A-42FA-808C-2D13B3D908B1',
														  '34D0D2B9-2204-4527-9519-31C0EEEF0FB2')
			 INNER JOIN 
				Products AS BP 
				    ON BP.gid=P.BaseProductGID
					   AND BP.Deleted=0
			 WHERE 
				P.Deleted=0
				AND P.BaseProductGID IS NOT NULL

			 GROUP BY 
				P.gid, 
				BP.PolisNumber
			 ) AS BP 
				ON BP.gid=P.gid
	   WHERE P.Deleted=0
	   AND ISNULL(P.LastModifiedDate, P.CreateDate) BETWEEN @SD
	   AND DATEADD(s,-1,DATEADD(d,1, @ED))
    ) AS PolisData
) AS PolisData
