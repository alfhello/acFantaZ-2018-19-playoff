CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_doUTPosX_2018_s2`(
in inTeamKey varchar(50), in inGrpKey varchar(50),  in inPosX varchar(50), 
in fmPlayerID varchar(200), in toPlayerID varchar(200)
)
BEGIN

declare rCount INT;
declare loopCount INT;
declare posVal varchar(10);
declare fmIDV varchar(20);
declare toIDV varchar(20);
declare aTeamName varchar(200);
declare aGroupName varchar(200);
declare aGmDate varchar(500);

select a.ascFanta_TeamName, a.ascFanta_Group, date(b.ascFanta_dayStart_est)
from ascFanta_UTRoster_Master_NBA_2018_s2 a, ascFanta_DailyTimeSegment_NBA b
where ascFanta_TeamID = inTeamKey and ascFanta_GroupKey = inGrpKey 
and b.ascFanta_rActive = 1
into aTeamName, aGroupName, aGmDate;

if aTeamName is not null then

set rCount = 0;
set loopCount = LENGTH(inPosX) - LENGTH(REPLACE(inPosX, ',', ''));

while rCount <= loopCount do

	if rcount = 0 then
		set posVal = left(inPosX,length(SUBSTRING_INDEX(inPosX,",",1)));
        set fmIDV =  left(fmPlayerID,length(SUBSTRING_INDEX(fmPlayerID,",",1)));
        set toIDV =  left(toPlayerID,length(SUBSTRING_INDEX(toPlayerID,",",1)));
	else 
		set posVal = mid(SUBSTRING_INDEX(inPosX, ",", rCount+1), length(SUBSTRING_INDEX(inPosX, ",", rCount))+2, length(SUBSTRING_INDEX(inPosX, ",", rCount+2)));
		set fmIDV = mid(SUBSTRING_INDEX(fmPlayerID, ",", rCount+1), length(SUBSTRING_INDEX(fmPlayerID, ",", rCount))+2, length(SUBSTRING_INDEX(fmPlayerID, ",", rCount+2)));        
        set toIDV = mid(SUBSTRING_INDEX(toPlayerID, ",", rCount+1), length(SUBSTRING_INDEX(toPlayerID, ",", rCount))+2, length(SUBSTRING_INDEX(toPlayerID, ",", rCount+2)));
	end if;
    
    insert into ascFanta_UTRoster_TX_NBA_2018_s2 (
    ascFanta_TeamID, ascFanta_TeamName, ascFanta_Group, ascFanta_GroupKey, ascFanta_TxGmDate,
    ascFanta_XchType, ascFanta_XchPos, ascFanta_fmPlayerID, ascFanta_toPlayerID
    )
    select inTeamKey, aTeamName, aGroupName, inGrpKey, aGmDate,
    'PosX', posVal, fmIDV, toIDV;
    
    set rCount = rCount + 1;
end while;

else 

	select 'No TeamData found or updated' as 'Error';
    
end if ;

select 'Pos Exchange successfully.' as spRes, rCount as 'RecCount';

/*
select now() as txDT, 
left(inPosX,length(SUBSTRING_INDEX(inPosX,",",1))) as 'PosX1', 
mid(SUBSTRING_INDEX(inPosX, ",", 2), length(SUBSTRING_INDEX(inPosX, ",", 1))+2, length(SUBSTRING_INDEX(inPosX, ",", 2))) as 'PosX2',
mid(SUBSTRING_INDEX(inPosX, ",", 3), length(SUBSTRING_INDEX(inPosX, ",", 2))+2, length(SUBSTRING_INDEX(inPosX, ",", 3))) as 'PosX3'
;
*/

END