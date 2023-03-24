#!/bin/sh
echo -ne '\033c\033]0;JumpingJack\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/JumpingJack.x86_64" "$@"
