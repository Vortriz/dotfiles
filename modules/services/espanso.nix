{
    unify = {
        nixos = {
            config,
            lib,
            pkgs,
            ...
        }: {
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
            osConfig,
            pkgs,
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
            xdg.configFile = let
                baseDir = "espanso/match/packages";
            in {
                "${baseDir}/greek-letters-improved".source = pkgs.espanso-greek-letters-improved;
                "${baseDir}/math-symbols".source = pkgs.espanso-math-symbols;
                "${baseDir}/super-sub-scripts".source = pkgs.espanso-super-sub-scripts;
                "${baseDir}/actually-all-emojis-spaces".source = pkgs.espanso-actually-all-emojis-spaces;
                "${baseDir}/lower-upper".source = pkgs.espanso-lower-upper;
            };

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
