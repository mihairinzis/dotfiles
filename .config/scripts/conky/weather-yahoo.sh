#/bin/bash

if ping -c 1 -w 5 www.google.com > /dev/null;then
    weather=`exec curl --connect-timeout 10 --silent "http://weather.yahooapis.com/forecastrss?w=$1&u=c"| sed -e '/C<BR\|Low/!d; s/<.*>//'|sed 'N;s/\n/ /;'|sed 'N;s/\n/ /;'|tr '[A-Z]' '[a-z]'`;
    echo cluj:$weather;
fi
