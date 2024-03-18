.files
======

# Install

**Requirements:**
- SSH key setup with GitHub

```
curl https://raw.githubusercontent.com/nobe4/dotfiles/main/bootstrap.sh | bash
```

In case of `zsh compinit: insecure directories, run compaudit for list.`:

```
autoload -U compaudit
compaudit | xargs chmod g-w
```
