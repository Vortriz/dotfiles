{ stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation {
    pname = "Inter";
    version = "1.0";

    src = fetchzip {
        url = "https://github.com/RishiVora/fonts/raw/main/Inter.zip";
        sha256 = "sha256-RB2ceB62Qil2IzMoD7n4St1W1mEFJJ41ee4qvLxBsNA=";
        stripRoot = false;
    };

    installPhase = ''
        runHook preInstall

        mkdir -p $out/share/fonts/truetype

        install -Dm644 ./*.ttf -t $out/share/fonts/truetype

        runHook postInstall
    '';
}
