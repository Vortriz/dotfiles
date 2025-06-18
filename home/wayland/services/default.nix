{
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) downloadsDir;
in {
    imports = [
        ./swww.nix
    ];

    services = {
        # keep-sorted start block=yes newline_separated=yes
        avizo = {
            enable = true;

            settings.default.time = 1.5;
        };

        dunst = {
            enable = true;

            settings.ignore_flameshot_warning = {
                body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
                format = "";
            };
        };

        flameshot = {
            enable = true;

            settings = {
                General = {
                    # keep-sorted start
                    contrastOpacity = 188;
                    filenamePattern = "%F (%T)";
                    saveAsFileExtension = "png";
                    savePath = "${downloadsDir}/captures/linux";
                    savePathFixed = false;
                    showStartupLaunchMessage = false;
                    startupLaunch = true;
                    # keep-sorted end
                };
            };
        };

        gnome-keyring.enable = true;
        # keep-sorted end
    };

    stylix.targets.avizo.enable = true;
    stylix.targets.dunst.enable = true;

    systemd.user.targets.tray.Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
    };

    home.packages = [pkgs.grim];
}
