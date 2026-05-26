#!/bin/bash

export LINE='\n'
export RESET='\033[0m'
export WhiteText='\033[0;37m'
export RedBoldText='\033[1;31m'
export GreenBoldText='\033[1;32m'
export YellowBoldText='\033[1;33m'
export CyanBoldText='\033[1;36m'

LogInfo() {
  Log "$1" "$WhiteText"
}
LogWarn() {
  Log "$1" "$YellowBoldText"
}
LogError() {
  Log "$1" "$RedBoldText"
}
LogSuccess() {
  Log "$1" "$GreenBoldText"
}
LogAction() {
  Log "$1" "$CyanBoldText" "====" "===="
}
Log() {
  local message="$1"
  local color="$2"
  local prefix="$3"
  local suffix="$4"

  printf "$color%s$RESET$LINE" "$prefix$message$suffix"
}

write_config() {
  cat > /home/steam/server-files/config.json <<EOF
{
  "AutoStartWorldName": "${AUTO_START_WORLD_NAME:-}",
  "AutoCreateAndLoadWorld": ${AUTO_CREATE_AND_LOAD_WORLD:-false},
  "AutoCreateWorldSize": ${AUTO_CREATE_WORLD_SIZE:-1},
  "AutoCreateWorldSeed": ${AUTO_CREATE_WORLD_SEED:-null},
  "Password": ${PASSWORD:-null},
  "Port": ${PORT:-8050},
  "MaxPlayers": ${MAX_PLAYERS:-8},
  "EnableCheats": ${ENABLE_CHEATS:-false}
}
EOF

  LogSuccess "Wrote /home/steam/server-files/config.json"
}

install() {
  LogAction "Starting server install"
  LogInfo "Installing Romestead Dedicated Server"

  /depotdownloader/DepotDownloader \
    -app 4763510 \
    -dir /home/steam/server-files \
    -validate \
    -username anonymous

  LogSuccess "Server install complete"
}
