DROP TABLE GerelateerdNieuws;
DROP TABLE CategorieAbonnement;
DROP TABLE Reactie;
DROP TABLE Nieuwsbericht;
DROP TABLE Auteur;
DROP TABLE Categorie;
DROP TABLE MailAbonnee;


CREATE TABLE MailAbonnee
(
	id			int(10) PRIMARY KEY,
	voornaam		VARCHAR(64),
	achternaam		VARCHAR(255),
	email			VARCHAR(128),
	abonnementType 		VARCHAR(128),
	laatstVerzondenMail	int
);

CREATE TABLE Categorie
(	
	naam			VARCHAR(64) PRIMARY KEY,
	omschrijving		VARCHAR(2048)
);

CREATE TABLE Auteur
(	
	id			int(10) PRIMARY KEY,
	voornaam		VARCHAR(64),
	achternaam		VARCHAR(255),
	persbureau		VARCHAR(255),
	details			VARCHAR(2048)
);

CREATE TABLE Nieuwsbericht
(	
	id			int(10) PRIMARY KEY,
	geplaatstOp		int,
	berichtKop		VARCHAR(255),
	bericht			VARCHAR(2048),
	bronLink		VARCHAR(255),
	categorieNaam		VARCHAR(64),
	auteurId		int(10)
);

CREATE TABLE Reactie
(	
	id			int(10) PRIMARY KEY,
	naam			VARCHAR(64),
	geplaatstOp		int,
	ipAdres			VARCHAR(39),
	reactieTekst		VARCHAR(1024),
	zichtbaar		bit(1),
	nieuwsberichtId		int(10)
);

CREATE TABLE CategorieAbonnement
(	
	mailAbonneeId		int(10),
	categorieNaam		VARCHAR(64),
	PRIMARY KEY (mailAbonneeId,categorieNaam)
);

CREATE TABLE GerelateerdNieuws
(	
	nieuwsberichtId			int(10),
	gerelateerdNieuwsberichtId	int(10),
	PRIMARY KEY (nieuwsberichtId,gerelateerdNieuwsberichtId)
);