let
  nobe4_verdi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkBqUZ30Oh8l+Ifpb9ibWG4brDeC1a3cplV+h3e6/Ba nobe4@verdi";
  root_bach = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpj14KCcnBYuGpZpZJVicAF841Q8lDaq25mUsY6fnlP root@bach";
in
{
  "wifi-nwf-psk.age".publicKeys = [
    nobe4_verdi
    root_bach
  ];
  "bach-nobe4-password.age".publicKeys = [
    nobe4_verdi
    root_bach
  ];
}
