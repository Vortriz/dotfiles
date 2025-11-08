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

    home.packages = with pkgs; [
        nur.repos.Vortriz.goldfish
    ];

    programs.niri.settings.binds = {
        "Alt+Space" = config.niri-lib.open {
            app = config.services.vicinae.package;
            args = "toggle";
        };
    };
}
