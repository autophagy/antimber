#!/bin/sh
COLORS=" --insidecolor=d2d2d266 --ringcolor=d2d2d2ff --linecolor=00000000"
VERCOLORS="--insidevercolor=d2d2d266 --ringvercolor=2d2d2dff"
WRONGCOLORS="--insidewrongcolor=a8949466 --ringwrongcolor=a89494ff"
MISC="--keyhlcolor=2d2d2dff --bshlcolor=a89494ff"

IMAGE=$(grep --only-matching --perl-regex "(?<=file\=).*" ~/.config/nitrogen/bg-saved.cfg)

#!/bin/bash

#Constants
LOCK_BASE_CMD="i3lock -i $IMAGE $COLORS $VERCOLORS $WRONGCOLORS $MISC"
LOCK_CMD="$LOCK_BASE_CMD"

#Lock the screen:
$LOCK_CMD
