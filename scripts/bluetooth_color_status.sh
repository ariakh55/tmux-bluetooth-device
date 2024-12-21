#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# script global variables
color_status_primary_connected=''
color_status_primary_disconnected=''
color_status_secondary_connected=''
color_status_secondary_disconnected=''

# script default variables
color_status_primary_connected_default='colour33'
color_status_primary_disconnected_default='colour7'
color_status_secondary_connected_default='colour0'
color_status_secondary_disconnected_default='colour0'

# colors are set as script global variables
get_color_status_settings() {
	color_status_primary_connected=$(get_tmux_option "@blue_color_status_primary_charged" "$color_status_primary_charged_default")
	color_status_primary_disconnected=$(get_tmux_option "@blue_color_status_primary_unknown" "$color_status_primary_unknown_default")
	color_status_secondary_connected=$(get_tmux_option "@blue_color_status_secondary_charged" "$color_status_secondary_charged_default")
	color_status_secondary_disconnected=$(get_tmux_option "@blue_color_status_secondary_unknown" "$color_status_secondary_unknown_default")
}

print_color_status() {
	local plane_primary="$1"
	local plane_secondary=""
	if [ "$plane_primary" == "bg" ]; then
		plane_secondary="fg"
	else
		plane_secondary="bg"
	fi
	local status="$2"
  if [[ $status =~ (connected) ]]; then
		printf "#[$plane_primary=$color_status_primary_connected${color_status_secondary_charged:+",$plane_secondary=$color_status_secondary_connected"}]"
	else
		printf "#[$plane_primary=$color_status_primary_disconnected${color_status_secondary_unknown:+",$plane_secondary=$color_status_secondary_disconnected"}]"
	fi
}

main() {
	local plane="$1"
	local status="$2"
  get_color_status_settings
	print_color_status "$plane" "$status"
}

main $@
