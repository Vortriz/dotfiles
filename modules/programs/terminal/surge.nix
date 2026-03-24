{
    unify.home = {
        lib,
        lib',
        hostConfig,
        pkgs,
        ...
    }: {
        home.packages = [pkgs.surge];

        xdg.configFile."surge/settings.json".text = lib.toJSON {
            general = {
                default_download_dir = hostConfig.dirs.downloads;
                skip_update_check = true;
                clipboard_monitor = false;
                theme = 2; # dark theme
            };

            network.max_connections_per_host = 16;
        };

        programs.firefox.policies.ExtensionSettings = builtins.listToAttrs [
            (lib'.extension "surge" "surge@surge-downloader.com")
        ];

        wayland.windowManager.niri.settings.spawn-sh-at-startup = [
            ["${lib.getExe pkgs.surge} server"]
        ];
    };
}
