{
    unify.home = {
        hostConfig,
        lib,
        pkgs,
        ...
    }: {
        wayland.windowManager.niri.settings = {
            # keep-sorted start block=yes newline_separated=yes
            animations = {
                window-open = {
                    duration-ms = 250;
                    curve = "ease-out-expo";
                };
                window-close = {
                    duration-ms = 250;
                    curve = "ease-out-quad";
                };
                exit-confirmation-open-close.off = [];
            };

            blur = {
                on = [];
                passes = 4;
            };

            environment = {
                # for electron apps
                NIXOS_OZONE_WL = "1";
            };

            hotkey-overlay = {
                skip-at-startup = [];
                hide-not-bound = [];
            };

            input = {
                touchpad = {
                    dwt = [];
                    tap = [];
                    natural-scroll = [];
                    tap-button-map = "left-right-middle";
                    scroll-factor = 0.75;
                };
                keyboard = {
                    repeat-delay = 600;
                    repeat-rate = 25;
                };
            };

            layer-rule = [
                {
                    match._props.namespace = "quickshell:notification";
                    block-out-from = "screencast";
                }
            ];

            layout = {
                struts.top = -8;
                background-color = "#000000";

                always-center-single-column = [];
                default-column-width.proportion = 0.5;

                focus-ring.width = 2;
                border.off = [];

                tab-indicator = {
                    hide-when-single-tab = [];
                    gap = -16;
                    gaps-between-tabs = 4;
                    width = 10;
                    corner-radius = 3;
                    length._props.total-proportion = 0.15;
                    position = "top";
                };
            };

            output = [
                {
                    _args = ["eDP-1"];
                    mode = "2880x1800@60.001";
                    scale = 1.5;
                }
            ];

            overview.zoom = 0.4;

            prefer-no-csd = [];

            screenshot-path = "${hostConfig.dirs.downloads}/captures/linux/%Y-%m-%d (%H-%M-%S).png";

            workspace = [
                {_args = ["Acad"];}
                {_args = ["Browse"];}
                {_args = ["Code"];}
            ];

            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite-unstable;
            # keep-sorted end
        };
    };
}
