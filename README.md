`.files`
========

# Install

**Requirements:**
- SSH key setup with GitHub

```shell
curl https://raw.githubusercontent.com/nobe4/dotfiles/main/bootstrap.sh | bash
```

In case of `zsh compinit: insecure directories, run compaudit for list.`:

```shell
autoload -U compaudit
compaudit | xargs chmod g-w
```

# Ubuntu keyboard setup

```shell
sudo apt-get install gnome-tweaks
```

Keyboard > Additional Layout Options > Alt & Win > Menu is mapped to Win
Then adapt the keybindings in the settings.
- Disable all
- Launcher > Search: Super+Space
- Navigation > Switch to Wspc Left: Ctrl+H
- Navigation > Switch to Wspc Right: Ctrl+I
- Screenshots > Take interactively: Launch5
