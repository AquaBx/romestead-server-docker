#!/bin/bash
set -e

source "/home/steam/server/functions.sh"

cd /home/steam/server-files
mkdir -p /home/steam/.local/share/GameAnalytics

export LD_LIBRARY_PATH="/home/steam/server-files:/home/steam/server-files/linux64:${LD_LIBRARY_PATH}"

FIFO=/tmp/romestead-stdin
mkfifo "$FIFO"
exec 3>"$FIFO"

LogAction "Starting Romestead Dedicated Server"

exec dotnet Server.dll < "$FIFO"