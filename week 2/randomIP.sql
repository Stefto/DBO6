    delimiter //
  
  create function randomIp() returns varchar(15)
	deterministic
  begin
  
	return concat((select floor(RAND()*255)), '.', (select floor(RAND()*255)), '.',(select floor(RAND()*255)), '.', (select floor(RAND()*255)));
  end