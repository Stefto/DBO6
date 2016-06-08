CREATE PROCEDURE CALLWEBSERVICE
AS
BEGIN
    Declare @Object as Int;
    Declare @ResponseText as Varchar(8000);

    Exec sp_OACreate 'MSXML2.XMLHTTP', @Object OUT;
    Exec sp_OAMethod @Object, 'open', NULL, 'get', 'http://www.webservicex.com/globalweather.asmx/GetWeather?CityName=Eindhoven&CountryName=Netherlands','false'
    Exec sp_OAMethod @Object, 'send'
    Exec sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT
    Select @ResponseText
    Exec sp_OADestroy @Object
END
