{inputs, ...}: {
    unify.home = let
        inherit (inputs) shyfox;
    in {
        xdg.configFile."mozilla/firefox/default/chrome" = {
            source = "${shyfox}/chrome";
            recursive = true;
        };
        programs.firefox.profiles.default.extraConfig = builtins.readFile "${shyfox}/user.js";
    };
}
