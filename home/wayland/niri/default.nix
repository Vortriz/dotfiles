{pkgs, ...}: {
    imports = [
        ./binds.nix
        ./window-rules.nix
    ];

    programs.niri.settings = {
        hotkey-overlay.skip-at-startup = true;

        input = {
            touchpad = {
                tap-button-map = "left-right-middle";
                scroll-factor = 0.75;
                dwt = true;
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

        layout = {
            always-center-single-column = true;
            default-column-width.proportion = 0.5;
            focus-ring.width = 2;

            tab-indicator = {
                enable = true;
                hide-when-single-tab = true;
                gap = -10;
                length.total-proportion = 0.25;
                position = "top";
            };
        };

        spawn-at-startup = map (s: {command = pkgs.lib.strings.splitString " " s;})
        [
            "systemctl --user reset-failed waybar.service"
            "aria2c --enable-rpc --rpc-listen-all"
        ];

        prefer-no-csd = true;
        screenshot-path = "mnt/HOUSE/downloads/captures/linux/%Y-%m-%d (%H-%M-%S).png";
    };
}
