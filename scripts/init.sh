#!/bin/bash
source "/home/steam/server/functions.sh"

LogAction "Set file permissions"

if [ -z "${PUID}" ] || [ -z "${PGID}" ]; then
    LogError "PUID and PGID not set. Please set these in the environment variables."
    exit 1
else
    usermod -o -u "${PUID}" steam
    groupmod -o -g "${PGID}" steam
fi

chown -R steam:steam /home/steam/

cat /branding

if [ "${UPDATE_ON_START:-true}" = "true" ]; then
    install
else
    LogWarn "UPDATE_ON_START is set to false, skipping server update"
fi

write_config

mkdir -p /home/steam/.local/share/GameAnalytics
mkdir -p /home/steam/.config

chown -R steam:steam /home/steam/server-files
chown -R steam:steam /home/steam/.local /home/steam/.config

exec su - steam -c "cd /home/steam/server && ./start.sh"
