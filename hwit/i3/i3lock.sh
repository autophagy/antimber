#!/bin/sh
COLORS=" --insidecolor=42424266 --ringcolor=424242ff --linecolor=00000000"
VERCOLORS="--insidevercolor=42424266 --ringvercolor=94a895ff"
WRONGCOLORS="--insidewrongcolor=a8949466 --ringwrongcolor=a89494ff"
MISC="--keyhlcolor=94a895ff --textcolor=00000000 --bshlcolor=a89494ff"

IMAGE=~/.config/i3/tmp.png
ICON_WHITE=~/.config/i3/i3lock_icon_white.png
ICON_BLACK=~/.config/i3/i3lock_icon_black.png
IMAGE_SAMPLE=~/.config/i3/tmp-2.png


scrot $IMAGE
convert $IMAGE -scale 10% -modulate 100,50 -scale 1000% $IMAGE

monitors=$(xrandr -q | grep ' connected' | wc -l)

if [ $monitors -gt 1 ]
then
  sample=$(convert $IMAGE -gravity center -crop 250x250-1280+0 -resize 1x1 -format "%[fx:luminance]" info:)
  result=$(echo "$sample > 0.5"|bc)
  if [ $result -eq 1 ]
  then
    ICON=$ICON_BLACK
  else
    ICON=$ICON_WHITE
  fi

  convert $IMAGE $ICON -gravity center -geometry -1280+0 -composite -matte $IMAGE

  sample=$(convert $IMAGE -gravity center -crop 250x250+1280+0 -resize 1x1 -format "%[fx:luminance]" info:)
  result=$(echo "$sample > 0.5"|bc)
  if [ $result -eq 1 ]
  then
    ICON=$ICON_BLACK
  else
    ICON=$ICON_WHITE
  fi

  convert $IMAGE $ICON -gravity center -geometry +1280+0 -composite -matte $IMAGE
else
  sample=$(convert $IMAGE -gravity center -crop 250x250+0+0 -resize 1x1 -format "%[fx:luminance]" info:)
  result=$(echo "$sample > 0.5"|bc)

  if [ $result -eq 1 ]
  then
    convert $IMAGE $ICON_BLACK -gravity center -composite -matte $IMAGE
  else
    convert $IMAGE $ICON_WHITE -gravity center -composite -matte $IMAGE
  fi
fi

i3lock -i $IMAGE $COLORS $VERCOLORS $WRONGCOLORS $MISC
rm $IMAGE
