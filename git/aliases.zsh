alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcb='git checkout -b'
alias gcl='git clone'
alias gco='git checkout'
alias gcp='git checkout -'
alias gd='git diff'
alias gl='git pull'
alias gla='git lg --all'
alias glo='git lg'
alias gm='git merge'
alias gp='git push -u'
alias grbd='git stash && git checkout develop && git pull origin develop && git checkout - && git rebase develop && git stash pop'
alias grbm='git stash && git checkout master && git pull origin master && git checkout - && git rebase master && git stash pop'
alias grhh='git reset --hard HEAD'
alias gs='git status'
alias gst='git stash'
# git recreate current branch
alias grccb='current_branch="$(git rev-parse --abbrev-ref HEAD)" && git stash && git checkout master && git branch -D "$current_branch" && git checkout -b "$current_branch"'
