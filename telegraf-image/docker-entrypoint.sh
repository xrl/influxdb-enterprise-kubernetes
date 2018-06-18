#!/bin/bash

set -ex
export FULL_DISK=$(df | awk '/data/ {print $2 " " $1}' | sort -rn | head -n 1 | awk '{print $2}')
export DISK=${FULL_DISK/\/dev\//}

exec telegraf --debug
