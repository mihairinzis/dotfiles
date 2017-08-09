import json
import urllib.request
req = urllib.request.Request('http://api.openweathermap.org/data/2.5/weather?APPID=16e897b28f908604765b6e22237ca1de&q=Cluj&units=metric')
with urllib.request.urlopen(req) as response:
    result = json.loads(response.read().decode('utf-8'))
    print(str(int(result['main']['temp'])) + ' ' + result['weather'][0]['description'])
