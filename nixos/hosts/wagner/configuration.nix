{
  config,
  pkgs,
  ...
}:
{
  # Manually load the pkgs-unstable from the channel.
  _module.args.pkgs-unstable = import <pkgs-unstable> {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfreePredicate = (import ../../utils/unfree.nix).unstable;
  };
  nixpkgs.config.allowUnfreePredicate = (import ../../utils/unfree.nix).stable;

  # NOTE: Colmena doesn't work on non-NixOS hosts, so we're stuck with this.
  environment.darwinConfig = "${config.dotfiles}/nixos/hosts/wagner/configuration.nix";

  # XXX: https://github.com/nix-darwin/nix-darwin/issues/1695
  disabledModules = [
    "programs/zsh"
    "programs/bash"
  ];

  imports = [
    # XXX: https://github.com/nix-darwin/nix-darwin/issues/1695
    ../../modules/darwin/zsh.nix
    ../../modules/darwin/bash.nix

    ../../utils/ln-darwin.nix

    ../../users/nobe4.nix

    ../../packages/shell

    ../../packages/system.nix
    # XXX
    # ../../packages/1password.nix
    ../../packages/nix
    ../../packages/dev.nix

    ./shortcuts
  ];

  networking = {
    computerName = "wagner";
    hostName = "wagner";
    localHostName = "wagner";
  };

  users.users.nobe4.packages = with pkgs; [
    darwin.trash

    # all those should go in favor of devenv and direnv
    pipenv
    pyenv
    rbenv
    nodenv

    vault
  ];

  homebrew = {
    # Following https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file
    # For brew
    #     https://github.com/orgs/Homebrew/discussions/3227
    #     `sudo chown -R $(whoami) /usr/local/share/zsh/site-functions`
    #     + install brew from https://brew.sh/

    enable = true;
    brews = [
      "pinentry-mac"
      "trash"
    ];

    # TODO: check what can be removed here
    casks = [
      "zen"
      "firefox"
      "docker-desktop"
      # XXX
      # "1password"
      # "1password-cli"
      "kitty"
      "notunes"
      "hammerspoon"
      "neovide-app"
    ];
  };

  ln = with config; [
    [
      "${dotfiles}/hammerspoon/"
      "${home}/.hammerspoon"
    ]
  ];

  system = {
    primaryUser = "nobe4";

    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;
        "com.apple.sound.beep.feedback" = 1;
        "com.apple.swipescrolldirection" = false;
      };
      controlcenter = {
        BatteryShowPercentage = true;
        Bluetooth = false;
        Display = false;
      };
      dock = {
        autohide = true;
        static-only = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        NewWindowTarget = "Home";
        ShowPathbar = true;
        _FXShowPosixPathInTitle = true;
      };
      hitoolbox = {
        AppleFnUsageType = "Change Input Source";
      };
      loginwindow = {
        DisableConsoleAccess = true;
        GuestEnabled = false;
      };
      trackpad = {
        Clicking = false;
      };
      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = 5.0;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;

      shortcuts = {
        enable = true;
        disableAll = true;

        binds = {
          Spotlight.search = {
            enabled = true;
          };
        };
      };
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
