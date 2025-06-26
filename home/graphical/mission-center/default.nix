{
    config,
    pkgs,
    ...
}: {
    home.packages = [pkgs.mission-center];

    programs.niri.settings.binds."Ctrl+Shift+Escape" = config.niri-lib.open {app = pkgs.mission-center;};
}
