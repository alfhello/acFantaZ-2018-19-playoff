CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_tempUTMain`(in gmDate varchar(15))
BEGIN

-- set @gmDate = '2019-03-07';
--
-- call sp_CopyUTRoster_2018_s2(@gmDate); -- inGmDate
-- call sp_UpDailyUTACP_2018_s2(@gmDate); -- inGmDate
-- call sp_UpUTACPRank_2018_s2(@gmDate);
-- call sp_UpUTLACPRank_2018_s2();

call sp_CopyUTRoster_2018_s2(gmDate); -- inGmDate
call sp_UpDailyUTACP_2018_s2(gmDate); -- inGmDate
call sp_UpUTACPRank_2018_s2(gmDate);
call sp_UpUTLACPRank_2018_s2();

END