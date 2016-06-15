CREATE PROCEDURE CALLWEBSERVICE
AS
BEGIN
  Declare @Object as Int;
    Declare @ResponseText as Varchar(8000);
	Declare @myXml as xml;

    Exec sp_OACreate 'MSXML2.ServerXMLHTTP', @Object OUT;
    Exec sp_OAMethod @Object, 'open', NULL, 'get', 'http://www.webservicex.com/globalweather.asmx/GetWeather?CityName=Eindhoven&CountryName=Netherlands','false'
    Exec sp_OAMethod @Object, 'send'
	EXEC sp_OAMethod @object, 'SetRequestHeader', NULL, 'Content-Type', 'text/xml; charset=utf-8'
    Exec sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT
    
	set @myXml = @ResponseText;
   set @myXml = @myXml.value('(*:string/text())[1]', 'nvarchar(max)');

 SELECT 
   @myXml.value('(./CurrentWeather/Location/text())[1]','Varchar(250)') as [Location] ,
   @myXml.value('(./CurrentWeather/Time/text())[1]','Varchar(250)') as [Time] ,
   @myXml.value('(./CurrentWeather/Wind/text())[1]','Varchar(250)') as [Wind] ,
   @myXml.value('(./CurrentWeather/Visibility/text())[1]','Varchar(250)') as [Visibility] ,
   @myXml.value('(./CurrentWeather/SkyConditions/text())[1]','Varchar(250)') as [SkyConditions] ,
   @myXml.value('(./CurrentWeather/Temperature/text())[1]','Varchar(250)') as [Temperature] ,
   @myXml.value('(./CurrentWeather/DewPoint/text())[1]','Varchar(250)') as [DewPoint] ,
   @myXml.value('(./CurrentWeather/RelativeHumidity/text())[1]','Varchar(250)') as [RelativeHumidity] ,
   @myXml.value('(./CurrentWeather/Pressure/text())[1]','Varchar(250)') as [Pressure] ,
   @myXml as xmlString;

   insert into weather (Location,Time,DewPoint,Description,Temperature, RelativeHumidity,Wind,Pressure,visibillity) values(
   @myXml.value('(./CurrentWeather/Location/text())[1]','Varchar(250)'),
   @myXml.value('(./CurrentWeather/Time/text())[1]','Varchar(250)'),
   @myXml.value('(./CurrentWeather/DewPoint/text())[1]','Varchar(250)'),
   'automatically added entry',
   @myXml.value('(./CurrentWeather/Temperature/text())[1]','Varchar(250)'),
   @myXml.value('(./CurrentWeather/RelativeHumidity/text())[1]','Varchar(250)'),
   @myXml.value('(./CurrentWeather/Wind/text())[1]','Varchar(250)'),
   @myXml.value('(./CurrentWeather/Pressure/text())[1]','Varchar(250)'),
   @myXml.value('(./CurrentWeather/Visibility/text())[1]','Varchar(250)') 
   );
    Exec sp_OADestroy @Object
END
