{
    lib,
    osConfig,
    pkgs,
    ...
}: {
    programs.niri.settings = {
        # keep-sorted start block=yes newline_separated=yes
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
            exit-confirmation-open-close.enable = false;
        };

        environment = {
            # for electron apps
            NIXOS_OZONE_WL = "1";
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
                matches = [{namespace = "quickshell:notification";}];
                block-out-from = "screencast";
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
                gap = -16;
                gaps-between-tabs = 4;
                width = 10;
                corner-radius = 3;
                length.total-proportion = 0.15;
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

        overview = {
            zoom = 0.4;
        };

        prefer-no-csd = true;

        screenshot-path = "${osConfig.var.downloadsDir}/captures/linux/%Y-%m-%d (%H-%M-%S).png";

        workspaces = {
            "Acad" = {};
            "Browse" = {};
            "Code" = {};
        };

        xwayland-satellite = {
            enable = true;
            path = lib.getExe pkgs.xwayland-satellite-unstable;
        };
        # keep-sorted end
    };
}
