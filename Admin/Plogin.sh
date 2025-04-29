#!/bin/bash
spw="CIAOYUF983WOYHFHFOD387293YDH7322782YH72378YDH723782GH287FG3HD982OG7DH72F3"

( [ -z "$*" ] || [ -n "$SSH_CLIENT_USER" ] ) && echo "
==================================================
Note:
This is a program for members from Mingzhou Chen research group
to log into the group HUBU-SLS-HPC account using PL script. 

Calling directly the program in the Shell is forbidden!

Author:  Colin Doo (Du Jinhong)
Date:    2025-04-09
Version: 2.10.4
==================================================
" && exit 1

LH=

sed -i "$ d" $LH

ipw=$1
rsig=$2

userbook=

line=$(grep $rsig $userbook | tr "," "\n")
empty=$(echo)

if [ "$ipw" = "$spw" ]; then

  if [ "$line" = "$empty" ]; then
    echo "[$(now)] [Code 2] Unregistered user. (Signature: $rsig)." >> $LH
    echo "exit 103"
    exit
  else
    uarr=($line)
    ruser=${uarr[0]}
    sig=$(echo ${uarr[1]} | sed 's/\r//')

    if [ "$sig" != "$rsig" ]; then
      echo "[$(now)] [Code 2] Unregistered user. (Signature: $rsig)." >> $LH
      echo "exit 103"
      exit
    fi
  fi
  echo "[$(now)] Log-in of $ruser from L.S. (IP: $(ssh_client_ip); TTY: $(ssh_tty))" >> $LH
  echo "export SSH_CLIENT_USER=$ruser"
else
  echo "[$(now)] [Code 1] Failed script authentication. (IP: $(ssh_client_ip))" >> $LH
  echo "exit 103"
fi
