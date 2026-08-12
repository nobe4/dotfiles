{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "xr";
  text =
    if pkgs.stdenv.isDarwin then
      "sudo darwin-rebuild switch"
    else
      # TODO: this will move to colemna eventually
      "sudo nixos-rebuild --install-bootloader switch";
}
