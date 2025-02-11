#!/bin/bash

if [[ $(playerctl status) == "Playing" ]]; then
  echo "󰝚  $(playerctl metadata xesam:title)"
  echo "  $(playerctl metadata xesam:artist)"
  echo "󰀥  $(playerctl metadata xesam:album)"
fi
