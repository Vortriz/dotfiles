{
    config,
    inputs,
    pkgs,
    ...
}: {
    imports = [inputs.vicinae.homeManagerModules.default];

    services.vicinae = {
        enable = true;
        autoStart = true;
    };

    programs.niri.settings.binds = {
        "Alt+Space" = config.niri-lib.open {app = pkgs.vicinae;};
    };
}
