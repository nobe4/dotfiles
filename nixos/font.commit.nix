{
  lib,
  fetchzip,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation rec {
  pname = "commit-mono";
  version = "1.143";

  src = fetchzip {
    url = "https://github.com/eigilnikolajsen/commit-mono/archive/refs/tags/v${version}.zip";
    sha256 = "sha256-FTN/kJgkCEeaPzbgKcXcR+mlUDO1/Rn7agD7oyWVeaM=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 src/fonts/fontlab/*.otf -t $out/share/fonts/opentype
    install -Dm644 src/fonts/fontlab/*.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://commitmono.com/";
    description = "Neutral programming typeface.";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
