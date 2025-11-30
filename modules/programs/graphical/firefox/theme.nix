{
    unify.home = {pkgs, ...}: let
        baseDir = ".mozilla/firefox/default";

        # For testing purposes
        # shyfox = builtins.path {
        #     path = /mnt/HOUSE/dev/ShyFox;
        # };

        shyfox = (pkgs.callPackages ../../../../_sources/generated.nix {}).shyfox.src;
    in {
        programs.firefox.profiles.default.extraConfig = builtins.readFile "${shyfox}/user.js";

        home.file."${baseDir}/chrome".source = "${shyfox}/chrome";
    };
}
