# /home/mihai/.nix-profile/bin/curl -s https://www.meteoromania.ro/wp-json/meteoapi/v2/starea-vremii \
#     | /home/mihai/.nix-profile/bin/jq -r '.features[] | select(.properties.nume == "CLUJ-NAPOCA")' \
#     | /home/mihai/.nix-profile/bin/jq '.properties' \
#     | /home/mihai/.nix-profile/bin/jq '{cluj: (.tempe + "°, " + .nebulozitate + ", " + .fenomen_e)}' \
#     | /home/mihai/.nix-profile/bin/jq '.cluj' \
#     | /run/current-system/sw/bin/sed 's/"//g'

# appid found on github :p
/home/mihai/.nix-profile/bin/curl 'https://api.openweathermap.org/data/2.5/onecall?lat=46.7712&lon=23.6236&exclude=daily,minutely,alerts&units=metric&appid=f1701e3880b7d049420daf94dc80af76' \
    | /home/mihai/.nix-profile/bin/jq '{cluj: "\(.current.temp)°, \(.current.weather[0].description) -> \(.hourly[1].temp)° -> \(.hourly[2].temp)°, \(.hourly[2].weather[0].description)"}' \
    | /home/mihai/.nix-profile/bin/jq '.cluj' \
    | /run/current-system/sw/bin/sed 's/"//g'
