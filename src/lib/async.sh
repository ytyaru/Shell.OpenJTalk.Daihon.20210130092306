#!/bin/bash
sync_wait() { # $1: 非同期実行したい関数名, $2: 期待する関数の戻り値, $3: タイムアウト秒
	local callbackfn="$1"
	local status_expected="${2:-0}"
	local timeout_s="${3:-10}"
	local elapsed_s=0
	for((; ; elapsed_s++)){
		${callbackfn}
		[[ $? -eq ${status_expected} ]] && return 0
		[[ ! ${elapsed_s} -lt ${timeout_s} ]] && break
		sleep 1
	}   
	return 1
}

