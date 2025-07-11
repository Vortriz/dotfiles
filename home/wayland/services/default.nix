{
    imports = [
        ./flameshot.nix
        ./swww.nix
    ];

    services = {
        # keep-sorted start block=yes newline_separated=yes
        avizo = {
            enable = true;

            settings.default.time = 1.5;
        };

        dunst = {
            enable = false;

            settings.ignore_flameshot_warning = {
                body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
                format = "";
            };
        };
        # keep-sorted end
    };

    stylix.targets.avizo.enable = true;
    stylix.targets.dunst.enable = true;

    systemd.user.targets.tray.Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
    };
}
