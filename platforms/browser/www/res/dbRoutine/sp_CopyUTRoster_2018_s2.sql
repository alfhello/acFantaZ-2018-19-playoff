CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_CopyUTRoster_2018_s2`(in IN_GmDate varchar(20))
BEGIN

declare CpyRow int;

update ascFanta_UTRoster_DailyLog_NBA_2018_s2 set ascFanta_rStatus = 'OutDated'
where ascFanta_LogDate = date(IN_GmDate);

insert into ascFanta_UTRoster_DailyLog_NBA_2018_s2 
(ascFanta_TeamID, ascFanta_TeamName, ascFanta_Group, ascFanta_GroupKey, ascFanta_TeamValueRemain, ascFanta_TeamValue,
ascFanta_pID_G1, ascFanta_trKey_G1, ascFanta_pVal_G1,
ascFanta_pID_G2, ascFanta_trKey_G2, ascFanta_pVal_G2,
ascFanta_pID_F1, ascFanta_trKey_F1, ascFanta_pVal_F1,
ascFanta_pID_F2, ascFanta_trKey_F2, ascFanta_pVal_F2,
ascFanta_pID_C1, ascFanta_trKey_C1, ascFanta_pVal_C1,
ascFanta_pID_B1, ascFanta_trKey_B1, ascFanta_pVal_B1, 
ascFanta_LogDate, ascFanta_rStatus, ascFanta_Active)
select a.ascFanta_TeamID, a.ascFanta_TeamName, a.ascFanta_Group, a.ascFanta_GroupKey, a.ascFanta_gValueRemain as 'ValRemain',
(pG1.ascFanta_gNowValue+pG2.ascFanta_gNowValue+pF1.ascFanta_gNowValue+pF2.ascFanta_gNowValue+pC1.ascFanta_gNowValue+pB1.ascFanta_gNowValue) as 'UTValue',
a.ascFanta_pID_G1, a.ascFanta_trKey_G1, pG1.ascFanta_gNowValue,
a.ascFanta_pID_G2, a.ascFanta_trKey_G2, pG2.ascFanta_gNowValue,
a.ascFanta_pID_F1, a.ascFanta_trKey_F1, pF1.ascFanta_gNowValue,
a.ascFanta_pID_F2, a.ascFanta_trKey_F2, pF2.ascFanta_gNowValue,
a.ascFanta_pID_C1, a.ascFanta_trKey_C1, pC1.ascFanta_gNowValue,
a.ascFanta_pID_B1, a.ascFanta_trKey_B1, pB1.ascFanta_gNowValue,
date(IN_GmDate),'RCopyCfm',1 
from ascFanta_UTRoster_Master_NBA_2018_s2 a
inner join ascFanta_PlayerValue_NBA_2018_s2 pG1 on pG1.ascFanta_rStatus = 'ValCfm' and pG1.ascFanta_Active = 1 and pG1.ascFanta_pID = a.ascFanta_pID_G1
inner join ascFanta_PlayerValue_NBA_2018_s2 pG2 on pG2.ascFanta_rStatus = 'ValCfm' and pG2.ascFanta_Active = 1 and pG2.ascFanta_pID = a.ascFanta_pID_G2
inner join ascFanta_PlayerValue_NBA_2018_s2 pF1 on pF1.ascFanta_rStatus = 'ValCfm' and pF1.ascFanta_Active = 1 and pF1.ascFanta_pID = a.ascFanta_pID_F1
inner join ascFanta_PlayerValue_NBA_2018_s2 pF2 on pF2.ascFanta_rStatus = 'ValCfm' and pF2.ascFanta_Active = 1 and pF2.ascFanta_pID = a.ascFanta_pID_F2
inner join ascFanta_PlayerValue_NBA_2018_s2 pC1 on pC1.ascFanta_rStatus = 'ValCfm' and pC1.ascFanta_Active = 1 and pC1.ascFanta_pID = a.ascFanta_pID_C1
inner join ascFanta_PlayerValue_NBA_2018_s2 pB1 on pB1.ascFanta_rStatus = 'ValCfm' and pB1.ascFanta_Active = 1 and pB1.ascFanta_pID = a.ascFanta_pID_B1
;
set CpyRow = ROW_COUNT();
select CpyRow;

END