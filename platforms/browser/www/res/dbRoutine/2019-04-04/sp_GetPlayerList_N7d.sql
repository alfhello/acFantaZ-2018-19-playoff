CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetPlayerList_N7d`(
in inPos varchar(20), in inCostRange decimal(6,2), in inPName varchar(50), in OrdBy varchar(50)
)
BEGIN

declare ordkey varchar(50);

if (OrdBy = 'TACP') then
set ordkey = 'pA.ascFanta_TACP' ;
end if ;

if (OrdBy = 'AACP') then
set ordkey = 'pA.ascFanta_AACP' ;
end if ;

set @SQL = concat('
select a.ascFanta_pID, pM.ascFanta_gFullName, a.ascFanta_gPos, a.ascFanta_gNowValue,
a.ascFanta_newVal_Key, pA.ascFanta_TACP, pA.ascFanta_AACP, pM.ascFanta_pTeam, NGm.Nx7D, NGm.HmGm, NGm.AyGm
from ascFanta_PlayerValue_NBA_2018_s2 a
inner join ascFanta_PlayerMaster_NBA_2018_s2 pM on a.ascFanta_pID = pM.ascFanta_pID
inner join ascFanta_DailyACPRank_NBA_2018_s2 pA on a.ascFanta_pID = pA.ascFanta_pID
inner join ascFanta_NextSevenDaybyTeam NGm on pM.ascFanta_pTeam = NGm.Team and NGm.Active = 1
where a.ascFanta_rStatus = "ValCfm" and a.ascFanta_Active = 1 and pM.ascFanta_rStatus = "LIVE"
and pA.ascFanta_rStatus = "AcmCfm" and a.ascFanta_gPos like "%',inPos,'%"
order by ',ordkey,' desc;');

prepare stmt from @SQL;
execute stmt;
deallocate prepare stmt;

END