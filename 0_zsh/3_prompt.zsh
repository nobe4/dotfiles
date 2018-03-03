autoload -U colors && colors

function virtualenv_info {
	[ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function prompt_char {
	git branch >/dev/null 2>/dev/null && IS_GIT="1" && echo '±' && return
	echo '$'
}

function parse_git_branch() {
	(git symbolic-ref -q HEAD --short || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

function parse_git_dirty {
	 ! git diff-index --quiet HEAD -- && echo "*"
}

function parse_git_stash {
  local stash=`expr $(git stash list 2>/dev/null| wc -l)`
  if [ "$stash" != "0" ]
  then
    echo " $stash"
  fi
}

function git_prompt {
	git branch >/dev/null 2>/dev/null &&  echo "$(parse_git_branch)$(parse_git_stash)$(parse_git_dirty)"
}

PROMPT='\
${PR_YELLOW}%n%{$reset_color%}\
 ${PR_GREEN}%c%{$reset_color%}\
 ${PR_BLUE}$(prompt_char)%{$reset_color%}\
 ${PR_RED}$(git_prompt)%{$reset_color%}\
 '
