#!/usr/bin/env bash

[ "${BASH_VERSION}" ] && {
	# \[...\] is needed for Bash to ignore the escape characters' width and
	# compute the correct width for the available space left.
	red="\[\e[31m\]"
	green="\[\e[32m\]"
	yellow="\[\e[33m\]"
	blue="\[\e[34m\]"
	reset="\[\e[0m\]"
	cwd="\W"

	PROMPT_COMMAND=bash_prompt
}

[ "${ZSH_VERSION}" ] && {
	red="%F{1}"
	green="%F{2}"
	yellow="%F{3}"
	blue="%F{4}"
	reset="%f"
	cwd="%c"

	typeset -a precmd_functions
	precmd_functions+=(prompt_precmd)
}

# Initial prompt
PS1="${green}${cwd}${reset} "

bash_prompt() { PS1="$(prompt)"; }

prompt_on_load_callback() {
	# Gets the new prompt value from the "$(prompt)" call.
	# shellcheck disable=2034
	PROMPT="$(<&"$1")"

	zle reset-prompt
	zle -F "$1"
}

# This precmd will run at PROMPT display time.
prompt_precmd() {
	# run the slow prompt method
	exec {FD}< <(prompt)
	# On result, call the callback
	zle -F "$FD" prompt_on_load_callback
}

# Additional details
prompt() {
	prompt=""

	# In a worktree the cwd is the branch name, so show the repo name instead.
	dir="${cwd}"

	# In a worktree, `git-dir` and `common-dir` differ, as one is the current
	# worktree, and the other is the root dir.
	worktree_dir="$(git rev-parse --path-format=absolute --git-dir 2> /dev/null)"
	root_dir="$(git rev-parse --path-format=absolute --git-common-dir 2> /dev/null)"
	if [ -n "${worktree_dir}" ] && [ "${worktree_dir}" != "${root_dir}" ]; then
		dir="$(basename "${root_dir}")"
	fi

	# hostname is yellow, only inside SSH
	{ [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; } && prompt="${yellow}$(hostname)"

	# cwd is green
	prompt="${prompt}${green}${dir}"

	# git is red
	prompt="${prompt}${red}"

	if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "false" ]; then
		prompt="${prompt}bare"
	else
		branch="$( (git symbolic-ref -q HEAD --short || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null | xargs)"
		if [ -n "$branch" ]; then

			stash_count="$(git stash list 2> /dev/null | wc -l | tr -d ' ')"
			[ "${stash_count}" = "0" ] && stash_count=""

			git update-index --refresh > /dev/null 2>&1
			if ! git diff-index --no-ext-diff --quiet --exit-code HEAD -- 2> /dev/null; then
				dirty="*"
			fi

			prompt="${prompt}${branch}${stash_count}${dirty}"
		fi
	fi

	# env is blue
	[ -n "${IN_NIX_SHELL:-}" ] && prompt="${prompt}${blue}nix"
	[ -n "$RBENV_SHELL" ] && prompt="${prompt}${blue}rbenv"
	[ -n "$NODENV_SHELL" ] && prompt="${prompt}${blue}nodenv"
	[ -n "$PIPENV_ACTIVE" ] && prompt="${prompt}${blue}pipenv"
	[ -n "$VIRTUAL_ENV_PROMPT" ] && prompt="${prompt}${blue}${VIRTUAL_ENV_PROMPT}"

	printf '%s' "${prompt}${reset} "
}
