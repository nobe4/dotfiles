{
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation rec {
  pname = "nerd";

  version = "v3.4.0";

  src = fetchTarball {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/NerdFontsSymbolsOnly.tar.xz";
    sha256 = "09q0in7g136h6fj1pzz020av43pcqyzhr6zhv25zmskxraw88hh3";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    description = "Iconic font aggregator, collection, & patcher.";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
