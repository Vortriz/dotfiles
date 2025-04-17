{
    inputs,
    lib,
    pkgs,
    ...
}: let
    inherit (lib.trivial) importTOML;
in {
    programs.walker = {
        enable = true;
        package = pkgs.walker;
        runAsService = true;

        config = importTOML ./config.toml;

        theme = {
            layout = importTOML ./layout.toml;

            style = builtins.readFile ./theme.css;
        };
    };
}
