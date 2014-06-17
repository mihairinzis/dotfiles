#!/bin/bash

export PrintQueue="/root/Dropbox/PrintQueue";

IFS=$'\n'

for PrintFile in $(/bin/ls - ${PrintQueue}) do
lpr -r ${PrintQueue}/${PrintFile};

done
