#!/usr/bin/env zsh

unameOut="$(uname -s)"
case "${unameOut}" in
	Linux*) export IS_LINUX="1";;
	Darwin*) export IS_MACOS="1";;
	*) exit 1
esac

PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$DOTFILE_FOLDER/.yada/bin"

MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

# manually set the language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

export EDITOR='vim'

# Access the functions/* files
fpath=($DOTFILE_FOLDER/functions $fpath)
autoload -U $DOTFILE_FOLDER/functions/*(:t)

if [ -n "$IS_MACOS" ]; then
	PATH="$PATH:/Applications:~/Applications"
	. `brew --prefix`/etc/profile.d/z.sh
fi

if [ -n "$IS_LINUX" ]; then
	. $DOTFILE_FOLDER/misc/z.sh
fi

export PATH
export MANPATH
