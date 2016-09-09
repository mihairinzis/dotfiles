import json
import urllib.request
req = urllib.request.Request('http://api.openweathermap.org/data/2.5/weather?APPID=f5296d5dee9921516fddf8c2ac41e794&q=Cluj&units=metric')
with urllib.request.urlopen(req) as response:
    result = json.loads(response.readall().decode('utf-8'))
    print(str(int(result['main']['temp'])) + ' ' + result['weather'][0]['description'])
