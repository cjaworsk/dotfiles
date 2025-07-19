#!/bin/bash
echo "Listener called at $(date)" >>/tmp/eww-test-listener.log
eww update workspace_buttons="(box (button :onclick \"echo ok\" \"●\"))"
sleep 99999
