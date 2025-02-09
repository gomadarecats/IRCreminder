#!/bin/bash

dir='/remind'

if [[ ${1} =~ [0-9]{4}(-|/)?[0-9]{2}(-|/)?[0-9]{2}(\s|-|_)?[0-9]{2}:?[0-9]{2} ]]; then
  time="-t `echo $1 | sed -e 's/[^(0-9|\.)]//g'`"
else
  time="$1"
fi
nohup echo "$dir/irc.sh "$2" --remind > /dev/stdout" | at $time 2>&1 | grep job | xargs -I job bash $dir/irc.sh "job" --notice
