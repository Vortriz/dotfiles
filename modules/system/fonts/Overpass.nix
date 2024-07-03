{ stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation {
    pname = "Overpass";
    version = "1.0";

    src = fetchzip {
        url = "https://github.com/RishiVora/fonts/raw/main/Overpass.zip";
        sha256 = "1g4660n1x2sf02qx79nacjp8iam69s2xjp2xznr7w56xb0ghihi4";
        stripRoot = false;
    };

    installPhase = ''
        runHook preInstall

        mkdir -p $out/share/fonts/truetype

        install -Dm644 ./*.ttf -t $out/share/fonts/truetype

        runHook postInstall
    '';
}
