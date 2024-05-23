#!/bin/sh
set -eux

if [ $# -ne 1 ]; then
    echo "usage: restore <FILE>"
    exit 1
fi

FILE=${1##*/}
BIN_PATH="/usr/local/bin/$FILE"

if [ -f "$BIN_PATH" ]; then
  mv -iv "$BIN_PATH.old" "$BIN_PATH"
elif [ -e "$BIN_PATH" ]; then
  echo "error: non regular file at $BIN_PATH" >&2
  exit 1
fi
chmod a+x "$BIN_PATH"
