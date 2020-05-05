{ stdenv, pkgs }:

stdenv.mkDerivation rec {
  pname = "pragmata-pro";
  version = "0.828";

  src = ./data.tar.gz;

  dontBuild = true;

  installPhase = ''
    install --target $out/share/fonts/opentype -D $src/*.ttf
  '';

  meta = with stdenv.lib; {
    description = "A condensed monospaced font optimized for screen.";
    longDescription = ''
      A condensed monospaced font optimized for screen, designed by Fabrizio Schiavi to be the ideal font for coding, math and engineering.
    '';
    homepage = "https://www.fsd.it/shop/fonts/pragmatapro/";
    license = licenses.unfree;
    inherit version;
  };
}
