#!/bin/bash

set -ex
export DATA_DISK_PATH=$(df | awk '/data/ {print $2 " " $1}' | sort -rn | head -n 1 | awk '{print $2}')
export DATA_DISK_DEV=${DATA_DISK_PATH/\/dev\//}

export WAL_DISK_PATH=$(df | awk '/wal/ {print $2 " " $1}' | sort -rn | head -n 1 | awk '{print $2}')
export WAL_DISK_DEV=${WAL_DISK_PATH/\/dev\//}

exec telegraf --debug
