#!/bin/bash
(for f in `ls $1/*.*`; 
do 
  EXT="${f##*.}"
  COLOR=""
  if [ "$EXT" = "out" ];then
    COLOR='\e[32m'
  else
    COLOR='\e[34m'
  fi
  #echo -e $COLOR
  echo -e "`basename $f`:\n============\n"

  #echo -e '\e[0m'
  #echo -e "\e[32m`basename "$f:\e[0m\n====\n"`" ; 
  echo -e $COLOR
  cat $f; 
  echo -e '\e[0m'
  #echo -e $COLOR
  echo "------------"; 
  #echo -e '\e[0m'
done)