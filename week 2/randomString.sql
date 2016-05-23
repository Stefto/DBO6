begin
	declare randString varchar(10);
  
	set randString = concat(
  CHAR( FLOOR(65 + (RAND() * 25))),
  CHAR( FLOOR(65 + (RAND() * 25))),
  CHAR( FLOOR(65 + (RAND() * 25))),
  CHAR( FLOOR(65 + (RAND() * 25))),
  CHAR( FLOOR(65 + (RAND() * 25))),
  CHAR( FLOOR(65 + (RAND() * 25))),
  CHAR( FLOOR(65 + (RAND() * 25))),
  CHAR( FLOOR(65 + (RAND() * 25))),
  CHAR( FLOOR(65 + (RAND() * 25)))
  );
	return randString;
  end