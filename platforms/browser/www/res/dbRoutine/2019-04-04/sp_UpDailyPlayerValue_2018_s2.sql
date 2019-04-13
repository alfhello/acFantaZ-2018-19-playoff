CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_UpDailyPlayerValue_2018_s2`(in inGmDate varchar(20))
BEGIN

-- After copy latest Player Stat to DailyValueRank, Update NOH & Player Stat secondly

declare oGmDate varchar(10);
declare updRec int;


if (inGmDate = null) or (inGmDate = '') then 
	call sp_GetOpendate_DTS(oGmDate);
else
	set oGmDate = inGmDate;
end if;

update ascFanta_DailyValueRank_NBA_2018_s2 as a
left outer join ascFanta_PlayerStat_NBA_2018_s2 b on a.ascFanta_pID = b.ascFanta_personId and a.ascFanta_mDate = date(b.ascFanta_sMatchDate)
set a.ascFanta_LastACP = ifnull(b.ascFanta_TACP,0)
where ascFanta_mDate = oGmDate and a.ascFanta_rStatus = 'ReadyValChg' ;

set updRec = ROW_COUNT();
select updRec, oGmDate;

END