
DELIMITER //
DROP PROCEDURE IF EXISTS GenerateData2 //
CREATE PROCEDURE GenerateData2(in_db varchar(20), in_table varchar(20), in_rows int, in_debug char(1))
BEGIN
#standard variables
DECLARE col_name VARCHAR(100);
DECLARE col_type VARCHAR(100);
DECLARE col_datatype VARCHAR(100);
DECLARE col_maxlen VARCHAR(100);
DECLARE col_extra VARCHAR(100);
DECLARE col_num_precision VARCHAR(100);
DECLARE col_num_scale VARCHAR(100);
DECLARE func_query VARCHAR(1000);
DECLARE i INT;

DECLARE done INT DEFAULT 0;
DECLARE cur_datatype cursor FOR
SELECT column_name,COLUMN_TYPE,data_type,CHARACTER_MAXIMUM_LENGTH,EXTRA,NUMERIC_PRECISION,NUMERIC_SCALE FROM information_schema.columns WHERE table_name=in_table AND table_schema=in_db;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
SET func_query='';

OPEN cur_datatype;
datatype_loop: loop
	FETCH cur_datatype INTO col_name, col_type, col_datatype, col_maxlen, col_extra, col_num_precision, col_num_scale;
	#SELECT CONCAT(col_name,"-", col_type,"-", col_datatype,"-", IFNULL(col_maxlen,'NULL'),"-", IFNULL(col_extra,'NULL')) AS VALS;

	IF (done = 1) THEN
		leave datatype_loop;
	END IF;

	CASE
		WHEN col_extra='auto_increment' THEN SET func_query=concat(func_query,'NULL, ');
		WHEN col_datatype in ('int','bigint') THEN SET func_query=concat(func_query,'get_int(), ');
		WHEN col_datatype in ('varchar','char') THEN SET func_query=concat(func_query,'get_string(',ifnull(col_maxlen,0),'), ');
		WHEN col_datatype in ('tinyint') THEN SET func_query=concat(func_query,'get_tinyint(), ');
		WHEN col_datatype in ('bit') THEN SET func_query=concat(func_query, 'get_bit , ');
		WHEN col_datatype in ('datetime','timestamp') THEN SET func_query=concat(func_query,'get_datetime(), ');
		WHEN col_datatype in ('float', 'decimal') THEN SET func_query=concat(func_query,'get_float(',col_num_precision,',',col_num_scale,'), ');
		ELSE SET func_query=concat(func_query,'get_varchar(',ifnull(col_maxlen,0),'), ');
	END CASE;
end loop datatype_loop;
close cur_datatype;

SET func_query=trim(trailing ', ' FROM func_query);
SET @func_query=concat("INSERT INTO ", in_db,".",in_table," VALUES (",func_query,");");
IF in_debug='Y' THEN
	select @func_query;
END IF;
SET i=in_rows;
populate :loop
WHILE (i>0) DO
	PREPARE t_stmt FROM @func_query;
	EXECUTE t_stmt;
	SET i=i-1;
END WHILE;
LEAVE populate;
END LOOP populate;
END