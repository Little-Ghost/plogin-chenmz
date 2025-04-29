#!/bin/bash

echo "Making a backup version of current script..."
T=$(date +'%y-%m-%d %H:%M:%S')
tf=$(date +'%y%m%d-%H%M%S')
filename="Plogin-$tf.sh"
cp Plogin.sh Archives/$filename
echo "Filename: $filename"

if [ "$1" = "--chpw" ]; then

  OldPassword="$(sed -n '2p' Plogin.sh | tr '=' ' ' | gawk '{print $2}' | sed 's/\"//g')"
  NewPassword="$(python3 pwgen.py)"
  echo "New password: $NewPassword"

  echo "[$T] Change of Plogin password. (From: $OldPassword To: $NewPassword)" >> plogin_pw.log

  NewPasswordLine="spw=\"$NewPassword\""
  
  echo "Updating..."
  content=$(sed "2s/.*/$NewPasswordLine/" Plogin.sh)
  echo "$content" > tmp.sh
  mv tmp.sh Plogin.sh

fi

echo "Making binary..."
shc -f Plogin.sh && (rm Plogin.sh.x.c; mv Plogin.sh.x Plogin)
echo "Done."

chmod +rx Plogin
