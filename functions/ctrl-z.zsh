#!/bin/sh

# better ctrl-z switch
# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

fancy-ctrl-z () {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER="fg"
		zle accept-line
	else
		zle push-input
		zle clear-screen
	fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
