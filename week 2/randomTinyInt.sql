DELIMITER //
DROP FUNCTION IF EXISTS get_tinyint //
CREATE FUNCTION get_tinyint() RETURNS INTEGER DETERMINISTIC
RETURN floor(rand()*100)