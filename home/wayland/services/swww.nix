{
    config,
    inputs,
    osConfig,
    ...
}: let
    inherit (osConfig.var) system;
    inherit (osConfig.defaults) wallpaper;
in {
    home.packages = [inputs.swww.packages.${system}.default];

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
