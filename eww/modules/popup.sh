#!/usr/bin/env bash

if grep -xq "$1" ./logs/popups.log ; then
  # Popup already open, closing now
  sed -i "/^$1\$/d" logs/popups.log
  eww close "$1"
else
  # Popup wasn't open, opening now
  echo "$1" >> logs/popups.log
  if [ "$2" = true ]; then
    x=$(xdotool getmouselocation --shell | grep "X" | awk -F "=" '{print $2}')
    y=$(xdotool getmouselocation --shell | grep "Y" | awk -F "=" '{print $2}')
    offsetX=0
    offsetY=0
    number='^-*[0-9]+$'
    if [[ $3 =~ $number ]]; then
      offsetX=$3
    fi
    if [[ $4 =~ $number ]]; then
      offsetY=$4
    fi
    xFinal=$(echo "$x+$offsetX" | bc)
    yFinal=$(echo "$y+$offsetY" | bc)
    eww open "$1" --pos "${xFinal}x${yFinal}"
  else
    eww open "$1"
  fi
fi
