#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"

set_devices

bluetooth_interpolation=(
	"\#{bluetooth_color_bg}"
	"\#{bluetooth_color_fg}"
	"\#{bluetooth_icon}"
)

bluetooth_commands=(
  "#($CURRENT_DIR/scripts/bluetooth_color.sh bg)"
  "#($CURRENT_DIR/scripts/bluetooth_color.sh fg)"
  "#($CURRENT_DIR/scripts/bluetooth_icon.sh)"
)

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

do_interpolation() {
	local all_interpolated="$1"
	for ((i=0; i<${#bluetooth_commands[@]}; i++)); do
		all_interpolated=${all_interpolated//${bluetooth_commands[$i]}/${bluetooth_commands[$i]}}
	done
	echo "$all_interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
