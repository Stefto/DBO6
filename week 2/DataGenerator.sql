  delimiter //
  
  create Procedure DataGenerator()
	deterministic
  begin
  declare i int default 1;
  
  while i < 6 do
	Insert Into Categorie values (concat('cat ' , i , ' ' , (SELECT randomString())),(SELECT randomString()));
    SET i = i + 1;
  end while;
  SET i = 1;
  
  while i < 11 do
	INSERT Into MailAbonnee values (i,(SELECT randomString()),(SELECT randomString()), concat((SELECT randomString()), '@' ,(SELECT randomString()), '.com'),(SELECT randomString()),(SELECT randomInt()));
	INSERT Into Auteur values (i,(SELECT randomString()),(SELECT randomString()),(SELECT randomString()), (SELECT randomString()));
	Insert Into CategorieAbonnement values (i, (SELECT naam FROM Categorie ORDER BY RAND() LIMIT 1));
	INSERT into Nieuwsbericht values(i,randomInt(), concat('Breaking! ', (SELECT randomString())),(SELECT randomString()),concat('www.', (SELECT randomString()), '.com'), (SELECT naam FROM Categorie ORDER BY RAND() LIMIT 1),i);
	SET i = i + 1;
  end while;  
  SET i = 1;
  
  while i < 101 do
	insert into Reactie values(i,(SELECT randomString()),(SELECT randomInt()),(SELECT randomIp()),(SELECT randomString()),1,(SELECT id FROM Nieuwsbericht ORDER BY RAND() LIMIT 1));
	SET i = i + 1;
  end while;
  
  end;