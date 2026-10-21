#!/bin/bash
set -e

source "/home/steam/server/functions.sh"

cd /home/steam/server-files
mkdir -p /home/steam/.local/share/GameAnalytics

export LD_LIBRARY_PATH="/home/steam/server-files:/home/steam/server-files/linux64:${LD_LIBRARY_PATH}"

FIFO=/tmp/romestead-stdin

LogAction "Starting Romestead Dedicated Server"

if [ "$(uname -m)" = "aarch64" ]; then
    export BOX64_DYNAREC_SAFEFLAGS=2
    export BOX64_DYNAREC_X87DOUBLE=1
    export BOX64_LOG=0
    export STRONGMEM=2
    script -qfc "box64 dotnet Server.dll" /dev/null < "$FIFO" &
else
    dotnet Server.dll < "$FIFO" &
fi

dotnet_pid=$!
exec 3>"$FIFO"

wait $dotnet_pid