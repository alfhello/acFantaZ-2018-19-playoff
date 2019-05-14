CREATE DEFINER=`ascdphk1_admin`@`59.148.244.46` PROCEDURE `sp_GetOpenDate`(in inDate varchar(10), out oDate varchar(10))
BEGIN

declare ipDate varchar(10);

if (inDate = '') then 
    set ipDate = now();
else 
    set ipDate = inDate;
end if;

select ascFanta_mDate into oDate from ascFanta_Match_NBA_2018
where ascFanta_mDate > ipDate and ascFanta_mStatus = 'N' 
order by ascFanta_mDate limit 1;

END