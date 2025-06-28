{
    config,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.defaults) wallpaper;
in {
    home.packages = [pkgs.swww-git];

    systemd.user.services.swww-workspace = {
        Install = {
            WantedBy = [config.wayland.systemd.target];
        };

        Unit = {
            ConditionEnvironment = "WAYLAND_DISPLAY";
            Description = "swww-daemon for workspace";
            After = [config.wayland.systemd.target];
            PartOf = [config.wayland.systemd.target];
        };

        Service = {
            ExecStart = "${wallpaper}/bin/swww-daemon --namespace workspace";
            Restart = "always";
            RestartSec = 10;
        };
    };

    systemd.user.services.swww-overview = {
        Install = {
            WantedBy = [config.wayland.systemd.target];
        };

        Unit = {
            ConditionEnvironment = "WAYLAND_DISPLAY";
            Description = "swww-daemon for overview";
            After = [config.wayland.systemd.target];
            PartOf = [config.wayland.systemd.target];
        };

        Service = {
            ExecStart = "${wallpaper}/bin/swww-daemon --namespace overview";
            Restart = "always";
            RestartSec = 10;
        };
    };
}
