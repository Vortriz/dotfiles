{
    osConfig,
    lib,
    pkgs,
    ...
}: let
    inherit (osConfig.defaults) terminal;
in {
    home.packages = [pkgs.nemo-with-extensions];

    xdg.desktopEntries.nemo = {
        name = "Nemo";
        exec = "nemo";
    };

    dconf = {
        settings = {
            "org/cinnamon/desktop/applications/terminal".exec = lib.getName terminal;
        };
    };
}
