DELIMITER //

  create function randomInt() returns Integer
	deterministic
begin
RETURN floor(rand()*10000000;
  end