#!/bin/bash

set -x
dir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
echo $dir
sudo cp $dir/update_linux_clock.timer /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start update_linux_clock.timer
