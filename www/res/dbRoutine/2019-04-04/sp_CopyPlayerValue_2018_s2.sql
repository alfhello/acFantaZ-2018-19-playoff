CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_CopyPlayerValue_2018_s2`(in inGmDate varchar(20))
BEGIN

-- prepare for Player Value changes update. Copy latest Player Stat to DailyValueRank

declare oGmDate varchar(10);
declare mrkDel int;
declare insDVR int;

if (inGmDate = null) or (inGmDate = '') then 
	call sp_GetOpendate_DTS(oGmDate);
else
	set oGmDate = inGmDate;
end if;

-- select oGmDate;

update ascFanta_DailyValueRank_NBA_2018_s2
set ascFanta_rStatus = 'OutDated' 
where ascFanta_mDate = oGmDate ;

set mrkDel = ROW_COUNT();

INSERT INTO ascFanta_DailyValueRank_NBA_2018_s2 (
ascFanta_pID, ascFanta_gPos, ascFanta_TACP, ascFanta_AACP, ascFanta_gmPlayed, 
ascFanta_pLast_ValKey, ascFanta_mDate, ascFanta_LastpValue, ascFanta_rStatus
)
select a.ascFanta_pID, a.ascFanta_gPos, a.ascFanta_TACP, a.ascFanta_AACP, a.ascFanta_Acm_gmPlayed, 
pV.ascFanta_newVal_Key, pV.ascFanta_newVal_Date, pV.ascFanta_gNowValue, 'ReadyValChg'
from ascFanta_DailyACPRank_NBA_2018_s2 a
inner join ascFanta_PlayerValue_NBA_2018_s2 pV on a.ascFanta_pID = pV.ascFanta_pID and pV.ascFanta_rStatus = 'ValCfm' 
where a.ascFanta_rStatus = 'AcmCfm' and pV.ascFanta_newVal_Date = oGmDate
order by a.ascFanta_TACP desc ;

set insDVR = row_count();

select mrkDel, insDVR, oGmDate, inGmDate;

END