CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetNext7DayGmbyTeam`()
BEGIN

declare tmUpd int;

call sp_GetOpendate_DTS(@oD);

update ascFanta_NextSevenDaybyTeam set Active = 0 
where fmGmDate = @od;

INSERT into ascFanta_NextSevenDaybyTeam 
select T.ascFanta_tAbbr as 'Team', ifnull(a.HmGm,0) as 'HmGm', ifnull(b.AyGm,0) as 'AyGm', 
ifnull(a.HmGm,0)+ifnull(b.AyGm,0) as 'Nx7D', @oD as 'fmGmDate', 1 as 'Active', 
case when c.OppTeam is null and d.AOppTeam is null then '-' else ifnull(c.OppTeam,d.AOppTeam) end NextOpp
from ascFanta_Team_NBA_2018 T
left join (
select * from (
select ascFanta_mHome as Team, count(ascFanta_mAway) as HmGm from ascFanta_Match_NBA_2018
where ascFanta_mStage = 2 and ascFanta_mDate >= @oD and ascFanta_mDate <= date_add(@oD, interval 7 day)
and ascFanta_rStatus = 'LIVE'
group by ascFanta_mHome
) Hm
) a on T.ascFanta_tAbbr = a.Team
left join (
select * from (
select ascFanta_mAway as Team, count(ascFanta_mHome) as AyGm from ascFanta_Match_NBA_2018
where ascFanta_mStage = 2 and ascFanta_mDate >= @oD and ascFanta_mDate <= date_add(@oD, interval 7 day)
and ascFanta_rStatus = 'LIVE'
group by ascFanta_mAway
) Aw
) b on T.ascFanta_tAbbr = b.Team
left join (
select * from (
select ascFanta_mAway as OppTeam, ascFanta_mHome from ascFanta_Match_NBA_2018
where ascFanta_mStage = 2 and ascFanta_mDate = date_add(@oD, interval 1 day)
and ascFanta_rStatus = 'LIVE'
) Hm
) c on T.ascFanta_tAbbr = c.ascFanta_mHome
left join (
select * from (
select concat('@',ascFanta_mHome) as AOppTeam, ascFanta_mAway from ascFanta_Match_NBA_2018
where ascFanta_mStage = 2 and ascFanta_mDate = date_add(@oD, interval 1 day)
and ascFanta_rStatus = 'LIVE'
) Aw
) d on T.ascFanta_tAbbr = d.ascFanta_mAway
where T.ascFanta_rStatus = 'LIVE';

set tmUpd = row_count();
select tmUpd;

END