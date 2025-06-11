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

    # [TODO] use a backdrop after this goes through: https://github.com/LGFae/swww/pull/435

    programs.niri = {
        settings =
            import ./settings.nix {inherit lib osConfig pkgs;}
            // {
                binds = import ./binds.nix {inherit config lib osConfig pkgs;};
                window-rules = import ./window-rules.nix {inherit inputs lib osConfig;};
            };
    };
}
