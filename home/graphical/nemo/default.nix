{
    osConfig,
    lib,
    pkgs,
    ...
}: {
    home.packages = [pkgs.nemo-with-extensions];

    xdg.desktopEntries.nemo = {
        name = "Nemo";
        exec = "nemo";
    };

    dconf = {
        settings = {
            "org/cinnamon/desktop/applications/terminal".exec = lib.getName osConfig.defaults.terminal;
        };
    };
}
