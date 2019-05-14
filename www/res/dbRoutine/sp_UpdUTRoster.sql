CREATE DEFINER=`ascdphk1_admin`@`59.148.244.46` PROCEDURE `sp_UpdUTRoster`(in inFmPos varchar(50), in inPID varchar(1000), in ToPos varchar(50))
BEGIN

declare istr varchar(10);
declare ostr varchar(10);
-- set istr = concat("'",replace(inFmPos,",","','"),"'");
set istr = inFmPos;

if locate(',',istr) > 0 then
    set ostr = concat("1",substring_index(istr,',',1));
    set istr = replace(istr,ostr,'');
    if locate(',',istr) > 0 then
        set ostr = '22';
    else
        set ostr = concat('f1',istr);
    end if;
else
    set ostr = inFmPos;
end if ;

select ostr;

END