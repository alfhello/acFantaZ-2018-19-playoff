CREATE DEFINER=`ascdphk1_admin`@`59.148.244.46` PROCEDURE `bkAllTable`(in prefixName varchar(50))
BEGIN

-- DECLARE cursor_ID INT;
DECLARE cursor_VAL VARCHAR(50);
DECLARE done INT DEFAULT FALSE;
DECLARE cursor_i CURSOR FOR SELECT TABLE_NAME FROM information_schema.tables where table_schema = 'ascdphk1_genAppDB' and left(table_name,3) = 'asc';
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
OPEN cursor_i;
read_loop: LOOP
FETCH cursor_i INTO cursor_VAL;
IF done THEN
  LEAVE read_loop;
END IF;
set @SQL = concat('create table ',prefixName,'_',cursor_VAL,' select * from ',cursor_VAL,';');
prepare stmt from @SQL;
execute stmt;
deallocate prepare stmt;
END LOOP;
CLOSE cursor_i;

SELECT TABLE_NAME FROM information_schema.tables where table_schema = 'ascdphk1_genAppDB' and left(table_name,length(prefixName)) = prefixName;

END