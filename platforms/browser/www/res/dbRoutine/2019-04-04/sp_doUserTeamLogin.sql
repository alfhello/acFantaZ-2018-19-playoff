CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_doUserTeamLogin`(
in inName varchar(200), inPass varchar(50), in inNKey varchar(50), in inLKey varchar(50)
)
BEGIN

select a.asc_userID, a.ascFanta_TeamName, a.asc_userName, b.ascFanta_TeamID, b.ascFanta_Group, b.ascFanta_GroupKey, 
sg.ascFanta_seasonYear, sg.ascFanta_seasonStage, date(sg.ascFanta_dayStart_est) as 'ActiveGmDate'
from ascUsers a
inner join ascFanta_UserTeam_Master b on a.ascFanta_TeamName = b.ascFanta_TeamName and a.asc_rStatus = b.ascFanta_rStatus and a.asc_rStatus = 'LIVE'
and a.asc_rActive = b.ascFanta_rActive and a.asc_rActive = 1
left join ascFanta_DailyTimeSegment_NBA sg on sg.ascFanta_rActive = a.asc_rActive
where (a.ascFanta_TeamName = inName and a.asc_passWd = inPass)
union
select a.asc_userID, a.ascFanta_TeamName, a.asc_userName, b.ascFanta_TeamID, b.ascFanta_Group, b.ascFanta_GroupKey, 
sg.ascFanta_seasonYear, sg.ascFanta_seasonStage, date(sg.ascFanta_dayStart_est) as 'ActiveGmDate'
from ascUsers a
inner join ascUser_Log l on a.asc_userKey = l.asc_lastInNameKey
inner join ascFanta_UserTeam_Master b on a.ascFanta_TeamName = b.ascFanta_TeamName and a.asc_rStatus = b.ascFanta_rStatus and a.asc_rStatus = 'LIVE'
left join ascFanta_DailyTimeSegment_NBA sg on sg.ascFanta_rActive = a.asc_rActive
where asc_Active = 1 and date_add(now(), interval -1 day) <= asc_LastActionDT and a.asc_userKey = inNKey and l.asc_LastKey = inLKey;


END