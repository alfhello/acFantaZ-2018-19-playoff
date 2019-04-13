CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetWishListPlayerInfo`(
in inGmDate varchar(20), in WLID varchar(200)
)
BEGIN

declare oGmDate varchar(20);

if (inGmDate = null) or (inGmDate = '') then 
	call sp_GetOpendate_DTS(oGmDate);
else
	set oGmDate = inGmDate;
end if;

/*
SELECT a.ascFanta_newVal_Key, a.ascFanta_gNowValue, a.ascFanta_pID, a.ascFanta_gPos, d.ascFanta_TACP, d.ascFanta_AACP, 
a.ascFanta_newVal_Date, c.ascFanta_pTeam, c.ascFanta_gFullName, b.Nx7D
from ascFanta_PlayerValue_NBA_2018_s2 a
inner join ascFanta_PlayerMaster_NBA_2018_s2 c on a.ascFanta_pID = c.ascFanta_pID and c.ascFanta_rStatus = 'LIVE'
inner join ascFanta_NextSevenDaybyTeam b on a.ascFanta_newVal_Date = b.fmGmDate and c.ascFanta_pTeam = b.Team
inner join ascFanta_DailyACPRank_NBA_2018_s2 d on a.ascFanta_pID = d.ascFanta_pID and d.ascFanta_rStatus = 'AcmCfm'
where a.ascFanta_rStatus = 'ValCfm' and a.ascFanta_newVal_Date = inGmDate and a.ascFanta_pID in WLID ;
*/

set @stmt = CONCAT('SELECT a.ascFanta_newVal_Key, a.ascFanta_gNowValue, a.ascFanta_pID, a.ascFanta_gPos, replace(a.ascFanta_gPos,"B","") as gPosN, 
d.ascFanta_TACP, d.ascFanta_AACP, a.ascFanta_newVal_Date, c.ascFanta_pTeam, c.ascFanta_gFullName, b.Nx7D, b.NextOpp
from ascFanta_PlayerValue_NBA_2018_s2 a
inner join ascFanta_PlayerMaster_NBA_2018_s2 c on a.ascFanta_pID = c.ascFanta_pID and c.ascFanta_rStatus = "LIVE"
inner join ascFanta_NextSevenDaybyTeam b on a.ascFanta_newVal_Date = b.fmGmDate and c.ascFanta_pTeam = b.Team and b.Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s2 d on a.ascFanta_pID = d.ascFanta_pID and d.ascFanta_rStatus = "AcmCfm"
where a.ascFanta_rStatus = "ValCfm" and a.ascFanta_newVal_Date = "',oGmDate,'" and a.ascFanta_pID IN (',WLID,')');

PREPARE stmt FROM @stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

select oGmDate as 'txDate';

END