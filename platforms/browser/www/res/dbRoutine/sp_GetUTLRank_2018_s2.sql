CREATE DEFINER=`ascdphk1_admin`@`59.148.244.46` PROCEDURE `sp_GetUTLRank_2018_s2`(in inGrpKey varchar(50))
BEGIN

if inGrpKey = null then 

select ascFanta_TeamName, ascFanta_TeamID, ascFanta_Group, ascFanta_GroupKey, ascFanta_TACP, ascFanta_TeamValue, ascFanta_gmDate, ascFanta_lastRank, ascFanta_nowRank 
from ascFanta_UTRoster_DailyRank_NBA_2018_s2
where ascFanta_rStatus = 'RnkCfm'
order by ascFanta_nowRank asc ;


else

select ascFanta_TeamName, ascFanta_TeamID, ascFanta_Group, ascFanta_GroupKey, ascFanta_TACP, ascFanta_TeamValue, ascFanta_gmDate, ascFanta_lastRank, ascFanta_nowRank 
from ascFanta_UTRoster_DailyRank_NBA_2018_s2
where ascFanta_GroupKey = inGrpKey and ascFanta_rStatus = 'RnkCfm'
order by ascFanta_nowRank asc ;

end if;


END