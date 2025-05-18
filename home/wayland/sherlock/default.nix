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
                    sha256 = "sha256:1pdvwcmfdxpf661z18jkmisg0lb16c52zlzghn72a7y063qnf0x3";
                })
                + readFile ./extra.css;
        };
    };
}
