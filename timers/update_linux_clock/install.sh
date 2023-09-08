#!/bin/bash
# https://wiki.archlinux.org/title/Systemd/Timers
# https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files
# https://www.baeldung.com/linux/kernel-buffer-add-messages

set -x
dir=$(realpath $( dirname "${BASH_SOURCE[0]}" ))
echo $dir
# sudo systemctl stop update_linux_clock.timer
sudo cp $dir/update_linux_clock* /etc/systemd/system
sudo systemctl restart update_linux_clock.timer
sudo systemctl daemon-reload
