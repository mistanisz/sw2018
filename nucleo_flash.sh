#!/bin/bash

SERIALS=`st-info --probe | grep serial | cut -c10-`

IFS=$'\n'
array=( $SERIALS )

SED1='s/^(\s*)MACAddr\[5\] = (.*?);\/\/sw2018_mac/\1MACAddr\[5\] = '
SED2=';\/\/sw2018_mac/'

# cnt=0
for s in ${array[@]}; do
#   ((cnt++))
  mid=`echo "$s" | cut -c6-7`
  sed -i -E "${SED1}0x${mid}${SED2}" 'Src/ethernetif.c'
  make GCC_PATH="/usr/bin" all
  st-flash --serial $s --format ihex write build/nucleo-f7.hex
done
