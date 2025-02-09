#!/bin/bash

dir='/remind'

if [[ `at -l | wc -l` -eq 0 ]]; then
  bash $dir/irc.sh "at nothing pending jobs" --notice
  exit
fi

at -l | awk '{print $1}' | xargs at -c | grep irc.sh | awk '{print $2}' | awk '{ "at -l" | getline var; print var " " $1}' | awk '{print $1",",$6,$3,$4,"("$2")",$5,":",$9}' | while read LIST;
do
  bash $dir/irc.sh "$LIST" --notice
done
bash $dir/irc.sh "" --notice
