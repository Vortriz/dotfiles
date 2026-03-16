{inputs, ...}: {
    unify = {
        home = {
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

            home.packages = with pkgs; [doi2bib3];

            xdg.dataFile = {
                "vicinae/scripts/doi2bib3.fish" = {
                    source = ../../scripts/doi2bib3/script.fish;
                    executable = true;
                };

                "vicinae/scripts/dl.fish" = {
                    source = ../../scripts/dl/script.fish;
                    executable = true;
                };
            };

            wayland.windowManager.niri.settings = {
                binds = {
                    "Alt+Space" = {
                        spawn-sh = "${lib.getExe config.services.vicinae.package} toggle";
                        _props.hotkey-overlay-title = "Toggle Vicinae";
                    };
                    "Mod+V" = {
                        spawn-sh = "vicinae deeplink vicinae://extensions/vicinae/clipboard/history";
                        _props.hotkey-overlay-title = "Show Clipboard History";
                    };
                };

                layer-rule = [
                    {
                        match._props.namespace = "vicinae";

                        background-effect = {
                            blur = true;
                            xray = false;
                        };
                    }
                ];
            };
        };
    };
}
