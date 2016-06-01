DELIMITER //
DROP FUNCTION IF EXISTS get_float //
CREATE FUNCTION get_float(in_precision int, in_scale int) RETURNS VARCHAR(100) DETERMINISTIC
RETURN round(rand()*pow(10,(in_precision-in_scale)),in_scale)