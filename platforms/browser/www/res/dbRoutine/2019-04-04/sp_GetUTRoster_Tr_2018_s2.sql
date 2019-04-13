CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetUTRoster_Tr_2018_s2`(in inUT_ID varchar(36))
BEGIN

call sp_GetOpenDate_DTS(@a);

select @a, 'G' as UTR_Pos, 'G1' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP as 'ascFanta_gTTLACP', ifnull(s.ascFanta_TACP,0) as 'ascFanta_gLastACP',
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
NGm.NextOpp, NGm.Nx7d
from ascFanta_UTRoster_Master_NBA_2018_s2 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s2 p on UTRoster.ascFanta_pID_G1 = p.ascFanta_pID and (p.ascFanta_rStatus = 'LIVE' or p.ascFanta_rStatus = 'SysRec')
inner join ascFanta_PlayerValue_NBA_2018_s2  v on UTRoster.ascFanta_pID_G1 = v.ascFanta_pID and (v.ascFanta_rStatus = 'ValCfm' or v.ascFanta_rStatus = 'SysRec') and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s2 r on UTRoster.ascFanta_pID_G1 = r.ascFanta_pID and (r.ascFanta_rStatus = 'AcmCfm' or r.ascFanta_rStatus = 'SysRec')
left join ascFanta_PlayerStat_NBA_2018_s2   s on UTRoster.ascFanta_pID_G1 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left join ascFanta_NextSevenDaybyTeam NGm on NGm.fmGmDate = @a and p.ascFanta_pTeam = NGm.Team and NGm.Active = 1
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'G' as UTR_Pos, 'G2' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, ifnull(s.ascFanta_TACP,0),
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
NGm.NextOpp, NGm.Nx7d
from ascFanta_UTRoster_Master_NBA_2018_s2 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s2 p on UTRoster.ascFanta_pID_G2 = p.ascFanta_pID and (p.ascFanta_rStatus = 'LIVE' or p.ascFanta_rStatus = 'SysRec')
inner join ascFanta_PlayerValue_NBA_2018_s2  v on UTRoster.ascFanta_pID_G2 = v.ascFanta_pID and (v.ascFanta_rStatus = 'ValCfm' or v.ascFanta_rStatus = 'SysRec') and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s2 r on UTRoster.ascFanta_pID_G2 = r.ascFanta_pID and (r.ascFanta_rStatus = 'AcmCfm' or r.ascFanta_rStatus = 'SysRec')
left join ascFanta_PlayerStat_NBA_2018_s2   s on UTRoster.ascFanta_pID_G2 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left join ascFanta_NextSevenDaybyTeam NGm on NGm.fmGmDate = @a and p.ascFanta_pTeam = NGm.Team and NGm.Active = 1
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'F' as UTR_Pos, 'F1' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, ifnull(s.ascFanta_TACP,0),
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
NGm.NextOpp, NGm.Nx7d
from ascFanta_UTRoster_Master_NBA_2018_s2 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s2 p on UTRoster.ascFanta_pID_F1 = p.ascFanta_pID and (p.ascFanta_rStatus = 'LIVE' or p.ascFanta_rStatus = 'SysRec')
inner join ascFanta_PlayerValue_NBA_2018_s2  v on UTRoster.ascFanta_pID_F1 = v.ascFanta_pID and (v.ascFanta_rStatus = 'ValCfm' or v.ascFanta_rStatus = 'SysRec') and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s2 r on UTRoster.ascFanta_pID_F1 = r.ascFanta_pID and (r.ascFanta_rStatus = 'AcmCfm' or r.ascFanta_rStatus = 'SysRec')
left join ascFanta_PlayerStat_NBA_2018_s2   s on UTRoster.ascFanta_pID_F1 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left join ascFanta_NextSevenDaybyTeam NGm on NGm.fmGmDate = @a and p.ascFanta_pTeam = NGm.Team and NGm.Active = 1
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'F' as UTR_Pos, 'F2' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, ifnull(s.ascFanta_TACP,0),
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
NGm.NextOpp, NGm.Nx7d
from ascFanta_UTRoster_Master_NBA_2018_s2 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s2 p on UTRoster.ascFanta_pID_F2 = p.ascFanta_pID and (p.ascFanta_rStatus = 'LIVE' or p.ascFanta_rStatus = 'SysRec')
inner join ascFanta_PlayerValue_NBA_2018_s2  v on UTRoster.ascFanta_pID_F2 = v.ascFanta_pID and (v.ascFanta_rStatus = 'ValCfm' or v.ascFanta_rStatus = 'SysRec') and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s2 r on UTRoster.ascFanta_pID_F2 = r.ascFanta_pID and (r.ascFanta_rStatus = 'AcmCfm' or r.ascFanta_rStatus = 'SysRec')
left join ascFanta_PlayerStat_NBA_2018_s2   s on UTRoster.ascFanta_pID_F2 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left join ascFanta_NextSevenDaybyTeam NGm on NGm.fmGmDate = @a and p.ascFanta_pTeam = NGm.Team and NGm.Active = 1
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'C' as UTR_Pos, 'C1' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, ifnull(s.ascFanta_TACP,0),
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
NGm.NextOpp, NGm.Nx7d
from ascFanta_UTRoster_Master_NBA_2018_s2 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s2 p on UTRoster.ascFanta_pID_C1 = p.ascFanta_pID and (p.ascFanta_rStatus = 'LIVE' or p.ascFanta_rStatus = 'SysRec')
inner join ascFanta_PlayerValue_NBA_2018_s2  v on UTRoster.ascFanta_pID_C1 = v.ascFanta_pID and (v.ascFanta_rStatus = 'ValCfm' or v.ascFanta_rStatus = 'SysRec') and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s2 r on UTRoster.ascFanta_pID_C1 = r.ascFanta_pID and (r.ascFanta_rStatus = 'AcmCfm' or r.ascFanta_rStatus = 'SysRec')
left join ascFanta_PlayerStat_NBA_2018_s2   s on UTRoster.ascFanta_pID_C1 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left join ascFanta_NextSevenDaybyTeam NGm on NGm.fmGmDate = @a and p.ascFanta_pTeam = NGm.Team and NGm.Active = 1
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'B' as UTR_Pos, 'B1' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, ifnull(s.ascFanta_TACP,0),
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
NGm.NextOpp, NGm.Nx7d
from ascFanta_UTRoster_Master_NBA_2018_s2 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s2 p on UTRoster.ascFanta_pID_B1 = p.ascFanta_pID and (p.ascFanta_rStatus = 'LIVE' or p.ascFanta_rStatus = 'SysRec')
inner join ascFanta_PlayerValue_NBA_2018_s2  v on UTRoster.ascFanta_pID_B1 = v.ascFanta_pID and (v.ascFanta_rStatus = 'ValCfm' or v.ascFanta_rStatus = 'SysRec') and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s2 r on UTRoster.ascFanta_pID_B1 = r.ascFanta_pID and (r.ascFanta_rStatus = 'AcmCfm' or r.ascFanta_rStatus = 'SysRec')
left join ascFanta_PlayerStat_NBA_2018_s2   s on UTRoster.ascFanta_pID_B1 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left join ascFanta_NextSevenDaybyTeam NGm on NGm.fmGmDate = @a and p.ascFanta_pTeam = NGm.Team and NGm.Active = 1
where UTRoster.ascFanta_TeamID = inUT_ID ;


select 
group_concat(ascFanta_pID_G1,'|',ascFanta_pPos_G1,'|',ascFanta_trKey_G1,'|',cast(ascFanta_pBuyDate_G1 as char),'|',ascFanta_rootKey_G1) as G1Log,
group_concat(ascFanta_pID_G2,'|',ascFanta_pPos_G2,'|',ascFanta_trKey_G2,'|',cast(ascFanta_pBuyDate_G2 as char),'|',ascFanta_rootKey_G2) as G2Log,
group_concat(ascFanta_pID_F1,'|',ascFanta_pPos_F1,'|',ascFanta_trKey_F1,'|',cast(ascFanta_pBuyDate_F1 as char),'|',ascFanta_rootKey_F1) as F1Log,
group_concat(ascFanta_pID_F2,'|',ascFanta_pPos_F2,'|',ascFanta_trKey_F2,'|',cast(ascFanta_pBuyDate_F2 as char),'|',ascFanta_rootKey_F2) as F2Log,
group_concat(ascFanta_pID_C1,'|',ascFanta_pPos_C1,'|',ascFanta_trKey_C1,'|',cast(ascFanta_pBuyDate_C1 as char),'|',ascFanta_rootKey_C1) as C1Log,
group_concat(ascFanta_pID_B1,'|',ascFanta_pPos_B1,'|',ascFanta_trKey_B1,'|',cast(ascFanta_pBuyDate_B1 as char),'|',ascFanta_rootKey_B1) as B1Log,
'pID|pPos|trKey|BuyDT|rootKey' as infoLog
from ascFanta_UTRoster_Master_NBA_2018_s2
where ascFanta_TeamID = inUT_ID ;

END