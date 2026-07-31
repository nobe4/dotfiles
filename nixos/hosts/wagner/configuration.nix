{
  config,
  pkgs,
  lib,
  ...
}:
{
  # TODO: move that to main, or remove altogether if colemna can also handle it
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
    # XXX: Need pkgs-unstable
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
    gnupg

    # TODO: deduplicate with dev.nix
    cmake
    age
    difftastic
    fd
    fzf
    gh
    glow
    go
    gojq
    htop
    moreutils
    neovim
    ripgrep
    tree
    universal-ctags
    xq
    mise
    pipenv
    pyenv
    rbenv
    nodenv
    colmena
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
    # apply the changes without logout/login
    activationScripts.postActivation.text = lib.mkAfter ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    primaryUser = "nobe4";

    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        AppleEnableMouseSwipeNavigateWithScrolls = false;
        AppleEnableSwipeNavigateWithScrolls = false;
        "com.apple.sound.beep.feedback" = 1;
        # XXX: Not working?
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
