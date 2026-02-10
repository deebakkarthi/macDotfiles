#!/usr/bin/env bash
#
# Find the first venv dir and source it


function is_venv_in_dir() {
	local dir=$1
	if [[ -d $dir/venv ]];then
		echo true
	else
		echo false
	fi
}

limit=$(dirname $HOME)
cwd=$PWD

while [[ "$cwd" != "$limit" ]]; do
	if [[ $(is_venv_in_dir $cwd) = true ]]; then
		echo "Sourcing venv/ found at $cwd/venv"
		source $cwd/venv/bin/activate
		return 0
	else
		cwd=$(dirname "$cwd")
	fi
done
echo "No venv/ found"
return 1
