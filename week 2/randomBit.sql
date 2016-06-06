DROP function if exists get_bit;
delimiter //
CREATE FUNCTION get_bit() RETURNS bit DETERMINISTIC
BEGIN
RETURN select convert(bit, round(1*rand(),0));
END 