#/bin/bash

lastdevice=`exec dmesg | awk '/Attached/' | awk 'END  {print substr($5,2,3) sub(/]/,1)}'`

exec pumount /dev/$lastdevice
