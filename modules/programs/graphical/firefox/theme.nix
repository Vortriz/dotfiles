{inputs, ...}: {
    unify.home = let
        baseDir = ".mozilla/firefox/default";

        inherit (inputs) shyfox;
    in {
        home.file."${baseDir}/chrome".source = "${shyfox}/chrome";
        programs.firefox.profiles.default.extraConfig = builtins.readFile "${shyfox}/user.js";
    };
}
