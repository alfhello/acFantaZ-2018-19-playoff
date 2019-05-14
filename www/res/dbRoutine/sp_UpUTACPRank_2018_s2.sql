CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_UpUTACPRank_2018_s2`(in inGmDate varchar(20))
BEGIN

declare mkDel int;
declare RnkCfm int;
declare sRnk int;
declare InsRnk int;
declare UpdLRnk int;

insert into ascFanta_UTRoster_DailyRank_NBA_2018_s2 (
ascFanta_TeamID, ascFanta_TeamName, ascFanta_Group, ascFanta_GroupKey, ascFanta_TACP, ascFanta_TeamValue, ascFanta_gmDate, ascFanta_LogKey, ascFanta_rStatus, ascFanta_TimeStamp
)
select a.ascFanta_TeamId, a.ascFanta_TeamName, a.ascFanta_Group, a.ascFanta_GroupKey, sum(a.ascFanta_TodayTACP), b.ascFanta_TeamValue, inGmDate, b.ascFanta_LogKey, 'InsRnk', now()
from ascFanta_UTRoster_DailyLog_NBA_2018_s2 a
inner join (
	select ascFanta_TeamValue, ascFanta_LogDate, ascFanta_LogKey, ascFanta_TeamId, ascFanta_TeamName 
	from ascFanta_UTRoster_DailyLog_NBA_2018_s2 where ascFanta_LogDate = inGmDate and ascFanta_rStatus = 'UTACPCfm'
) b 
on a.ascFanta_TeamId = b.ascFanta_TeamID and a.ascFanta_TeamName = b.ascFanta_TeamName 
where a.ascFanta_LogDate <= inGmDate and a.ascFanta_rStatus = 'UTACPCfm'
group by a.ascFanta_TeamId;
set InsRnk = ROW_COUNT();

update ascFanta_UTRoster_DailyRank_NBA_2018_s2 a
inner join ascFanta_UTRoster_DailyRank_NBA_2018_s2 b on a.ascFanta_TeamId = b.ascFanta_TeamId and a.ascFanta_TeamName = b.ascFanta_TeamName and 
a.ascFanta_Group = b.ascFanta_Group and a.ascFanta_GroupKey = b.ascFanta_GroupKey
set a.ascFanta_lastRank = b.ascFanta_nowRank, a.ascFanta_lastUTRank = b.ascfanta_nowUTRank
where a.ascFanta_rStatus = 'InsRnk' and b.ascFanta_rStatus = 'RnkCfm' and a.ascFanta_gmDate <> b.ascFanta_gmDate;
set UpdLRnk = ROW_COUNT();

update ascFanta_UTRoster_DailyRank_NBA_2018_s2 set ascFanta_rStatus = 'Outdated' where ascFanta_rStatus = 'RnkCfm';
set mkDel = ROW_COUNT();

update ascFanta_UTRoster_DailyRank_NBA_2018_s2 set ascFanta_rStatus  = 'RnkCfm' where ascFanta_rStatus = 'InsRnk';
set RnkCfm = ROW_COUNT();


update ascFanta_UTRoster_DailyRank_NBA_2018_s2 dR
inner join (
select a.ascFanta_TeamID, a.ascFanta_TeamName, a.ascFanta_TACP, a.ascFanta_gmDate, 
if(ascFanta_TACP=@_last_TACP, @curRank:=@curRank,@curRank:=@_seq) as nowRank, @_seq:=@_seq+1, @_last_TACP:=ascFanta_TACP
from ascFanta_UTRoster_DailyRank_NBA_2018_s2 a, (select @curRank:=1, @_seq:=1, @_last_TACP:=0) r
where ascFanta_rStatus = 'RnkCfm'
order by ascFanta_TACP desc
) b on dR.ascFanta_TeamID = b.ascFanta_TeamID and dR.ascFanta_TeamName = b.ascFanta_TeamName and dR.ascFanta_gmDate = b.ascFanta_gmDate
set dR.ascFanta_nowRank = b.nowRank
where dR.ascFanta_gmDate = inGmDate and dR.ascFanta_rStatus = 'RnkCfm';
set sRnk = ROW_COUNT();

select InsRnk, UpdLRnk, mkDel, RnkCfm, sRnk;

END