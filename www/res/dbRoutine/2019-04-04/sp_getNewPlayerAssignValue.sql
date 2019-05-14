CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_getNewPlayerAssignValue`()
BEGIN

select a.ascFanta_pID, a.ascFanta_gFullName, a.ascFanta_gPos, a.ascFanta_pDOB, a.ascFanta_pProYr, a.ascFanta_pTeam,
b.ascFanta_TACP, b.ascFanta_Acm_gmPlayed, b.ascFanta_AACP
from ascFanta_PlayerMaster_NBA_2018_s2 a
inner join ascFanta_DailyACPRank_NBA_2018_s2 b on a.ascFanta_pID = b.ascFanta_pID and b.ascFanta_rStatus = 'AcmCfm'
where a.ascFanta_rStatus = 'LIVE' and a.ascFanta_pID not in (
select ascFanta_pID from ascFanta_PlayerValue_NBA_2018_s2 
where ascFanta_rStatus = 'ValCfm' and ascFanta_Active = 1
) ;

END