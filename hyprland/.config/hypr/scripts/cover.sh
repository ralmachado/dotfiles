#!/bin/bash

if [[ $(playerctl -p mpd status) == "Playing" ]]; then
  file=$(playerctl -p mpd metadata mpris:artUrl | cut -c8-)
  cover=${file%.jpg}.png
  if [[ ! -f $cover ]]; then
    find /tmp -maxdepth 1 -name 'cover*.png' -delete
    magick $file -resize 200 $cover
  fi
  echo $cover
elif [[ $(playerctl -p YoutubeMusic status) == "Playing" ]]; then
  artUrl=$(playerctl -p YoutubeMusic metadata mpris:artUrl)
  url=$(playerctl -p YoutubeMusic metadata xesam:url)
  file="/tmp/cover${url#*?v=}"
  cover=${file}.png
  if [[ ! -f $cover ]]; then
    find /tmp -maxdepth 1 -name 'cover*.png' -delete
    wget -qO $file $artUrl
    magick "$file" -resize 200 "$cover"
  fi
  echo $cover
else
  find /tmp -maxdepth 1 -name 'cover*.png' -delete
  echo "/dev/null"
fi
