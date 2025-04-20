{pkgs, ...}: let
    baseDir = ".mozilla/firefox/default";

    shyfox = pkgs.fetchzip {
        url = "https://github.com/z4na14/ShyFox/archive/refs/heads/main.zip";
        sha256 = "sha256-5fMWersBNRK8Taw6JFcdVhZpK5bZI32Vsaa8vqdOwPk=";
        stripRoot = true;
    };
in {
    programs.firefox.profiles.default.extraConfig = builtins.readFile "${shyfox}/user.js";

    home.file."${baseDir}/chrome".source = "${shyfox}/chrome";
}
