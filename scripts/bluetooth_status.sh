#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helper.sh"

declare -a connected_devices=()

print_status() {
  connected_devices=($(bluetooth_connected))
  local status="disconnected"

  if [ "${#connected_devices[@]}" -gt 0 ]; then
    status="connected"
  fi

  echo $status
}

print_connected_device_count() {
  connected_devices=($(bluetooth_connected))
  echo ${#connected_devices[@]}
}

main() {
  local option=$1
  case "$option" in
    "")
      print_status
      ;;
    "count")
      print_connected_device_count
      ;;
  esac
}

main $@

