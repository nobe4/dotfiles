# TODO: how does this work accross machine?
# I should be able to just link the adequate config to XDG_CONFIG
# ln -sfv /Users/nobe4/dev/nobe4/dotfiles/nixos/hosts/brahms.nix /etc/nix-darwin/configuration.nix
{ pkgs, ... }:

{
  imports = [
    ../utils/ln-darwin.nix

    ../nix.nix
    ../dev.nix

    ../packages/system.nix
    ../users/nobe4.nix
  ];

  networking = {
    computerName = "brahms";
    hostName = "brahms";
  };

  users.users.nobe4.packages = with pkgs; [
    darwin.trash
    gnupg
  ];

  homebrew = {
    # Following https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file
    # For brew
    #     https://github.com/orgs/Homebrew/discussions/3227
    #     `sudo chown -R $(whoami) /usr/local/share/zsh/site-functions`
    #     + install brew from https://brew.sh/

    enable = true;
    casks = [
      "firefox"
      "1password"
      "1password-cli"
      "kitty"
      "notunes"
      "hammerspoon"
      "neovide"
      "qbittorrent"
    ];
  };
  ln = [
    [
      "$DOTFILE_FOLDER/hammerspoon/"
      "$HOME/.hammerspoon"
    ]
  ];

  system = {
    primaryUser = "nobe4";
    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        AppleEnableMouseSwipeNavigateWithScrolls = false;
        AppleEnableSwipeNavigateWithScrolls = false;
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
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
