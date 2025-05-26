{
    config,
    inputs,
    lib,
    osConfig,
    pkgs,
    ...
}: {
    imports = [
        ./niriswitcher.nix
    ];

    programs.niri = {
        settings =
            import ./settings.nix {inherit lib osConfig pkgs;}
            // {
                binds = import ./binds.nix {inherit config lib osConfig pkgs;};
                window-rules = import ./window-rules.nix {inherit inputs lib osConfig;};
            };
    };
}
