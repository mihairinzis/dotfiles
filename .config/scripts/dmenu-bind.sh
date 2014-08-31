#!/bin/bash
exe=`dmenu_path | dmenu_run -b -nb '#3f3f3f' -nf '#dcdccc' -sb '#dcdccc' -sf '#151617' -fn "-xos4-terminus-medium-r-*-*-18-*"` && eval "exec $exe"
