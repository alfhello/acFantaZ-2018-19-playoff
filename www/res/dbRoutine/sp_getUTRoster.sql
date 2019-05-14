CREATE DEFINER=`ascdphk1_admin`@`59.148.244.46` PROCEDURE `sp_GetUTRoster`(in inUT_ID varchar(20), in inDate varchar(10))
BEGIN

call sp_GetOpenDate(indate, @a);

select @a, 'G' as UTR_Pos, 'G1' as UTR_PosV, 
p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, v.ascFanta_gTTLACP, v.ascFanta_gLastACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')) as 'Opp', ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-')) as 'NextGmDate'
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_G1 = p.ascFanta_pID
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_G1 = v.ascFanta_pID and v.ascFanta_Status = 8
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'G', 'G2',
p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, v.ascFanta_gTTLACP, v.ascFanta_gLastACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')), ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-'))
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_G2 = p.ascFanta_pID
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_G2 = v.ascFanta_pID and v.ascFanta_Status = 8
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'F', 'F1', 
p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, v.ascFanta_gTTLACP, v.ascFanta_gLastACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')), ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-'))
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_F1 = p.ascFanta_pID
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_F1 = v.ascFanta_pID and v.ascFanta_Status = 8
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'F', 'F2', 
p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, v.ascFanta_gTTLACP, v.ascFanta_gLastACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')), ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-'))
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_F2 = p.ascFanta_pID
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_F2 = v.ascFanta_pID and v.ascFanta_Status = 8
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'C', 'C1',
p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, v.ascFanta_gTTLACP, v.ascFanta_gLastACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')), ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-'))
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_C1 = p.ascFanta_pID
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_C1 = v.ascFanta_pID and v.ascFanta_Status = 8
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a
where UTRoster.ascFanta_TeamID = inUT_ID
union
select @a, 'B', 'B1',
p.ascFanta_pName, p.ascFanta_pID, p.ascFanta_gPos, p.ascFanta_pTeam, v.ascFanta_gTTLACP, v.ascFanta_gLastACP,
v.ascFanta_gNowValue, v.ascFanta_gChgValue, v.ascFanta_gNowNOH-v.ascFanta_gLastNOH as 'ChgNOH',
ifnull(mH.ascFanta_mAway,ifnull(concat('@',mA.ascFanta_mHome),'-')), ifnull(mH.ascFanta_mDate,ifnull(mA.ascFanta_mDate,'-'))
from ascFanta_UTRoster_Master_NBA_2018_s1 UTRoster
inner join ascFanta_PlayerMaster_NBA_2018_s1 p on UTRoster.ascFanta_pID_B1 = p.ascFanta_pID
inner join ascFanta_PlayerValue_NBA_2018_s1  v on UTRoster.ascFanta_pID_B1 = v.ascFanta_pID and v.ascFanta_Status = 8
left outer join ascFanta_Match_NBA_2018     mH on p.ascFanta_pTeam = mH.ascFanta_mHome and mH.ascFanta_mDate = @a
left outer join ascFanta_Match_NBA_2018     mA on p.ascFanta_pTeam = mA.ascFanta_mAway and mA.ascFanta_mDate = @a
where UTRoster.ascFanta_TeamID = inUT_ID;

END