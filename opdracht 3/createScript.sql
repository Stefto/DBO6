create Table weather (
		id int not null identity(1,1) Primary key,
		USAState varchar(30) not null,
		weatherStation varchar(255),
		weatherID int,
		Description varchar(255),
		Temperature varchar(5),
		RelativeHumidity varchar(6),
		Wind varchar(10),
		Pressure varchar(20),
		visibillity varchar(30),
		Windchill varchar(20),
		Remarks varchar(255)
);