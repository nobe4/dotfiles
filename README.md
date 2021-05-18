# dotfiles

Kittens and stuff.

# Install

```
git clone git@github.com:nobe4/dotfiles.git
cd dotfiles
./install.sh
```

In case of `zsh compinit: insecure directories, run compaudit for list.`:

```
autoload -U compaudit
compaudit | xargs chmod g-w
```
