DROP function if exists get_string;
delimiter //
CREATE FUNCTION get_string(in_strlen int) RETURNS VARCHAR(500) DETERMINISTIC
BEGIN
set @var:='';
while(in_strlen>0) do
set @var:=concat(@var,IFNULL(ELT(1+FLOOR(RAND() * 53), 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' ','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'),'Kedar'));
set in_strlen:=in_strlen-1;
end while;
RETURN @var;
END 