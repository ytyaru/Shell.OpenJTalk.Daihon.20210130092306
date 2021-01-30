#!/bin/bash
Run() { # ファイルを出力したあとに読み上げる。
	Help() {
		local this_path="$(realpath "${BASH_SOURCE:-0}")"
		local this="$(basename "$this_path")"
		cat <<-EOS
			台本を読み上げます。
			Usage: $this [options] PATH
			Options:
			  -s  音声ファイルの作成をスキップする
			台本:
			  TSVファイルです。以下のような構成にしてください。
			  1列目: VoiceID
			  2列目: 台詞
			Examples:
			  $this daihon.tsv
			  $this -s daihon.tsv
		EOS
	}
	local OPT_IS_SKIP_MAKE_WAV=0
	while getopts ':sh' OPT; do
		case $OPT in
		s) OPT_IS_SKIP_MAKE_WAV=1 ;;
		h) Help; return;;
		:) echo  "[ERROR] 値が必要なオプションに値が指定されていません。"; Help; return;;   # 
		\?) echo "[ERROR] 未定義のオプションです。"; Help; return;;
		esac
	done
	shift $(($OPTIND - 1))
	local SCRIPT_DIR="$(cd $(dirname $0); pwd)"
	local talker="$SCRIPT_DIR/lib/jtalk.sh"
	local daihon_path="${1:-$SCRIPT_DIR/daihon.tsv}"
	IFS=$'\n'
	local daihon=($(cat $daihon_path))
	MakeMp3() {
		[ 1 -eq $OPT_IS_SKIP_MAKE_WAV ] && return
		MakeWavToMp3() {
			$talker -S -o "${index}.wav" -v "$voice" "$serif" > /dev/null
			ffmpeg -y -i "${index}.wav" "${index}.mp3" &>/dev/null
			rm -f "${index}.wav"
		}
		for index in "${!daihon[@]}"; do
			local line="${daihon[$index]}"
			local voice="$(echo -e "$line" | cut -f1)"
			local serif="$(echo -e "$line" | cut -f2)"
			echo -e "$index\t$voice\t$serif"
			MakeWavToMp3 &
		done
		wait
	}
	Play() {
		for index in "${!daihon[@]}"; do
			echo "play $index"
			mplayer "${index}.mp3" &>/dev/null
		done
	}
	MakeMp3
	Play
}
Run "$@"

