CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_UpUTLACPRank_2018_s2`()
BEGIN

-- DECLARE cursor_ID INT;
declare i int;
DECLARE cursor_VAL VARCHAR(50);
DECLARE done INT DEFAULT FALSE;
DECLARE cursor_i CURSOR FOR SELECT ascFanta_GroupKey FROM ascFanta_UTRoster_DailyRank_NBA_2018_s2 where ascFanta_rStatus = 'RnkCfm';
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

set i =1;
OPEN cursor_i;

read_loop: LOOP
FETCH cursor_i INTO cursor_VAL;

set i = i+1;

IF done THEN
  LEAVE read_loop;
END IF;
set @SQL = concat('update ascFanta_UTRoster_DailyRank_NBA_2018_s2 UTLRnk inner join (select a.ascFanta_TeamID, a.ascFanta_TeamName, a.ascFanta_Group, a.ascFanta_GroupKey, a.ascFanta_TACP, a.ascFanta_gmDate, 
if(ascFanta_TACP=@_last_TACP, @curRank:=@curRank,@curRank:=@_seq) as nowUTLRank, @_seq:=@_seq+1, @_last_TACP:=ascFanta_TACP
from ascFanta_UTRoster_DailyRank_NBA_2018_s2 a, (select @curRank:=1, @_seq:=1, @_last_TACP:=0) r
where ascFanta_rStatus = "RnkCfm" and ascFanta_GroupKey ="',cursor_VAL,'" order by ascFanta_TACP desc) b on 
UTLRnk.ascFanta_TeamId = b.ascFanta_TeamID and UTLRnk.ascFanta_TeamName = b.ascFanta_TeamName and UTLRnk.ascFanta_Group = b.ascFanta_Group and UTLRnk.ascFanta_GroupKey = b.ascFanta_GroupKey
set UTLRnk.ascFanta_nowUTRank = b.nowUTLRank');

prepare stmt from @SQL;
execute stmt;
deallocate prepare stmt;

END LOOP;
CLOSE cursor_i;

select i;
-- select InsRnk, UpdLRnk, mkDel, RnkCfm, sRnk;

END