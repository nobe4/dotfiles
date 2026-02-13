{ lib, pkgs, ... }:
let
  shellAliases = import ./aliases.nix {
    lib = lib;
    pkgs = pkgs;
  };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;

    setOptions = [
      # https://zsh.sourceforge.io/Doc/Release/Options.html
      "ALWAYS_TO_END"
      "INTERACTIVE_COMMENTS"
      "AUTO_CD"
      "AUTO_LIST"
      "AUTO_MENU"
      "AUTO_PUSHD"
      "COMPLETE_IN_WORD"
      "NO_BEEP"
      "PROMPT_SUBST"
      "PUSHD_IGNORE_DUPS"
      "APPEND_HISTORY"
      "EXTENDED_HISTORY"
      "HIST_EXPIRE_DUPS_FIRST"
      "HIST_FIND_NO_DUPS"
      "HIST_IGNORE_ALL_DUPS"
      "HIST_IGNORE_DUPS"
      "HIST_IGNORE_SPACE"
      "HIST_VERIFY"
      "INC_APPEND_HISTORY"
      "SHARE_HISTORY"
    ];

    shellAliases = shellAliases;
  };

  programs.bash = {
    enable = true;
    shellAliases = shellAliases;
  };
}
