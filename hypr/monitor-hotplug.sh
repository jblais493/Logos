#!/bin/bash

function handle {
  if [[ ${1:0:12} == "monitoradded" ]]; then
    hyprctl keyword monitor "eDP-1,1920x1200,0x1080,1"
    hyprctl keyword monitor "HDMI-A-1,2560x1080,0x0,1"
    hyprctl dispatch focusmonitor HDMI-A-1
  elif [[ ${1:0:14} == "monitorremoved" ]]; then
    hyprctl keyword monitor "eDP-1,1920x1200,0x0,1"
  fi
}

socat - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
