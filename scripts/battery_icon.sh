#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

print_icon() {
	local status=$1
	if [ "$status" == "connected" ]; then
		echo ""
	else
    echo "󰂱"
	fi
}

main() {
	local connected_devices=$(bluetooth_connected)
  local status="disconnected"

  if [ "${#connected_devices[@]}" -gt 0 ]; then
    status="connected"
  fi
  
	print_icon "$status"
}

main
