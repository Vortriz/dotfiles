{
    inputs,
    lib,
    osConfig,
    ...
}: let
    inherit (osConfig.defaults) launcher;
in {
    imports = [inputs.sherlock.homeManagerModules.default];

    programs.sherlock = {
        enable = true;
        package = launcher;

        settings = {
            aliases = import ./aliases.nix;
            config = import ./config.nix {inherit lib osConfig;};
            launchers = import ./launchers.nix;

            style = with builtins;
                fetchurl {
                    url = "https://raw.githubusercontent.com/Skxxtz/sherlock/refs/heads/documentation/resources/main.css";
                    sha256 = "sha256:1pdvwcmfdxpf661z18jkmisg0lb16c52zlzghn72a7y063qnf0x3";
                }
                |> readFile
                |> (f: f + readFile ./extra.css);
        };
    };
}
