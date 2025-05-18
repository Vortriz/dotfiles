{
    config,
    lib,
    osConfig,
    pkgs,
    ...
}: {
    programs.niri = {
        settings =
            import ./settings.nix {inherit osConfig pkgs;}
            // {
                binds = import ./binds.nix {inherit config lib osConfig pkgs;};
                window-rules = import ./window-rules.nix {inherit lib osConfig;};
            };
    };
}
