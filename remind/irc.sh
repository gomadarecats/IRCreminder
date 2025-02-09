#!/bin/bash

HOST=<IRC Server hostname or IPAddress>
PORT=6667
NICK='bot'
USER='bot vls remindserver bot'
JOIN='#bot'
MSG=' :'$1''

if [[ $2 = '--notice' ]]; then
  OPT='NOTICE'
  elif [[ $2 = '--remind' ]]; then
    MSG=' :@remind '$1''
    NICK='reminder'
    USER='reminder bot remind system'
  fi

echo -e "NICK $NICK \n USER $USER \n JOIN $JOIN \n ${OPT:-PRIVMSG} $JOIN$MSG \n" | nc -w 3 $HOST $PORT
