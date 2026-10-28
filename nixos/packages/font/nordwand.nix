{
  fetchzip,
  installFonts,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation rec {
  pname = "nordwand-mono";
  version = "1.4.0";

  src = fetchzip {
    url = "https://github.com/tywr/Nordwand-Mono/releases/download/${version}/NordwandMono-OTF.zip";
    hash = "sha256-H6jSgWK2MinZmDCC5rbpP5KSSu1tW5tZg6hT+yHUqGs=";
    stripRoot = false;
  };

  nativeBuildInputs = [ installFonts ];

  meta = with lib; {
    homepage = "https://github.com/tywr/Nordwand-Mono";
    description = "Monospaced typeface";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
