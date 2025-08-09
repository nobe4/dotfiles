#!/usr/bin/env bash
# shellcheck disable=2154

[ "${BASH_VERSION}" ] && {
	# \[...\] is needed for Bash to ignore the escape characters' width and
	# compute the correct width for the available space left.
	red="\[\e[31m\]"
	green="\[\e[32m\]"
	blue="\[\e[32m\]"
	reset="\[\e[0m\]"
	cwd="\W"

	PROMPT_COMMAND=bash_prompt
}

[ "${ZSH_VERSION}" ] && precmd() {
	red="%{${fg[red]}%}"
	green="%{${fg[green]}%}"
	blue="%{${fg[blue]}%}"
	reset="%{${reset_color}%}"
	cwd="%c"

	zsh_prompt;
}

# Initial prompt
PS1="${green}${cwd}${reset} "

bash_prompt() { PS1="$(prompt)"; }

zsh_prompt() {
	# shellcheck disable=SC2317
	prompt_on_load_callback() {
		# Gets the new prompt value from the "$(prompt)" call.
		PS1="$(<&"$1")"

		zle reset-prompt
		zle -F "$1" # clean handlers
	}

	# Run the slow prompt function defined below
	exec {FD}< <(prompt)

	# On result, call the callback
	zle -F $FD prompt_on_load_callback
}


# Additional details
prompt(){
	# shellcheck disable=1087
	p="${green}${cwd}"

	branch="$( (git symbolic-ref -q HEAD --short || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null | xargs)"
	if [ -n "$branch" ]; then

		stash_count="$(git stash list 2> /dev/null | wc -l | tr -d ' ')"
		[ "${stash_count}" = "0" ] && stash_count=""

		git update-index --refresh >/dev/null
		if ! git diff-index --no-ext-diff --quiet --exit-code HEAD -- 2> /dev/null; then
			dirty="*"
		fi

		p="${p}${red}${branch}${stash_count}${dirty}"
	fi

	[ -n "$RBENV_SHELL" ] && p="${p}${blue}rbenv"
	[ -n "$NODENV_SHELL" ] && p="${p}${blue}nodenv"
	[ -n "$PIPENV_ACTIVE" ] && p="${p}${blue}pipenv"
	[ -n "$VIRTUAL_ENV_PROMPT" ] && p="${p}${blue}${VIRTUAL_ENV_PROMPT}"

	echo -n "${p}${reset} "
}
