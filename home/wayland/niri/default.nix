{
    config,
    lib,
    osConfig,
    pkgs,
    ...
}: {
    programs.niri = {
        settings =
            {
                binds = import ./binds.nix {
                    inherit config lib pkgs;
                };

                window-rules = import ./window-rules.nix;
            }
            // import ./settings.nix {
                inherit osConfig pkgs;
            };
    };
}
