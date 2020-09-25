#!/bin/sh
set -x
exec podman run --rm -ti --net=host -e DISPLAY -v "$HOME/.Xauthority:/home/developer/.Xauthority" firefox-openjdk /usr/bin/firefox-esr
