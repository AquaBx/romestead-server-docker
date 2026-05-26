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

install() {
  LogAction "Starting server install"
  LogInfo "Installing Romestead Dedicated Server"

  /depotdownloader/DepotDownloader \
    -app 4763510 \
    -dir /home/steam/server-files \
    -validate \

  LogSuccess "Server install complete"
}
