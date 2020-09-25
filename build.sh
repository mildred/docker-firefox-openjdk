#!/bin/sh
set -x
exec podman build -t firefox-openjdk .
