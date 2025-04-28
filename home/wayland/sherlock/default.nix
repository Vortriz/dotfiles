{inputs, ...}: {
    imports = [inputs.sherlock.homeManagerModules.default];

    programs.sherlock = {
        enable = true;

        settings = {
            aliases = import ./aliases.nix;
            config = import ./config.nix;
            launchers = import ./launchers.nix;

            style = with builtins;
                readFile (fetchurl {
                    url = "https://raw.githubusercontent.com/Skxxtz/sherlock/refs/heads/documentation/resources/main.css";
                    sha256 = "sha256-0K6KiNBq26Yvf2epkJNj9Yc/C6F3KQ6xXCrbbj0bTwM=";
                })
                + readFile ./extra.css;
        };
    };
}
