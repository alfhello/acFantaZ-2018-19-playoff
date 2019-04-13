CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_genNewPlayerInitValue`()
BEGIN

insert into ascFanta_PlayerValue_NBA_2018_s2 (
ascFanta_pID, ascFanta_gPos, ascFanta_gInitValue, ascFanta_gLastValue, ascFanta_gTTLACP, ascFanta_gLastACP,
ascFanta_gNowValue, ascFanta_gChgValue, ascFanta_newVal_Key, ascFanta_newVal_Date, ascFanta_Active, ascFanta_rStatus
)
select a.ascFanta_pID, a.ascFanta_gPos, 0, 0, 0, 0, 0, 0, uuid(), '2019-04-01', 1, 'WaitValCfm'
from ascFanta_PlayerMaster_NBA_2018_s2 a
inner join ascFanta_DailyACPRank_NBA_2018_s2 b on a.ascFanta_pID = b.ascFanta_pID and b.ascFanta_rStatus = 'AcmCfm'
where a.ascFanta_rStatus = 'LIVE' and a.ascFanta_pID not in (
select ascFanta_pID from ascFanta_PlayerValue_NBA_2018_s2 
where ascFanta_rStatus = 'ValCfm' and ascFanta_Active = 1
) ;


END