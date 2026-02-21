{ pkgs, ... }:
{
  users.users.nobe4.packages = with pkgs; [
    gojq

    # Make gojq available as jq to all scripts
    (stdenv.mkDerivation {
      name = "jq";
      version = gojq.version;
      buildCommand = ''
        mkdir -p $out/bin
        ln -s ${gojq}/bin/gojq $out/bin/jq
      '';
    })

    # Doesn't support all that gojq do, but is usefull for non-json languages.
    yq-go
  ];
}
