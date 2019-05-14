CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetACPRank_2018_s2`(in ordBy varchar(50), in ordMethod varchar(10), out lastGmDate varchar(20))
BEGIN

select date(ascFanta_mdate_est) into lastGmDate from ascFanta_DailyACPRank_NBA_2018_s2
where ascFanta_rStatus = 'AcmCfm' and ascFanta_mDate_est is not null
group by date(ascFanta_mDate_est)
order by date(ascFanta_mdate_est) desc limit 1;

If ordBy = "DACP" then 

set @SQL = concat('select a.ascFanta_personID, m.ascFanta_gFullName, m.ascFanta_pTeam, m.ascFanta_gPos, insert(replace(m.ascFanta_gPos,"B",""),2,0,"/") as "gPosN", v.ascFanta_pValue_Final, a.ascFanta_TACP, a.ascFanta_Bonus
from ascFanta_PlayerStat_NBA_2018_s2 a
inner join ascFanta_PlayerMaster_NBA_2018_s2 m on a.ascFanta_personID = m.ascFanta_pId and m.ascFanta_rStatus = "LIVE"
inner join ascFanta_DailyValueRank_NBA_2018_s2 v on a.ascFanta_personID = v.ascFanta_pID and v.ascFanta_rStatus = "ValCfm" 
and v.ascFanta_mDate = date(a.ascFanta_sMatchDate)
where a.ascFanta_rStatus = "CfmRec" and date(a.ascFanta_sMatchDate) = "',lastGmDate,'" order by ascFanta_TACP desc;');

end if;

if ordBy = "TACP" or ordBy = "AACP" then 

set @SQL = concat('select a.ascFanta_pID, m.ascFanta_gFullName, m.ascFanta_pTeam, m.ascFanta_gPos, insert(replace(m.ascFanta_gPos,"B",""),2,0,"/") as "gPosN", v.ascFanta_pValue_Final, a.ascFanta_TACP, a.ascFanta_Acm_gmPlayed, a.ascFanta_AACP, round(a.ascFanta_Acm_tdb/10) as TD 
from ascFanta_DailyACPRank_NBA_2018_s2 a
inner join ascFanta_PlayerMaster_NBA_2018_s2 m on a.ascFanta_pID = m.ascFanta_pId
inner join ascFanta_DailyValueRank_NBA_2018_s2 v on a.ascFanta_pID = v.ascFanta_pID and v.ascFanta_rStatus = "ValCfm" and v.ascFanta_mDate = "',lastGmDate,'" 
where a.ascFanta_rStatus = "AcmCfm" and m.ascFanta_rStatus = "LIVE" order by ascFanta_',ordBy,' ',ordMethod,';');

end if; 

prepare stmt from @SQL;
execute stmt;
deallocate prepare stmt;

END