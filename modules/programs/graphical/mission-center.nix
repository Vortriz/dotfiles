{
    unify.home = {
        config,
        pkgs,
        ...
    }: {
        home.packages = [pkgs.mission-center];

        programs.niri.settings.binds = {
            "Ctrl+Shift+Escape" = {
                action = config.lib.niri.actions.spawn-sh (pkgs.lib.getExe pkgs.mission-center);
                hotkey-overlay.title = "Open Mission Center";
            };
        };
    };
}
