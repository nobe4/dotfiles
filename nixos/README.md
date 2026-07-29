# `nixos`


Component | Level of Abstraction | Configuration Method                   | Purpose
---       | ---                  | ---                                    | ---
Programs  | High                 | `programs.foo.enable = true`           | Configures software with dependencies
Packages  | Medium               | `environment.systemPackages = [ foo ]` | Installs software without full configuration
Services  | High                 | `services.foo.enable = true`           | Manages system services and daemons

# In case `/boot` is full.

On systems without a choice of boot partition (e.g. macos), it can be small
(e.g. <1G), and so cleaning versions is important.

```bash
df -h /boot

# List generations
sudo nix-env -p /nix/var/nix/profiles/system --list-generations

# Delete old ones (keep last 3):
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +3

# Rebuild boot entries:
sudo /run/current-system/bin/switch-to-configuration boot
```
