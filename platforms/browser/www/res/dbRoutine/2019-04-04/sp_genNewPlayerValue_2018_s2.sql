CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_genNewPlayerValue_2018_s2`(in inGmDate varchar(20))
BEGIN

declare oGmDate varchar(20);
declare upDVR int;
declare upPV int;

if (inGmDate = null) or (inGmDate = '') then 
	call sp_GetOpendate_DTS(oGmDate);
else
	set oGmDate = inGmDate;
end if;

update ascFanta_DailyValueRank_NBA_2018_s2
set 
ascFanta_pValue_Change = 0,
ascFanta_pValue_Final = ascFanta_LastpValue,
ascFanta_rStatus = 'ValCfm',
ascFanta_pNow_ValKey = uuid()
where ascFanta_rStatus = 'ReadyValChg' and ascFanta_mDate = oGmDate;
set upDVR = ROW_COUNT();

update ascFanta_PlayerValue_NBA_2018_s2 as a
inner join ascFanta_DailyValueRank_NBA_2018_s2 b on a.ascFanta_pID = b.ascFanta_pID
set 
a.ascFanta_lastVal_Key = a.ascFanta_newVal_Key,
a.ascFanta_newVal_Key = b.ascFanta_pNow_ValKey,
a.ascFanta_newVal_Date = date_add(oGmDate, interval 1 day),
a.ascFanta_gNowValue = b.ascFanta_pValue_Final
where b.ascFanta_mDate = oGmDate and b.ascFanta_rStatus = 'ValCfm';
set upPV = ROW_COUNT();

select upDVR, upPV, oGmDate;

END