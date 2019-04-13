CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetUTHeadInfo_2018_s2`(in inTeamKey varchar(50), in inGrpKey varchar(50))
BEGIN

call sp_GetOpenDate_DTS(@IN_gmDate);
set @IN_gmDate = date_add(@IN_gmDate, interval -1 day);

select b.ascFanta_Group, b.ascFanta_GroupKey, a.ascFanta_TeamName, a.ascFanta_TeamId, a.ascFanta_gValueRemain, 
(ifnull(g1.ascFanta_gNowValue,0)+ifnull(g2.ascFanta_gNowValue,0)
+ifnull(f1.ascFanta_gNowValue,0)+ifnull(f2.ascFanta_gNowValue,0)
+ifnull(c1.ascFanta_gNowValue,0)+ifnull(b1.ascFanta_gNowValue,0)) as 'TeamValue',
ifnull(UTP.ascFanta_TodayTACP,0) as 'lastACP', @IN_gmDate as 'LastGmDate',
ifnull(UTR.ascFanta_TACP,0) as 'lastTACP', ifnull(UTR.ascFanta_TeamValue,0) as 'LastTeamValue', UTR.ascFanta_nowRank as 'nowRank'
from ascFanta_UTRoster_Master_NBA_2018_s2 a
inner join ascFanta_UserTeam_Master b on a.ascFanta_TeamID = b.ascFanta_TeamID
inner join ascFanta_PlayerValue_NBA_2018_s2 g1 on a.ascFanta_pID_G1 = g1.ascFanta_pID and (g1.ascFanta_rStatus = 'ValCfm' or g1.ascFanta_rStatus = 'SysRec') and g1.ascFanta_Active = 1
inner join ascFanta_PlayerValue_NBA_2018_s2 g2 on a.ascFanta_pID_G2 = g2.ascFanta_pID and (g2.ascFanta_rStatus = 'ValCfm' or g2.ascFanta_rStatus = 'SysRec') and g2.ascFanta_Active = 1
inner join ascFanta_PlayerValue_NBA_2018_s2 f1 on a.ascFanta_pID_F1 = f1.ascFanta_pID and (f1.ascFanta_rStatus = 'ValCfm' or f1.ascFanta_rStatus = 'SysRec') and f1.ascFanta_Active = 1
inner join ascFanta_PlayerValue_NBA_2018_s2 f2 on a.ascFanta_pID_F2 = f2.ascFanta_pID and (f2.ascFanta_rStatus = 'ValCfm' or f2.ascFanta_rStatus = 'SysRec') and f2.ascFanta_Active = 1
inner join ascFanta_PlayerValue_NBA_2018_s2 c1 on a.ascFanta_pID_C1 = c1.ascFanta_pID and (c1.ascFanta_rStatus = 'ValCfm' or c1.ascFanta_rStatus = 'SysRec') and c1.ascFanta_Active = 1
inner join ascFanta_PlayerValue_NBA_2018_s2 b1 on a.ascFanta_pID_B1 = b1.ascFanta_pID and (b1.ascFanta_rStatus = 'ValCfm' or b1.ascFanta_rStatus = 'SysRec') and b1.ascFanta_Active = 1
left join ascFanta_UTRoster_DailyLog_NBA_2018_s2 UTP on a.ascFanta_TeamId = UTP.ascFanta_TeamId and UTP.ascFanta_LogDate = @IN_gmDate
left join ascFanta_UTRoster_DailyRank_NBA_2018_s2 UTR on a.ascFanta_TeamId = UTR.ascFanta_TeamId and a.ascFanta_TeamName = UTR.ascFanta_TeamName and UTR.ascFanta_rStatus = 'RnkCfm'
where a.ascFanta_TeamID = inTeamKey and b.ascFanta_GroupKey = inGrpKey
;

END