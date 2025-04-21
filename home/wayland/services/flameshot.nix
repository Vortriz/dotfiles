{
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) downloadsDir;
in {
    services.flameshot = {
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

    # Fix for flameshot
    systemd.user = {
        targets.tray = {
            Unit = {
                Description = "Home Manager System Tray";
                Requires = ["graphical-session-pre.target"];
            };
        };
    };

    home.packages = [pkgs.grim];
}
