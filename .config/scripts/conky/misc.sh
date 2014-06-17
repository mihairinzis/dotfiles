#/bin/bash

# if internet is available show:
# gmail unread messages count
# current weather
# if ping -c 1 -w 5 www.google.com > /dev/null;then
    echo internet_available > $PWD/.internet.log

    # if [ $mails -eq 0 ]; then
    #     mailstring='gmail:${color0}'$mails'${color}'
    # else
    #     mailstring='gmail:${color1}'$mails'${color}'
    # fi

    weather=`exec curl --connect-timeout 10 --silent "http://weather.yahooapis.com/forecastrss?w=$1&u=c"| sed -e '/C<BR\|Low/!d; s/<.*>//'|sed 'N;s/\n/ /;'|sed 'N;s/\n/ /;'|tr '[A-Z]' '[a-z]'`
    weatherstring='cluj:${color0}'$weather'${color}'
    echo cluj:$weather
# else
#     echo internet_unavailable > $PWD/.internet.log
#     # else show:
#     # root filesystem occupied % space
#     rootperc=`exec df -H | awk '/rootfs/' | awk '{print $5}'`
#     #homeperc=`exec df -H | awk '/home/' | awk '{print $5}'`

#     if [ ${rootperc%?} -lt 50 ]; then
#         rootpercstring='disk:${color0}'$rootperc'${color}'
#     else
#         rootpercstring='disk:${color1}'$rootperc'${color}'
#     fi
#     echo $rootpercstring
# fi
