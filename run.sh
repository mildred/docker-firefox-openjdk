#!/bin/bash

GID=$(id -g)

args=("$@")
default_bin=/usr/bin/firefox-esr

if [ "$1" = "-" ]; then
  default_bin=
  shift
  args=("$@")
elif [ $# -eq 0]; then
  args=(-P firefox-openjdk --no-remote)
fi

set -x
xhost +`hostname -s`
exec podman run --rm -ti \
  --userns=keep-id \
  --net=host \
  --pid=host \
  -e DISPLAY \
  -v "$HOME/.Xauthority:/home/developer/.Xauthority" \
  -v /tmp:/tmp \
  -v /dev/bus/usb:/dev/bus/usb \
  -v firefox-openjdk-home:/home/developer \
  firefox-openjdk \
  $default_bin "${args[@]}"
