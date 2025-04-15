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
        package = inputs.walker.packages.${pkgs.system}.default;
        runAsService = true;

        config = importTOML ./config.toml;

        theme = {
            layout = importTOML ./layout.toml;

            style = builtins.readFile ./theme.css;
        };
    };
}
