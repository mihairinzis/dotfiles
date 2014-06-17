#/bin/bash

status=`exec dropbox status | paste -s -d " "`
if [ "$status" = "Up to date" ]; then
    echo 'drop:${color0}'$status'${color}'
elif [ "$status" = "Dropbox isn't running!" ]; then
    echo 'drop:${color0}dead${color}'
else
    echo 'drop:${color1}'$status'${color}'
fi
