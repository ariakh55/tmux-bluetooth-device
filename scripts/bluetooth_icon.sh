#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helper.sh"

declare -a connected_devices=()

print_icon() {
  connected_devices=($(bluetooth_connected))
  echo ${#connected_devices[@]}

  if [ "${#connected_devices[@]}" -gt 0 ]; then
    echo "󰂱"
  else
		echo "󰂯"
  fi
  
}

main() {
	print_icon
}

main
