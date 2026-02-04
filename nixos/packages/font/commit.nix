{
  lib,
  fetchzip,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation rec {
  pname = "commit-mono";

  # version = "tags/v1.143";

  # No release of the correct name exist yet.

  version = "heads/main";

  src = fetchzip {
    url = "https://github.com/eigilnikolajsen/commit-mono/archive/refs/${version}.zip";
    sha256 = "sha256-ohVmVhzoJTtQDC0XZ1Y/0Oktxi+S3hpJ6IVXXjx/mrY=";
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
