CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetOpenDate_DTS`(out oDate varchar(10))
BEGIN

select date(ascFanta_dayStart_est) into oDate from ascFanta_DailyTimeSegment_NBA where ascFanta_rActive = 1;

END