{pkgs, ...}: {
    home.packages = [pkgs.nemo-with-extensions];

    xdg.desktopEntries.nemo = {
        name = "Nemo";
        exec = "${pkgs.nemo-with-extensions}/bin/nemo";
    };

    dconf = {
        enable = true;

        settings = {
            "org/cinnamon/desktop/applications/terminal".exec = "kitty";
        };
    };
}
