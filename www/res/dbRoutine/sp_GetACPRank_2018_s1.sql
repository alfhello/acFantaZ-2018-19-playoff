CREATE DEFINER=`ascdphk1_admin`@`59.148.244.46` PROCEDURE `sp_GetACPRank_2018_s1`(in ordBy varchar(50), in ordMethod varchar(10))
BEGIN

set @SQL = concat('select a.ascFanta_pID, m.ascFanta_gFullName, m.ascFanta_pTeam, m.ascFanta_gPos,  v.ascFanta_pValue_Final, a.ascFanta_TACP, a.ascFanta_Acm_gmPlayed, a.ascFanta_AACP, round(a.ascFanta_Acm_tdb/10) as TD 
from ascFanta_DailyACPRank_NBA_2018_s1 a
inner join ascFanta_PlayerMaster_NBA_2018_s1 m on a.ascFanta_pID = m.ascFanta_pId
inner join ascFanta_DailyValueRank_NBA_2018_s1 v on a.ascFanta_pID = v.ascFanta_pID
where a.ascFanta_rStatus = "AcmCfm" and m.ascFanta_rStatus = "LIVE" order by ascFanta_',ordBy,' ',ordMethod,';');

/*
select a.ascFanta_pID, m.ascFanta_gFullName, m.ascFanta_pTeam, m.ascFanta_gPos,  v.ascFanta_pValue_Final, a.ascFanta_TACP, a.ascFanta_Acm_gmPlayed, a.ascFanta_AACP, round(a.ascFanta_Acm_tdb/10) as TD 
from ascFanta_DailyACPRank_NBA_2018_s1 a
inner join ascFanta_PlayerMaster_NBA_2018_s1 m on a.ascFanta_pID = m.ascFanta_pId
inner join ascFanta_DailyValueRank_NBA_2018_s1 v on a.ascFanta_pID = v.ascFanta_pID
where a.ascFanta_rStatus = 'AcmCfm' and m.ascFanta_rStatus = 'LIVE'
order by ascFanta_#ordBy# #ordMethod#;
*/

prepare stmt from @SQL;
execute stmt;
deallocate prepare stmt;

END