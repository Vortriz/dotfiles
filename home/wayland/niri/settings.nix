{
    lib,
    osConfig,
    pkgs,
    ...
}: let
    inherit (osConfig.var) downloadsDir;
in {
    programs.niri.settings = {
        animations = {
            window-open.kind = {
                easing = {
                    curve = "ease-out-expo";
                    duration-ms = 250;
                };
            };
            window-close.kind = {
                easing = {
                    curve = "ease-out-quad";
                    duration-ms = 250;
                };
            };
        };

        environment = {
            # for electron apps
            NIXOS_OZONE_WL = "1";

            # ugly fix for flameshot
            QT_SCREEN_SCALE_FACTORS = builtins.toString (2.0 / 3.0);
        };

        hotkey-overlay = {
            skip-at-startup = true;
            hide-not-bound = true;
        };

        input.touchpad = {
            tap-button-map = "left-right-middle";
            scroll-factor = 0.75;
            dwt = true;
        };

        layer-rules = [
            {
                matches = [{namespace = "overview";}];
                place-within-backdrop = true;
            }
        ];

        layout = {
            always-center-single-column = true;
            default-column-width.proportion = 0.5;
            focus-ring = {
                enable = true;
                width = 2;
            };

            struts.top = -8;

            tab-indicator = {
                enable = true;
                hide-when-single-tab = true;
                gap = -12;
                length.total-proportion = 0.25;
                position = "top";
            };
        };

        outputs."eDP-1" = {
            mode = {
                height = 1800;
                width = 2880;
                refresh = 60.001;
            };

            scale = 1.5;
        };

        prefer-no-csd = true;

        screenshot-path = "${downloadsDir}/captures/linux/%Y-%m-%d (%H-%M-%S).png";

        workspaces = {
            "Acad" = {};
            "Browse" = {};
            "Code" = {};
        };

        xwayland-satellite = {
            enable = true;
            path = lib.getExe pkgs.xwayland-satellite-unstable;
        };
    };
}
