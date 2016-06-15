create Table weather (
		id int not null identity(1,1) Primary key,
		Location varchar(255),
		Time varchar(50),
		DewPoint varchar(100),
		Description varchar(255),
		Temperature varchar(100),
		RelativeHumidity varchar(100),
		Wind varchar(100),
		Pressure varchar(200),
		visibillity varchar(200),
		Windchill varchar(200),
		Remarks varchar(255)
);
