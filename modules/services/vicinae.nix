{inputs, ...}: {
    unify.home = {
        config,
        lib,
        pkgs,
        ...
    }: {
        imports = [inputs.vicinae.homeManagerModules.default];

        services.vicinae = {
            enable = true;
            package = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;

            systemd = {
                enable = true;
                autoStart = true;
            };
        };

        programs.niri.settings.binds = {
            "Alt+Space" = {
                action = config.lib.niri.actions.spawn-sh "${lib.getExe config.services.vicinae.package} toggle";
                hotkey-overlay.title = "Toggle Vicinae";
            };
        };
    };
}
