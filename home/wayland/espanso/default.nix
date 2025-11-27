{
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

    xdg.configFile = let
        baseDir = "espanso/match/packages";
        packages-src = pkgs.callPackages ./sources/generated.nix {};
    in {
        "${baseDir}/greek-letters-improved".source = "${packages-src.mega-pack.src}/greek-letters-improved";
        "${baseDir}/math-symbols".source = "${packages-src.mega-pack.src}/math-symbols";
        "${baseDir}/super-sub-scripts".source = "${packages-src.mega-pack.src}/super-sub-scripts";
        "${baseDir}/actually-all-emojis-spaces".source = "${packages-src.actually-all-emojis-spaces.src}/espanso_package/actually-all-emojis-spaces/0.3.0";
        "${baseDir}/lower-upper".source = "${packages-src.lower-upper.src}/0.1.0";
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
}
