{ stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation {
    pname = "Rubik";
    version = "1.0";

    src = fetchzip {
        url = "https://github.com/RishiVora/fonts/raw/main/Rubik.zip";
        sha256 = "1rkjliwrwbqndf044h8zwlfkdc1mzfzmn4j877si1lsl63cvsd89";
        stripRoot = false;
    };

    installPhase = ''
        runHook preInstall

        mkdir -p $out/share/fonts/truetype

        install -Dm644 ./*.ttf -t $out/share/fonts/truetype

        runHook postInstall
    '';
}
