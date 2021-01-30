#!/bin/bash
Run() { # $1: インストールしたいアプリ名
	IsExistCmd() { type "$1" > /dev/null 2>&1; }
	Install() { sudo apt install -y "$1"; }
	OnceInstall() { IsExistCmd "$1" || Install "$1" }
	OnceInstall "$1"
}
Run "$@"

