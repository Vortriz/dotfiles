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
        "Alt+Space" = config.niri-lib.open {
            app = config.services.vicinae.package;
            args = "toggle";
        };
    };
}
