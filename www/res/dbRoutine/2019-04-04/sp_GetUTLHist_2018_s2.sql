CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetUTLHist_2018_s2`(
in inTeamKey varchar(50), in inGrpKey varchar(50)
)
BEGIN

select * from ascFanta_UTRoster_DailyLog_NBA_2018_s2
where ascFanta_GroupKey = inGrpKey and ascFanta_TeamID = inTeamKey and ascFanta_rStatus = 'UTACPCfm'
order by ascFanta_LogDate desc;


END