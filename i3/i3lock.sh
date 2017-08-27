#!/bin/sh
COLORS=" --insidecolor=42424266 --ringcolor=424242ff --linecolor=00000000"
VERCOLORS="--insidevercolor=42424266 --ringvercolor=94a895ff"
WRONGCOLORS="--insidewrongcolor=a8949466 --ringwrongcolor=a89494ff"
MISC="--keyhlcolor=94a895ff --textcolor=00000000 --bshlcolor=a89494ff"

i3lock -i ~/.config/i3/i3lock_bg.png $COLORS $VERCOLORS $WRONGCOLORS $MISC
