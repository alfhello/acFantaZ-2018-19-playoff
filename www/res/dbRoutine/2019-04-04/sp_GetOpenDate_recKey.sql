CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_GetOpenDate_recKey`(in inDate varchar(20), out oKey varchar(10))
BEGIN

select left(ascFanta_recordKey,10) into oKey from ascFanta_DailyTimeSegment_NBA where ascFanta_rActive = 1 and date(ascFanta_dayStart_est) = inDate;

END