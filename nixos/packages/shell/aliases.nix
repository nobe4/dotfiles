{ lib, pkgs, ... }:
{
  "ls" = "ls --color=auto";
  "ll" = "ls -la";

  "vi" = "nvim";
  "vim" = "nvim";
  "vst" = "nvim +Git now"; # Run Gstatus at vim startup
  "vih" = "nvim +help\ "; # Jump to vim help
  "vin" = "nvim -Nu NONE"; # Vim without config;
  "vit" = "nvim +tj\ "; # Jump to tag
  "vidir" = "nvim +':normal -'";

  "gd" = "git difftool";
  "ga" = "git add";
  "gb" = "git branch";
  "gbm" = "git branch -M";
  "gc" = "git commit";
  "gl" = "git pull";
  "glo" = "git lg";
  "grhh" = "git reset --hard HEAD";
  "gs" = "git switch";
  "gpf" = "git push --force-with-lease";
  "gsc" = "git switch -c";
  "gsm" = "git switch \"$(git main)\" && git pull && git sweep";
  "gss" = "git status";
  "gs-" = "git status -";
  "gst" = "git stash";

  "dk" = "docker";
  "bbox" = "docker run -it --rm busybox";
  "dkclean" = "docker system prune --all --force --volumes";
  "dc" = "docker compose";

  "n" = "gh not";
  "nr" = "gh not --repl";
  "ns" = "gh not sync --verbosity 4";

  "l" = "sling";
  "fex" = "$(fzf)";
  "wspec" = "find . -name '*.rb' | entr sh -c 'clear && bundle exec rspec'";

  "xs" = "nix-shell";
  "todo" = "rg -i todo";
  "x509" = "openssl x509 -text -noout";
  "als" = "alias | grep"; # Search through aliases

  "reverse-link" = "find -L /dir/to/start -samefile"; # Find what is linked to a file

  "p8" = "ping -v 8.8.8.8";
  "pg" = "ps aux | grep"; # ps and grep easily
  "kk" = "killall"; # Quicker kill all
  "hmac" = "openssl rand -hex 32";
  "tmp" = "(cd `mktemp -d` && $SHELL --login)";
  "gdb" = "gdb -q"; # Silent GDB

  # ref: http://thexploit.com/secdev/turning-off-buffer-overflow-protections-in-gcc/;
  "gccunsafe" = "gcc -fno-stack-protector -D_FORTIFY_SOURCE=0";
  "gpg" = "GPG_TTY=\"$(tty)\" gpg";
}
// lib.optionalAttrs pkgs.stdenv.isDarwin {
  "kitty" = "$HOME/Applications/kitty.app/Contents/MacOS/kitty";

  # Don't use rm unless you know what you're doing.;
  "rm" = "echo 'use /bin/rm or trash'";

  # Mac Catalina is breaking everything, thanks Tim Apple.;
  # from https://www.kvraudio.com/forum/viewtopic.php?t=530824&start=15;
  "unlockvst" = "xattr -d com.apple.quarantine";
}
