#!/bin/bash
OUTPUT_DIR="$HOME/Videos"

if [[ ! -d "$OUTPUT_DIR" ]]; then
    mkdir -p "$OUTPUT_DIR"
fi

screenrecording_active() {
    pgrep -x wl-screenrec >/dev/null || pgrep -x slurp >/dev/null
}

stop_screenrecording() {
    pkill -SIGTERM -x wl-screenrec

    local count=0
    while pgrep -x wl-screenrec >/dev/null && [ $count -lt 50 ]; do
        sleep 0.1
        count=$((count + 1))
    done

    if pgrep -x wl-screenrec >/dev/null; then
        pkill -9 -x wl-screenrec
        notify-send "Screen Recording Error" "Process had to be force-killed. Video may be corrupted." -u critical -t 5000
    else
        notify-send "Screen recording saved to $OUTPUT_DIR" -t 2000
    fi

    pkill -RTMIN+8 waybar
}

start_screenrecording() {
    local geometry="$1"
    local filename="$OUTPUT_DIR/recording-$(date +%Y%m%d-%H%M%S).mp4"

    wl-screenrec --audio \
                 --audio-device alsa_output.pci-0000_00_1f.3.analog-stereo.monitor \
                 --geometry "$geometry" \
                 --filename "$filename" &
    pkill -RTMIN+8 waybar
}

get_monitor_geometry() {
    local monitor_info=$(niri msg --json outputs | jq -r '.[] | .logical')
    local monitor_x=$(echo "$monitor_info" | jq -r '.x')
    local monitor_y=$(echo "$monitor_info" | jq -r '.y')
    local monitor_width=$(echo "$monitor_info" | jq -r '.width')
    local monitor_height=$(echo "$monitor_info" | jq -r '.height')

    echo "${monitor_x},${monitor_y} ${monitor_width}x${monitor_height}"
}

get_region_geometry() {
    local geometry=$(slurp)
    if [ -z "$geometry" ]; then
        return 1
    fi

    local monitor_info=$(niri msg --json outputs | jq -r '.[] | .logical')
    local monitor_x=$(echo "$monitor_info" | jq -r '.x')
    local monitor_y=$(echo "$monitor_info" | jq -r '.y')
    local monitor_width=$(echo "$monitor_info" | jq -r '.width')
    local monitor_height=$(echo "$monitor_info" | jq -r '.height')

    local region_x=$(echo "$geometry" | cut -d' ' -f1 | cut -d',' -f1)
    local region_y=$(echo "$geometry" | cut -d' ' -f1 | cut -d',' -f2)
    local region_width=$(echo "$geometry" | cut -d' ' -f2 | cut -d'x' -f1)
    local region_height=$(echo "$geometry" | cut -d' ' -f2 | cut -d'x' -f2)

    local max_x=$((monitor_x + monitor_width))
    local max_y=$((monitor_y + monitor_height))

    if [ $((region_x + region_width)) -gt $max_x ]; then
        region_width=$((max_x - region_x))
    fi
    if [ $((region_y + region_height)) -gt $max_y ]; then
        region_height=$((max_y - region_y))
    fi

    echo "${region_x},${region_y} ${region_width}x${region_height}"
}

if screenrecording_active; then
    if pgrep -x slurp >/dev/null; then
        exit 0
    else
        stop_screenrecording
    fi
elif [[ "$1" == "region" ]]; then
    if geometry=$(get_region_geometry); then
        start_screenrecording "$geometry"
    fi
else
    geometry=$(get_monitor_geometry)
    start_screenrecording "$geometry"
fi
