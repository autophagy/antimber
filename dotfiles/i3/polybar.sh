#!/bin/sh

# Kill any polybar instances that are still running
killall -q polybar

# Sleep until there are no polybar processes left
while pgrep -x polybar >/dev/null; do sleep 1; done

# Start polybar
polybar -r statusbar &
