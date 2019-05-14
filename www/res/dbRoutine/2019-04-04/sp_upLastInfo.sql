CREATE DEFINER=`ascdphk1_admin`@`218.253.202.194` PROCEDURE `sp_upLastInfo`(
in inName varchar(200), in inNKey varchar(50), in inApp varchar(50), in inAct varchar(50), in inParam varchar(800),
out outLastKey varchar(50)
)
BEGIN

update ascUser_Log set asc_Active = 0 
where (asc_LastLoginName = inName or asc_LastInNameKey = inNKey);

set outLastKey = uuid();

insert into ascUser_Log (
asc_LastLoginName, asc_LastInNameKey, asc_LastKey, asc_LastAction, asc_LastActionDT, asc_LastAPP, asc_LastIP,
asc_LastPlatform, asc_LastPlatformVer, asc_LastUUID, asc_LastMfger, asc_LastIsVM, asc_LastLocation, asc_Active
)
select inName, inNKey, outLastKey, inAct, now(), inApp,
left(inParam,length(SUBSTRING_INDEX(inParam,"|",1))) as 'clientIP', 
mid(SUBSTRING_INDEX(inParam, "|", 2), length(SUBSTRING_INDEX(inParam, "|", 1))+2, length(SUBSTRING_INDEX(inParam, "|", 2))) as 'inOS',
mid(SUBSTRING_INDEX(inParam, "|", 3), length(SUBSTRING_INDEX(inParam, "|", 2))+2, length(SUBSTRING_INDEX(inParam, "|", 3))) as 'inOSver',
mid(SUBSTRING_INDEX(inParam, "|", 4), length(SUBSTRING_INDEX(inParam, "|", 3))+2, length(SUBSTRING_INDEX(inParam, "|", 4))) as 'inUUID',
mid(SUBSTRING_INDEX(inParam, "|", 5), length(SUBSTRING_INDEX(inParam, "|", 4))+2, length(SUBSTRING_INDEX(inParam, "|", 5))) as 'inMfg',
mid(SUBSTRING_INDEX(inParam, "|", 6), length(SUBSTRING_INDEX(inParam, "|", 5))+2, length(SUBSTRING_INDEX(inParam, "|", 6))) as 'inIsVM',
mid(SUBSTRING_INDEX(inParam, "|", 7), length(SUBSTRING_INDEX(inParam, "|", 6))+2, length(SUBSTRING_INDEX(inParam, "|", 7))) as 'inLoca', 
1;

select row_count() as 'recordupdated';

END