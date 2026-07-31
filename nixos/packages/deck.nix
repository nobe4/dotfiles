{ pkgs, ... }:
pkgs.buildGoModule (attrs: {
  pname = "deck";
  version = "413201a52373d473e8561b6f636880485f995c5a";
  src = pkgs.fetchFromGitHub {
    owner = "nobe4";
    repo = "deck";
    rev = "${attrs.version}";
    hash = "sha256-3eqljf2kd4xs+oS/716vPpI2aOb1MjdMT9cszLg0phE=";
  };
  vendorHash = "sha256-1OqyA5VZT2CE3qytUw8BmMPNjQ8xji4DTWh457j6MUM=";
})
