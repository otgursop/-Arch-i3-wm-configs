#!/usr/bin/bash

# If ipc enabled 
polybar-msg cmd quit
# Nuclear option
# killall -q polybar

# Launch bar
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar

echo "Bar launched..."
