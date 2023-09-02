#!/usr/bin/env bash

#  -p 127.0.0.1:8080:80/tcp
#  --env-file .env
#

docker run -d --name westie-dev --network host -w ${HOME} -t -i  -v /var/run/docker.sock:/var/run/docker.sock -v ${HOME}:${HOME} -v /mnt/g:/google-drive -v /mnt/wsl/projects:/projects archlinux:base-devel
