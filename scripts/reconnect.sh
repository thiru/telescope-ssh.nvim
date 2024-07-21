#!/bin/sh

# Connect to host given by $1 and automatically reconnect if exit code of ssh command is non-zero.
# Sleep for 1 second before attempting reconnect unless $2 is provided.

if [ $# -lt 1 ]; then
  echo "Usage: reconnect.sh <HOST> [<RECONNECT SLEEP>]"
  echo ""
  exit 1
fi

SLEEP=${2:-1}

BASEDIR=$(dirname "$0")
SCRIPT_NAME=$(basename "$0")
SCRIPT_PATH="$BASEDIR/$SCRIPT_NAME"

ssh "$1"
EXIT_CODE=$?

if [ ${EXIT_CODE} != 0 ]; then
  echo "[telescope-ssh] Disconnected from $1 (exit code $EXIT_CODE). Reconnecting in $SLEEP second(s)..."
  sleep "$SLEEP"
  "$SCRIPT_PATH" "$1"
fi
