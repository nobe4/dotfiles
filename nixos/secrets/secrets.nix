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
  "vangelis-drop-htpasswd.age".publicKeys = [
    keys.nobe4_verdi
    keys.nobe4_vangelis
  ];
  "vangelis-linote-htpasswd.age".publicKeys = [
    keys.nobe4_verdi
    keys.nobe4_vangelis
  ];
  "vangelis-lisail-htpasswd-admin.age".publicKeys = [
    keys.nobe4_verdi
    keys.nobe4_vangelis
  ];
  "vangelis-lisail-htpasswd-alpha.age".publicKeys = [
    keys.nobe4_verdi
    keys.nobe4_vangelis
  ];
  "wagner-slack-mark-read.age".publicKeys = [ keys.nobe4_wagner ];
}
