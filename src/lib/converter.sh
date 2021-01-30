#!/bin/bash
Run() { # wavをmp3,ogg,flacに変換する
	local cmd='ffmpeg'
	local SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"
	"$SCRIPT_DIR/installer.sh" "$cmd"
	local input="$1"
	local output="$2"
	"$cmd" -y -i "$input" "$output"
}
Run "$@"

