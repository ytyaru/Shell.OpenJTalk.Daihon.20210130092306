#!/bin/bash
Run() { # aplayだとwav以外で雑音になってしまうため、mplayerを使う
	local cmd='mplayer'
	local SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"
	"$SCRIPT_DIR/installer.sh" "$cmd"
	"$cmd" "$1"
#	IsExistCmd() { type "$1" > /dev/null 2>&1; }
#	InstallMPlayer() { sudo apt install -y mplayer; }
#	IsExistCmd mplayer || InstallMPlayer
#	mplayer "$1"
}
Run "$@"

