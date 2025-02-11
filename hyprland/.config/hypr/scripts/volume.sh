#!/bin/bash
# changeVolume


if [[ "$@" == "mic" ]]; then
  if command -v swayosd-client; then
    swayosd-client --input-volume mute-toggle
  else
    msgTag="changeMicVolume"
    wpctl set-mute @DEFAULT_SOURCE@ toggle

    mute="$(wpctl get-volume @DEFAULT_SOURCE@ | awk '{print $3}')"
    if [[ ! -z $mute ]]; then
      dunstify -a "changeVolume" -u low -i mic-volume-muted -h string:x-dunst-stack-tag:$msgTag "Mic muted"
    else
      dunstify -a "changeVolume" -u low -i mic-volume-muted -h string:x-dunst-stack-tag:$msgTag "Mic unmuted"
    fi
  fi
else
  msgTag="changeVolume"
  if [[ "$@" == "mute" ]]; then
    if command -v swayosd-client; then
      swayosd-client --output-volume mute-toggle
      exit
    fi
    wpctl set-mute @DEFAULT_SINK@ toggle > /dev/null
  else
    if command -v swayosd-client; then
      swayosd-client --output-volume "$@"
    else
      wpctl set-volume @DEFAULT_SINK@ "${@:1:1}%${@:0:1}" > /dev/null

      # Query amixer for the current volume and whether or not the speaker is muted
      volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')"
      mute="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')"
      
      if [[ ! -z $mute ]]; then
          # Show the sound muted notification
          dunstify -a "changeVolume" -u low -h string:x-dunst-stack-tag:$msgTag "Volume muted" 
      else
          # Show the volume notification
          dunstify -a "changeVolume" -u low  -h string:x-dunst-stack-tag:$msgTag \
          -h int:value:"$volume" "Volume: ${volume}%"
      fi

    fi
    # Play the volume changed sound
    canberra-gtk-play -i audio-volume-change -d "changeVolume"
  fi
fi

