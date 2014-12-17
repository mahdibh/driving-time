#!/bin/bash

# arguments
origin=$1
dest=$2
yellow_threshold=$3
red_threshold=$4

# for origin and dest IDs, use http://services.my511.org/traffic/getoriginlist.aspx?token=`cat $TOKEN_FILE`

TOKEN_FILE="$HOME/.511-token"

R='\033[0m'

BGreen='\033[1;32m';
BRed='\033[1;31m'; 
BYellow='\033[1;33m';

token=`cat $TOKEN_FILE`
url="http://services.my511.org/traffic/getpathlist.aspx?token=${token}&o=${origin}&d=${dest}"

t=`curl -sSL $url | sed -e 's/.*currentTravelTime>\(.*\)<\/currentTravelTime>.*/\1/g'`
if [ $t -lt $yellow_threshold ]; then
  echo -e "${BGreen}go now : ${t}mn${R}"
elif [ $t -lt $red_threshold ]; then
  echo -e "${BYellow}better hurry up before it gets worse : ${t}mn${R}"
else
  echo -e "${BRed}not worth it ! ${t}mn${R}"
fi 
