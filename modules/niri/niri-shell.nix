{inputs, ...}: {
    unify = {
        nixos = {
            homeConfig,
            pkgs,
            ...
        }: {
            imports = [inputs.niri-shell.nixosModules.greeter];

            nixpkgs.overlays = [
                inputs.quickshell.overlays.default
            ];

            programs.dankMaterialShell.greeter = {
                enable = true;
                compositor.name = "niri";

                configFiles = [
                    "/etc/dms-greeter/settings.json"
                    "${homeConfig.xdg.stateHome}/DankMaterialShell/session.json"
                    "${homeConfig.xdg.cacheHome}/DankMaterialShell/dms-colors.json"
                ];

                logs.save = true;
            };

            environment.etc."dms-greeter/settings.json".source = pkgs.writers.writeJSON "settings.json" {
                weatherEnabled = false;
                currentThemeName = "blue";
                matugenScheme = "scheme-tonal-spot";
                iconTheme = "System Default";
                fontFamily = homeConfig.stylix.fonts.monospace.name;
                fontWeight = 400;
                fontScale = 1;
                cornerRadius = 12;
                widgetBackgroundColor = "sch";
                surfaceBase = "s";
                animationSpeed = 2;
            };
        };

        home = {pkgs, ...}: {
            imports = [
                inputs.niri-shell.homeModules.dankMaterialShell.default
                inputs.niri-shell.homeModules.dankMaterialShell.niri
            ];

            programs.dankMaterialShell = {
                enable = true;

                niri = {
                    enableKeybinds = true;
                };

                systemd.enable = true;
            };

            programs.niri.settings.layer-rules = [
                {
                    matches = [{namespace = "dms:blurwallpaper";}];
                    place-within-backdrop = true;
                }
            ];

            # [TODO] test if this works
            home.packages = with pkgs; [
                wl-mirror
            ];
        };
    };
}
