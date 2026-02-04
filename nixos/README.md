# `nixos`


Component | Level of Abstraction | Configuration Method                   | Purpose
---       | ---                  | ---                                    | ---
Programs  | High                 | `programs.foo.enable = true`           | Configures software with dependencies
Packages  | Medium               | `environment.systemPackages = [ foo ]` | Installs software without full configuration
Services  | High                 | `services.foo.enable = true`           | Manages system services and daemons
