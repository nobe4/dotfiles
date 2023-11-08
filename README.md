.files
======

# Install

The dotfiles folder is expected to be found at `~/.config/dotfiles`.

```
git clone --recurse-submodules git@github.com:nobe4/dotfiles.git
ln -fs ./dotfiles ~/.config/dotfiles
cd /dotfiles
./install.sh
```

In case of `zsh compinit: insecure directories, run compaudit for list.`:

```
autoload -U compaudit
compaudit | xargs chmod g-w
```
