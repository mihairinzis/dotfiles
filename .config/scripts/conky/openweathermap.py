import json
from urllib.request import Request, urlopen
from urllib.parse import urlencode
from urllib.error import URLError

params = urlencode({
    'appid':'16e897b28f908604765b6e22237ca1de',
    'q': 'Cluj-Napoca',
    'units': 'metric',
    'lang': 'ro'
})
req = Request('http://api.openweathermap.org/data/2.5/weather?' + params)
try:
    with urlopen(req) as response:
        result = json.loads(response.read().decode('utf-8'))
        print(str(int(result['main']['temp'])) + ' ' + result['weather'][0]['description'])
except URLError:
    print('Could not fetch the weather')
