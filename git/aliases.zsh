alias gb='git branch'
alias gc='git commit'
alias gl='git pull'
alias gp='git push -u'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gla='git lg --all'
alias glo='git lg'
alias grhh='git reset --hard HEAD'
alias grbd='git stash && git checkout develop && git pull origin develop && git checkout - && git rebase develop && git stash pop'
alias grbm='git stash && git checkout master && git pull origin master && git checkout - && git rebase master && git stash pop'
alias gs='git status'
alias gst='git stash'
alias gcc='git checkout master && git pull origin master && git checkout'

# git recreate current branch
alias grccb='current_branch="$(git rev-parse --abbrev-ref HEAD)" && git stash && git checkout master && git branch -D "$current_branch" && git checkout -b "$current_branch"'
