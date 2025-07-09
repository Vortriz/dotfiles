{
    config,
    lib,
    pkgs,
    ...
}: let
    niriswitcher-gdbus = cmd:
        "${pkgs.glib}/bin/gdbus call --session --dest io.github.isaksamsten.Niriswitcher --object-path /io/github/isaksamsten/Niriswitcher --method io.github.isaksamsten.Niriswitcher."
        + cmd;
    niriswitcher-window = config.niri-lib.spawn' (niriswitcher-gdbus "application");
    niriswitcher-workspace = config.niri-lib.spawn' (niriswitcher-gdbus "workspace");
in {
    programs.niriswitcher = {
        enable = true;

        settings = {
            workspace = {
                mru_sort_in_workspace = false;
                mru_sort_across_workspace = false;
            };
        };
    };

    programs.niri.settings = {
        binds = {
            "Alt+Tab".action = niriswitcher-window;
            "Alt+Shift+Tab".action = niriswitcher-window;
            "Alt+grave".action = niriswitcher-workspace;
            "Alt+Shift+grave".action = niriswitcher-workspace;
        };

        spawn-at-startup = [
            {command = [(lib.getExe pkgs.niriswitcher)];}
        ];
    };
}
