{inputs, ...}: {
    unify = {
        nixos = {
            config,
            lib,
            pkgs,
            ...
        }: {
            nixpkgs.overlays = [inputs.nur-vortriz.overlays.espansoPackages];

            security.wrappers.espanso = {
                capabilities = "cap_dac_override+p";
                owner = "root";
                group = "root";
                source = lib.getExe (
                    pkgs.espanso-wayland.override {securityWrapperPath = config.security.wrapperDir;}
                );
            };
        };

        home = {
            lib,
            pkgs,
            osConfig,
            ...
        }: {
            services.espanso = {
                enable = true;
                configs.default = {
                    show_notifications = false;
                    search_shortcut = "ALT+SHIFT+SPACE";
                };
                matches.default.matches = [
                    {
                        trigger = ":n-";
                        replace = "–";
                    }
                    {
                        trigger = ":m-";
                        replace = "—";
                    }
                ];
            };

            # plugins
            xdg.configFile = lib.attrsets.listToAttrs (map (
                name: {
                    name = "espanso/match/packages/${name}";
                    value.source = pkgs.espansoPackages.${name};
                }
            ) [
                "greek-letters-improved"
                "math-symbols"
                "super-sub-scripts"
                "actually-all-emojis-spaces"
                "lower-upper"
            ]);

            systemd.user.services.espanso = lib.mkForce {
                Unit = {
                    Description = "Espanso daemon";
                };
                Service = {
                    ExecStart = "${osConfig.security.wrapperDir}/espanso daemon";
                    Restart = "on-failure";
                };
                Install = {
                    WantedBy = ["default.target"];
                };
            };
        };
    };
}
