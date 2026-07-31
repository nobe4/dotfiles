{ pkgs }:
let
  commit = "b027ee29d959fda4b60b57566d64c98a202e0feb";
  src = builtins.fetchTarball {
    url = "https://github.com/ryantm/agenix/archive/${commit}.tar.gz";
    sha256 = "sha256:1wlpvpj45qfixdzhmk2cgiwlkyaf8a5mjy2jp5lsx2wsxblclngm";
  };
in
{
  module = "${src}/modules/age.nix";
  cli = pkgs.callPackage "${src}/pkgs/agenix.nix" { };
}
