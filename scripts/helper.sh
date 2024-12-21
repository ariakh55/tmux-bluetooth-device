#!/usr/bin/env bash

BLUEMAN="bluetoothctl "
BLUEMAN_DEVICES_CMD="$BLUEMAN devices"

BLUE_DEVICE_INFO="$BLUEMAN info"

declare -A bluetooth_devices
declare -a bluetooth_device_address

set_devices() {
  while IFS= read -r line; do
    dev_address=$(echo "$line" | awk '{print $2}')
    dev_name=$(echo "$line" | cut -d ' ' -f3-)

    bluetooth_devices["$dev_address"]="$dev_name"
    bluetooth_device_address+=("$dev_address")
  done < <($BLUEMAN_DEVICES_CMD)
}

get_device_info() {
  local dev_addr=$1
  
  echo $($BLUE_DEVICE_INFO $dev_addr)
}

is_device_connected() {
  local dev_addr=$1
  if [ -z $dev_addr ]; then
    echo "No device address found! please use set_devices function before calling this function"
    exit 1
  fi

  local dev_info=$(get_device_info $dev_addr | sed -E 's/.*(Connected): (yes|no).*/\2/')
  if [ "$dev_info" = "yes" ];then
    echo true
  else
    echo false
  fi
}

bluetooth_connected() {
  set_devices

  declare -a connected_devices

  for blue_addr in ${bluetooth_device_address[@]}; do
    if [ $(is_device_connected $blue_addr) == true ]; then
      echo "$blue_addr"
      connected_devices+=("$blue_addr")
    fi
  done
}


