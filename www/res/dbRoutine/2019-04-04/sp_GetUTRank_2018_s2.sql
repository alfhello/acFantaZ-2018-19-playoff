CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetUTRank_2018_s2`(
in inTeamKey varchar(50), in inGrpKey varchar(50), in_GmDate varchar(20), in inType varchar(10)
)
BEGIN

if (inGrpKey = null) or (inGrpKey = '') then 

	select ascFanta_GroupKey into @PrnTm from ascFanta_UTRoster_DailyLog_NBA_2018_s2
	where ascFanta_TeamID = inTeamKey and ascFanta_logDate = in_GmDate;
	
	if (inType = 'Overall') then

	select a.ascFanta_TeamName, a.ascFanta_TeamID, a.ascFanta_Group, a.ascFanta_GroupKey, a.ascFanta_TACP, a.ascFanta_TeamValue, cast(a.ascFanta_gmDate as char) as 'ascFanta_gmDate', 
	a.ascFanta_lastRank, a.ascFanta_nowRank, b.ascFanta_TodayTACP -- , a.ascFanta_lastUTRank, a.ascFanta_nowUTRank
    , case when a.ascFanta_TeamID = inTeamKey and a.ascFanta_GroupKey = @PrnTm then 'SelfTm' else 
    case when a.ascFanta_GroupKey = @PrnTm then 'PrnTm' else 'OthTm' end end as TeamHL
	from ascFanta_UTRoster_DailyRank_NBA_2018_s2 a
	inner join ascFanta_UTRoster_DailyLog_NBA_2018_s2 b on a.ascFanta_GroupKey = b.ascFanta_GroupKey and a.ascFanta_TeamID = b.ascFanta_TeamID 
	and a.ascFanta_gmDate = b.ascFanta_LogDate and b.ascFanta_rStatus = 'UTACPCfm'
	where a.ascFanta_gmDate = in_GmDate
	order by a.ascFanta_nowRank asc ;

	end if ;

	if (inType = 'Daily') then

	select a.ascFanta_TeamName, a.ascFanta_TeamID, a.ascFanta_Group, a.ascFanta_GroupKey, a.ascFanta_TodayTACP, cast(a.ascFanta_logDate as char) as 'ascFanta_gmDate',
	if(ascFanta_TodayTACP=@_last_TACP, @curRank:=@curRank, @curRank:=@_seq) as LGmDRank, @_seq:=@_seq+1, @_last_TACP:=ascFanta_TodayTACP
    , case when a.ascFanta_TeamID = inTeamKey and a.ascFanta_GroupKey = @PrnTm then 'SelfTm' else 
    case when a.ascFanta_GroupKey = @PrnTm then 'PrnTm' else 'OthTm' end end as TeamHL
	from ascFanta_UTRoster_DailyLog_NBA_2018_s2 a, (select @curRank:=1, @_seq:=1, @_last_TACP:=0) r
	where a.ascFanta_logDate = in_GmDate
	order by a.ascFanta_TodayTACP desc;

	end if ;

else

	if (inType = 'Overall') then
    
		select a.ascFanta_TeamName, a.ascFanta_TeamID, a.ascFanta_Group, a.ascFanta_GroupKey, a.ascFanta_TACP, a.ascFanta_TeamValue, cast(a.ascFanta_gmDate as char) as 'ascFanta_gmDate', 
		-- a.ascFanta_lastRank, a.ascFanta_nowRank, 
		a.ascFanta_lastUTRank, a.ascFanta_nowUTRank, b.ascFanta_TodayTACP
        , case when a.ascFanta_TeamID = inTeamKey then 'SelfTm' else 'OthTm' end as TeamHL
		from ascFanta_UTRoster_DailyRank_NBA_2018_s2 a
		inner join ascFanta_UTRoster_DailyLog_NBA_2018_s2 b on a.ascFanta_GroupKey = b.ascFanta_GroupKey and a.ascFanta_TeamID = b.ascFanta_TeamID 
		and a.ascFanta_gmDate = b.ascFanta_LogDate and b.ascFanta_rStatus = 'UTACPCfm' and a.ascFanta_GroupKey = inGrpKey
		where a.ascFanta_gmDate = in_GmDate
		order by a.ascFanta_nowRank asc ;
    
    end if ;

	if (inType = 'Daily') then

		select a.ascFanta_TeamName, a.ascFanta_TeamID, a.ascFanta_Group, a.ascFanta_GroupKey, a.ascFanta_TodayTACP, cast(a.ascFanta_logDate as char) as 'ascFanta_gmDate',
		if(ascFanta_TodayTACP=@_last_TACP, @curRank:=@curRank, @curRank:=@_seq) as LGmDRank, @_seq:=@_seq+1, @_last_TACP:=ascFanta_TodayTACP
		, case when a.ascFanta_TeamID = inTeamKey then 'SelfTm' else 'OthTm' end as TeamHL
        from ascFanta_UTRoster_DailyLog_NBA_2018_s2 a, (select @curRank:=1, @_seq:=1, @_last_TACP:=0) r
		where a.ascFanta_logDate = in_GmDate and a.ascFanta_GroupKey = inGrpKey
		order by a.ascFanta_TodayTACP desc;

	end if ;


end if;

select a.ascFanta_TeamName, a.ascFanta_Group, a.ascFanta_nowRank, a.ascFanta_nowUTRank, b.ascFanta_TodayTACP, a.ascFanta_TACP from ascFanta_UTRoster_DailyRank_NBA_2018_s2 a
inner join ascFanta_UTRoster_DailyLog_NBA_2018_s2 b on a.ascFanta_TeamID = b.ascFanta_TeamID and a.ascFanta_gmDate = b.ascFanta_LogDate
where a.ascFanta_rStatus = 'RnkCfm' and a.ascFanta_TeamID = inTeamKey ;

select max(a.ascFanta_TACP) as 'topACP', max(b.ascFanta_TodayTACP) as 'TodayTop' from ascFanta_UTRoster_DailyRank_NBA_2018_s2 a
inner join ascFanta_UTRoster_DailyLog_NBA_2018_s2 b on a.ascFanta_gmDate = b.ascFanta_LogDate
where a.ascFanta_gmDate = in_GmDate ;

END