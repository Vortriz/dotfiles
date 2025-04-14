{
    osConfig,
    pkgs,
    ...
}: let
    downloadsDir = osConfig.var.downloadsDir;
in {
    services.flameshot = {
        enable = true;

        settings = {
            General = {
                contrastOpacity = 188;
                filenamePattern = "%F (%T)";
                saveAsFileExtension = "png";
                savePath = "${downloadsDir}/captures/linux";
                savePathFixed = false;
                showStartupLaunchMessage = false;
                startupLaunch = true;
            };
        };
    };

    home.packages = with pkgs; [
        grim # needed
    ];

    # Fix for flameshot
    systemd.user = {
        targets.tray = {
            Unit = {
                Description = "Home Manager System Tray";
                Requires = ["graphical-session-pre.target"];
            };
        };
    };
}
