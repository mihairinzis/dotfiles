#/bin/bash

lastlabel=`exec dmesg | awk '/Direct-Access/' | awk 'END {print $6 $7 $8}'`
lastdevice=`exec dmesg | awk '/Attached/' | awk 'END  {print substr($5,2,3) sub(/]/,1)}'`

exec pmount -w -A /dev/$lastdevice $lastlabel
