{pkgs, ...}: let
    baseDir = ".mozilla/firefox/default";

    shyfox = pkgs.fetchzip {
        url = "https://github.com/Vortriz/ShyFox/archive/refs/heads/main.zip";
        sha256 = "sha256-6sD2xcO/M7Exc15zJPJk+qSw/qvaWt7YaFRZ3ZeHuCU=";
        stripRoot = true;
    };
in {
    programs.firefox.profiles.default.extraConfig = builtins.readFile "${shyfox}/user.js";

    home.file."${baseDir}/chrome".source = "${shyfox}/chrome";
}
