{
    config,
    inputs,
    pkgs,
    ...
}: {
    imports = [inputs.vicinae.homeManagerModules.default];

    services.vicinae = {
        enable = true;

        settings = {
            closeOnFocusLoss = false;
            faviconService = "google";
            font = {
                normal = "Maple Mono Normal NF";
                size = 10;
            };
            popToRootOnClose = true;
            rootSearch.searchFiles = false;
            theme.name = "vicinae-dark";
            window = {
                csd = true;
                opacity = 1;
                rounding = 10;
            };
        };
    };

    programs.niri.settings.binds = {
        "Alt+Space" = config.niri-lib.open {app = inputs.vicinae.packages.${pkgs.system}.default;};
    };
}
