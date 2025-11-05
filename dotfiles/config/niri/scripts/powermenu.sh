#!/usr/bin/env bash

ICON_PATH="$HOME/.config/niri/assets"

shutdown="Shutdown\0icon\x1f${ICON_PATH}/power.png"
reboot="Reboot\0icon\x1f${ICON_PATH}/reboot.png"
lock="Lock Screen\0icon\x1f${ICON_PATH}/lock.png"
suspend="Suspend\0icon\x1f${ICON_PATH}/suspend.png"

selected_option=$(echo -en "$shutdown\n$reboot\n$lock\n$suspend" | rofi -dmenu -markup-rows \
    -theme-str 'window {children: [listview];} listview {lines: 4;} entry {visible: false;}')

echo "$selected_option"

if [[ -n "$selected_option" ]]; then
    case "$selected_option" in
        "Shutdown") systemctl poweroff ;;
        "Reboot") systemctl reboot ;;
        "Lock Screen") swaylock & ;;
        "Suspend") systemctl suspend ;;
    esac
fi

exit 0

