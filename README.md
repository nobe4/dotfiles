# dotfiles

Kittens and stuff.

# Install

```
git clone git@github.com:nobe4/dotfiles.git
git submodule update --init
chsh -s $(which zsh)
```

In case of `zsh compinit: insecure directories, run compaudit for list.`:

```
autoload -U compaudit
compaudit | xargs chmod g-w
```
