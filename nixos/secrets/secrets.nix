let
  keys = import ../packages/ssh_keys.nix;
in
{
  "wifi-nwf-psk.age".publicKeys = [
    keys.nobe4_verdi
    keys.root_bach
  ];
  "bach-nobe4-password.age".publicKeys = [
    keys.nobe4_verdi
    keys.root_bach
  ];
}
