{pkgs, ...}: let
    baseDir = ".mozilla/firefox/default";

    shyfox = pkgs.fetchzip {
        url = "https://github.com/Vortriz/ShyFox/archive/refs/heads/main.zip";
        sha256 = "sha256-alrK8s1B+ShX4yda27jPPvBZTIE0nYu9iQYAmtzQrZc=";
        stripRoot = true;
    };
    # For testing purposes
    # shyfox = builtins.path {
    #     path = /mnt/HOUSE/dev/ShyFox;
    # };
in {
    programs.firefox.profiles.default.extraConfig = builtins.readFile "${shyfox}/user.js";

    home.file."${baseDir}/chrome".source = "${shyfox}/chrome";
}
