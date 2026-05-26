#!/bin/bash
set -e

source "/home/steam/server/functions.sh"

cd /home/steam/server-files

export LD_LIBRARY_PATH="/home/steam/server-files:/home/steam/server-files/linux64:${LD_LIBRARY_PATH}"

LogAction "Starting Romestead Dedicated Server"

exec dotnet Server.dll