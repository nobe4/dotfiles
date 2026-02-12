is_macos && {
	# Don't use rm unless you know what you're doing.
	alias rm='echo "use /bin/rm or trash"'
}

alias xs="nix-shell"

alias vi="nvim"
alias vim="nvim"
alias vst='nvim +Git now' # Run Gstatus at vim startup
alias vih='nvim +help\ ' # Jump to vim help
alias vin='nvim -Nu NONE' # Vim without config
alias vit='nvim +tj\ ' # Jump to tag
alias vidir='nvim +":normal -"'

alias gd='git difftool'
alias ga='git add'
alias gb='git branch'
alias gbm='git branch -M'
alias gc='git commit'
alias gl='git pull'
alias glo='git lg'
alias grhh='git reset --hard HEAD'
alias gs='git switch'
alias gpf='git push --force-with-lease'
alias gsc='git switch -c'
alias gsm='git switch "$(git main)" && git pull && git sweep'
alias gss='git status'
alias gs-='git status -'
alias gst='git stash'
alias gcb='echo "DEPRECATED stop using git checkout for creating branch: use git switch for that (alias is gsc)"'

alias dk="docker"
alias bbox="docker run -it --rm busybox"
alias dkclean="docker system prune --all --force --volumes"
alias dc="docker compose"

alias n="gh not"
alias nr="gh not --repl"
alias ns="gh not sync --verbosity 4"
alias l="sling"
alias fex='$(fzf)'
alias wspec="find . -name '*.rb' | entr sh -c 'clear && bundle exec rspec'"

is_macos && {
  alias kitty='${HOME}/Applications/kitty.app/Contents/MacOS/kitty'
}

alias todo="rg -i todo"


alias x509='openssl x509 -text -noout'               # That's what I use all the time
alias re='exec zsh'                                  # Reload .zshrc
alias als='alias | grep'                             # Search through aliases
alias reverse-link='find -L /dir/to/start -samefile' # Find what is linked to a file
alias ls='ls --color=auto'
alias ll='ls -la'
alias p8='ping -v 8.8.8.8'                           # Ping 8.8.8.8
alias pg='ps aux | grep'                             # ps and grep easily
alias kk='killall'                                   # Quicker kill all
alias hmac='openssl rand -hex 32'
alias tmp='(cd `mktemp -d` && $SHELL --login)'

alias gdb='gdb -q' # Silent GDB

# ref: http://thexploit.com/secdev/turning-off-buffer-overflow-protections-in-gcc/
alias gccunsafe='gcc -fno-stack-protector -D_FORTIFY_SOURCE=0'

is_macos && {
  # Mac Catalina is breaking everything, thanks Tim Apple.
  # from https://www.kvraudio.com/forum/viewtopic.php?t=530824&start=15
  alias unlockvst='xattr -d com.apple.quarantine'
}

alias gpg='GPG_TTY="$(tty)" gpg'


