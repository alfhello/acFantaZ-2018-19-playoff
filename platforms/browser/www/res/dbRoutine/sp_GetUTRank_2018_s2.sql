CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetUTRank_2018_s2`(in inTeamKey varchar(50), in inGrpKey varchar(50), in_GmDate varchar(20))
BEGIN

if (inGrpKey = null) or (inGrpKey = '') then 

select a.ascFanta_TeamName, a.ascFanta_TeamID, a.ascFanta_Group, a.ascFanta_GroupKey, a.ascFanta_TACP, a.ascFanta_TeamValue, a.ascFanta_gmDate, 
a.ascFanta_lastRank, a.ascFanta_nowRank -- , a.ascFanta_lastUTRank, a.ascFanta_nowUTRank
from ascFanta_UTRoster_DailyRank_NBA_2018_s2 a
inner join ascFanta_UTRoster_DailyLog_NBA_2018_s2 b on a.ascFanta_GroupKey = b.ascFanta_GroupKey and a.ascFanta_TeamID = b.ascFanta_TeamID 
and a.ascFanta_gmDate = b.ascFanta_LogDate and b.ascFanta_rStatus = 'UTACPCfm'
where a.ascFanta_gmDate = in_GmDate
order by a.ascFanta_nowRank asc ;

else

select a.ascFanta_TeamName, a.ascFanta_TeamID, a.ascFanta_Group, a.ascFanta_GroupKey, a.ascFanta_TACP, a.ascFanta_TeamValue, a.ascFanta_gmDate, 
-- a.ascFanta_lastRank, a.ascFanta_nowRank, 
a.ascFanta_lastUTRank, a.ascFanta_nowUTRank
from ascFanta_UTRoster_DailyRank_NBA_2018_s2 a
inner join ascFanta_UTRoster_DailyLog_NBA_2018_s2 b on a.ascFanta_GroupKey = b.ascFanta_GroupKey and a.ascFanta_TeamID = b.ascFanta_TeamID 
and a.ascFanta_gmDate = b.ascFanta_LogDate and b.ascFanta_rStatus = 'UTACPCfm' and a.ascFanta_GroupKey = inGrpKey
where a.ascFanta_gmDate = in_GmDate
order by a.ascFanta_nowRank asc ;

end if;

select ascFanta_Group, ascFanta_nowRank, ascFanta_nowUTRank from ascFanta_UTRoster_DailyRank_NBA_2018_s2
where ascFanta_rStatus = 'RnkCfm' and ascFanta_TeamID = inTeamKey ;

END