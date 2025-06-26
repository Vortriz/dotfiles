{
    config,
    pkgs,
    osConfig,
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

    home.packages = [pkgs.grim];

    programs.niri.settings.binds."Print" = config.niri-lib.open {
        app = pkgs.flameshot;
        args = "gui";
        title = "Take screenshot with flameshot";
    };
}
