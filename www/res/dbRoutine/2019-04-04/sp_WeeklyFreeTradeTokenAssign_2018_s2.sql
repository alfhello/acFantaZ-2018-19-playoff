CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_WeeklyFreeTradeTokenAssign_2018_s2`(
in inGmDate varchar(20), in passCode varchar(30)
)
BEGIN

declare weeklyfreeKey varchar(50);
declare oDate varchar(20);

call sp_GetOpenDate_DTS(@oGmDate);
set oDate = @oGmDate;

call sp_GetOpenDate_recKey(oDate, @oKey);

if passCode = @oKey and inGmDate = oDate then

set weeklyfreeKey = uuid();

insert into ascFanta_TradeToken_Master_2018_s2 (
ascFanta_TeamID, ascFanta_TeamName, ascFanta_Group, ascFanta_GroupKey, 
ascFanta_TradeToken_Key, ascFanta_TradeToken_Type, ascFanta_TradeToken_TypeKey, 
ascFanta_TradeToken_genDate, ascFanta_TradeToken_Active, ascFanta_lastUpdate_DT
)
select ascFanta_TeamID, ascFanta_TeamName, ascFanta_Group, ascFanta_GroupKey,
uuid(), 'weeklyFree', weeklyfreeKey, 
inGmDate, 1, now()
from ascFanta_UTRoster_Master_NBA_2018_s2;

else 

select 'passcode not match. rejected';

end if;


END