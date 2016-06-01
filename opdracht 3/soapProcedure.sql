CREATE PROCEDURE ServiceyTalkey as
declare @obj int,
        @url VarChar(MAX),
        @response VarChar(MAX),
        @requestHeader VarChar(MAX),
        @requestBody VarChar(MAX)

SET @url = 'http://ws.cdyne.com/WeatherWS/GetCityWeatherByZIP'

SET @requestBody = '<soapenv:Envelope>
                     <soapenv:Header/>
                      <soapenv:Body>
						<GetCityWeatherByZIP xmlns="http://ws.cdyne.com/WeatherWS/">
							<ZIP>10025</ZIP>
						</GetCityWeatherByZIP>
                      </soapenv:Body>
                     </soapenv:Envelope>'

EXEC sp_OACreate 'MSXML2.ServerXMLHttp', @obj OUT
EXEC sp_OAMethod @obj, 'Open', NULL, 'GET', @url, false
EXEC sp_OAMethod @obj, 'setRequestHeader', NULL, 'Content-Type', 'text/xml;charset=UTF-8'
EXEC sp_OAMethod @obj, 'setRequestHeader', NULL, 'SOAPAction', 'POST'
EXEC sp_OAMethod @obj, 'setRequestHeader', NULL, 'Content-Length',  LEN(select @requestBody)
EXEC sp_OAMethod @obj, 'send', NULL, @requestBody
EXEC sp_OAGetProperty @obj, 'responseText', @response OUT


SELECT @response [RESPONSE]

EXEC sp_OADestroy @obj
 
 return @response
go