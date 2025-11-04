{
    config,
    inputs,
    pkgs,
    ...
}: {
    imports = [inputs.vicinae.homeManagerModules.default];

    services.vicinae = {
        enable = true;
        package = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    programs.niri.settings.binds = {
        "Alt+Space" = config.niri-lib.open {
            app = config.services.vicinae.package;
            args = "toggle";
        };
    };
}
