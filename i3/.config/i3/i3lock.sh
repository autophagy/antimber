#!/bin/sh
COLORS=" --insidecolor=d2d2d266 --ringcolor=d2d2d2ff --linecolor=00000000"
VERCOLORS="--insidevercolor=d2d2d266 --ringvercolor=2d2d2dff"
WRONGCOLORS="--insidewrongcolor=a8949466 --ringwrongcolor=a89494ff"
MISC="--keyhlcolor=2d2d2dff --bshlcolor=a89494ff"

IMAGE=/tmp/screen.png
LOCK=$HOME/.config/i3/lock.png
RES=$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')

#Constants
LOCK_BASE_CMD="i3lock -t -i $IMAGE $COLORS $VERCOLORS $WRONGCOLORS $MISC"
LOCK_CMD="$LOCK_BASE_CMD"

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -filter_complex "boxblur=20" -vframes 1 $IMAGE -loglevel quiet
$LOCK_CMD
rm $IMAGE
