#!/bin/bash

msgTag="brightnessctl"

if command -v swayosd-client; then
  swayosd-client --brightness "$@"
else
  brightnessctl set "${@:1:1}%${@:0:1}"
  reported=$(brightnessctl get)
  bright=$((reported*100/255))
  dunstify -a "changeBrightness" -u low -h string:x-dunst-stack-tag:$msgTag -h int:value:$bright "Brightness: ${bright}%"
fi
