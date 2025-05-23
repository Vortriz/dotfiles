{
    config,
    inputs,
    lib,
    osConfig,
    pkgs,
    ...
}: {
    programs.niri = {
        settings =
            import ./settings.nix {inherit lib osConfig pkgs;}
            // {
                binds = import ./binds.nix {inherit config inputs lib osConfig pkgs;};
                window-rules = import ./window-rules.nix {inherit inputs lib osConfig;};
            };
    };
}
