CREATE DEFINER=`ascdphk1_admin`@`59.148.244.46` PROCEDURE `sp_GetUTRoster_DTS_2018_s1`(in inUT_ID varchar(36))
BEGIN

call sp_GetOpenDate_DTS(@a);

select @a, 'G' as UTR_Pos, 'G1' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP as 'ascFanta_gTTLACP', s.ascFanta_TACP as 'ascFanta_gLastACP',
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')) as 'Opp', ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-')) as 'NextGmDate'
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_G1 = p.ascFanta_pID and p.ascFanta_rStatus = 'LIVE'
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_G1 = v.ascFanta_pID and v.ascFanta_rStatus = 'ValCfm' and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s1 r on UTRoster.ascFanta_pID_G1 = r.ascFanta_pID and r.ascFanta_rStatus = 'AcmCfm'
left join ascFanta_PlayerStat_NBA_2018_s1   s on UTRoster.ascFanta_pID_G1 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a and mH.ascFanta_rStatus = 'LIVE'
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a and mA.ascFanta_rStatus = 'LIVE'
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'G' as UTR_Pos, 'G2' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, s.ascFanta_TACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')) as 'Opp', ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-')) as 'NextGmDate'
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_G2 = p.ascFanta_pID and p.ascFanta_rStatus = 'LIVE'
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_G2 = v.ascFanta_pID and v.ascFanta_rStatus = 'ValCfm' and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s1 r on UTRoster.ascFanta_pID_G2 = r.ascFanta_pID and r.ascFanta_rStatus = 'AcmCfm'
left join ascFanta_PlayerStat_NBA_2018_s1   s on UTRoster.ascFanta_pID_G2 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a and mH.ascFanta_rStatus = 'LIVE'
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a and mA.ascFanta_rStatus = 'LIVE'
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'F' as UTR_Pos, 'F1' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, s.ascFanta_TACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')) as 'Opp', ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-')) as 'NextGmDate'
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_F1 = p.ascFanta_pID and p.ascFanta_rStatus = 'LIVE'
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_F1 = v.ascFanta_pID and v.ascFanta_rStatus = 'ValCfm' and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s1 r on UTRoster.ascFanta_pID_F1 = r.ascFanta_pID and r.ascFanta_rStatus = 'AcmCfm'
left join ascFanta_PlayerStat_NBA_2018_s1   s on UTRoster.ascFanta_pID_F1 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a and mH.ascFanta_rStatus = 'LIVE'
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a and mA.ascFanta_rStatus = 'LIVE'
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'F' as UTR_Pos, 'F2' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, s.ascFanta_TACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')) as 'Opp', ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-')) as 'NextGmDate'
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_F2 = p.ascFanta_pID and p.ascFanta_rStatus = 'LIVE'
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_F2 = v.ascFanta_pID and v.ascFanta_rStatus = 'ValCfm' and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s1 r on UTRoster.ascFanta_pID_F2 = r.ascFanta_pID and r.ascFanta_rStatus = 'AcmCfm'
left join ascFanta_PlayerStat_NBA_2018_s1   s on UTRoster.ascFanta_pID_F2 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a and mH.ascFanta_rStatus = 'LIVE'
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a and mA.ascFanta_rStatus = 'LIVE'
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'C' as UTR_Pos, 'C1' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, s.ascFanta_TACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')) as 'Opp', ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-')) as 'NextGmDate'
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_C1 = p.ascFanta_pID and p.ascFanta_rStatus = 'LIVE'
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_C1 = v.ascFanta_pID and v.ascFanta_rStatus = 'ValCfm' and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s1 r on UTRoster.ascFanta_pID_C1 = r.ascFanta_pID and r.ascFanta_rStatus = 'AcmCfm'
left join ascFanta_PlayerStat_NBA_2018_s1   s on UTRoster.ascFanta_pID_C1 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a and mH.ascFanta_rStatus = 'LIVE'
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a and mA.ascFanta_rStatus = 'LIVE'
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'B' as UTR_Pos, 'B1' as UTR_PosV, 
p.ascFanta_gFullName as 'ascFanta_pName', p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, 
r.ascFanta_TACP, s.ascFanta_TACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')) as 'Opp', ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-')) as 'NextGmDate'
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_B1 = p.ascFanta_pID and p.ascFanta_rStatus = 'LIVE'
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_B1 = v.ascFanta_pID and v.ascFanta_rStatus = 'ValCfm' and v.ascFanta_Active = 1
inner join ascFanta_DailyACPRank_NBA_2018_s1 r on UTRoster.ascFanta_pID_B1 = r.ascFanta_pID and r.ascFanta_rStatus = 'AcmCfm'
left join ascFanta_PlayerStat_NBA_2018_s1   s on UTRoster.ascFanta_pID_B1 = s.ascFanta_personID and s.ascFanta_rStatus = 'CfmRec' and date(ascFanta_sMatchDate) = date_add(date(@a), interval -1 day)
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a and mH.ascFanta_rStatus = 'LIVE'
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a and mA.ascFanta_rStatus = 'LIVE'
where UTRoster.ascFanta_TeamID = inUT_ID ;

END