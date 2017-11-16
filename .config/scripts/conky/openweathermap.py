import json
from urllib.request import Request, urlopen
from urllib.parse import urlencode

params = urlencode({
    'appid':'16e897b28f908604765b6e22237ca1de',
    'q': 'Cluj-Napoca',
    'units': 'metric',
    'lang': 'ro'
})
req = Request('http://api.openweathermap.org/data/2.5/weather?' + params)
with urlopen(req) as response:
    result = json.loads(response.read().decode('utf-8'))
    print(str(int(result['main']['temp'])) + ' ' + result['weather'][0]['description'])
