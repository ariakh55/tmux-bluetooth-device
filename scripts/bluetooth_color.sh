#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helper.sh"

print_color() {
	local plane="$1"
	local status="$2"
  # $CURRENT_DIR/bluetooth_color_status.sh "$plane" "$status"
  echo "#[bg=colour33]"
}

main() {
	# local connected_devices=$(bluetooth_connected)
  local status="disconnected"
	local plane="$1"
  #
  # if [ "${#connected_devices[@]}" -gt 0 ]; then
  #   status="connected"
  # fi
  
	print_color "$plane" "$status"
}

main $@
