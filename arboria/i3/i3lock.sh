#!/bin/sh
COLORS=" --insidecolor=42424266 --ringcolor=424242ff --linecolor=00000000"
VERCOLORS="--insidevercolor=42424266 --ringvercolor=94a895ff"
WRONGCOLORS="--insidewrongcolor=a8949466 --ringwrongcolor=a89494ff"
MISC="--keyhlcolor=94a895ff --textcolor=00000000 --bshlcolor=a89494ff"

IMAGE=~/.config/i3/tmp.png
ICON=~/.config/i3/i3lock_icon.png
scrot $IMAGE
convert $IMAGE -scale 10% -modulate 100,50 -scale 1000% $IMAGE
convert $IMAGE $ICON -gravity center -composite -matte $IMAGE
i3lock -i $IMAGE $COLORS $VERCOLORS $WRONGCOLORS $MISC
rm $IMAGE
