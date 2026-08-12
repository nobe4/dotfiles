`.files`
========

# Install

**Requirements:**
- SSH key setup with GitHub

```shell
curl https://raw.githubusercontent.com/nobe4/dotfiles/main/bootstrap.sh | bash
```

# In case nix-darwin fails, put that in `~/.zshrc`:

```bash
# Nix breaks after redeploying on macos.
# This should work as a temporary workaround.
# https://github.com/NixOS/nix/issues/3616#issuecomment-1655785404
[[ ! $(command -v nix) && -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]] && source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
```

https://github.com/NixOS/nix/issues/3616
https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
https://github.com/sorin-ionescu/prezto/issues/381#issuecomment-12800590
https://github.com/rbenv/rbenv/wiki/Unix-shell-initialization
