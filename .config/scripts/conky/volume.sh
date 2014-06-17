#!/bin/bash
amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "vol:${color1}mute${color}" } else { print "vol:${color0}",$2"%${color}" }}' | uniq | tr '\n' ' '
