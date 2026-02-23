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

        wayland.windowManager.niri.settings.binds = {
            "Alt+Space" = {
                spawn-sh = "${lib.getExe config.services.vicinae.package} toggle";
                _props.hotkey-overlay-title = "Toggle Vicinae";
            };
        };
    };
}
