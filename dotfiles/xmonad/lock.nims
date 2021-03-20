#!/usr/bin/env -S nim --hints:off

import os, strformat

mode = ScriptMode.Silent

task lock, "Lock the screen.":
  const
    colours = "--insidecolor=d2d2d266 --ringcolor=d2d2d2ff --linecolor=00000000"
    vercolours = "--insidevercolor=d2d2d266 --ringvercolor=2d2d2dff"
    wrongcolours = "--insidewrongcolor=a8949466 --ringwrongcolor=a89494ff"
    misccolours = "--keyhlcolor=2d2d2dff --bshlcolor=a89494ff"

    image = "/tmp/screen.png"
    lock = getHomeDir() / ".config/i3/lock.png"

    res = gorge r"xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/'"

  exec &"ffmpeg -f x11grab -video_size {res} -y -i $DISPLAY -filter_complex 'boxblur=20' -vframes 1 {image} -loglevel quiet"
  exec &"i3lock -t -i {image} {colours} {vercolours} {wrongcolours} {misccolours}"

  rmFile image
