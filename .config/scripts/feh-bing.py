import json
from urllib.request import Request, urlopen, urlretrieve
from urllib.error import URLError
from os import system

try:
    with urlopen(Request('https://bing.biturl.top/')) as response:
        result = json.loads(response.read().decode('utf-8'))
        urlretrieve(result['url'], 'wall.jpg')
    system('feh --bg-scale wall.jpg')
except URLError:
    print('Bing api down')
