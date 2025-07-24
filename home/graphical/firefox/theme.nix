{pkgs, ...}: let
    baseDir = ".mozilla/firefox/default";

    shyfox = pkgs.fetchzip {
        url = "https://github.com/Vortriz/ShyFox/archive/refs/heads/main.zip";
        sha256 = "sha256-0w+J81PhWeJ/I1uhGOf1r8yHoc/qw6wWGAtsSHB+8hE=";
        stripRoot = true;
    };
in {
    programs.firefox.profiles.default.extraConfig = builtins.readFile "${shyfox}/user.js";

    home.file."${baseDir}/chrome".source = "${shyfox}/chrome";
}
