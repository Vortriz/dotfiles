{
    unify.home = {
        config,
        lib,
        pkgs,
        ...
    }: let
        battery-script = pkgs.writers.writeFishBin "battery" {} ''
            set battery_percentage (cat /sys/class/power_supply/BAT0/capacity)
            set battery_status (cat /sys/class/power_supply/BAT0/status)

            # Define the battery icons for each 10% segment
            set battery_icons "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹"
            set charging_icon "󰂄"

            set icon_index (math -s0 $battery_percentage / 10 + 1)
            set battery_icon $battery_icons[$icon_index]

            if test "$battery_status" = "Charging"
                set battery_icon "$charging_icon"
            end

            echo "$battery_percentage% $battery_icon"
        '';
    in {
        programs.hyprlock = {
            enable = true;

            settings = let
                font_family = config.stylix.fonts.monospace.name;
            in {
                auth.fingerprint.enabled = true;

                # BACKGROUND
                background = {
                    path = toString ../../../assets/wallpapers/34.png;
                    blur_passes = 1;
                };

                # GENERAL
                general = {
                    hide_cursor = false;
                    disable_loading_bar = true;
                };

                # INPUT FIELD
                input-field = [
                    {
                        size = "250, 60";
                        outline_thickness = 2;
                        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
                        dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
                        dots_center = true;
                        outer_color = "rgba(0, 0, 0, 0)";
                        inner_color = "rgba(0, 0, 0, 0.2)";
                        inherit font_family;
                        font_color = "rgb(255, 255, 255)";
                        fade_on_empty = false;
                        rounding = -1;
                        check_color = "rgb(204, 136, 34)";
                        placeholder_text = ''<span foreground="##ffffff99">...</span>'';
                        hide_input = false;
                        position = "0, -100";
                        halign = "center";
                        valign = "center";
                    }
                ];

                label = [
                    # DATE
                    {
                        text = ''cmd[update:1000] date +"%A, %B %d"'';
                        color = "rgba(242, 243, 244, 0.75)";
                        font_size = 16;
                        inherit font_family;
                        position = "0, 150";
                        halign = "center";
                        valign = "center";
                    }

                    # TIME
                    {
                        text = ''cmd[update:1000] date +"%I:%M"'';
                        color = "rgba(242, 243, 244, 0.75)";
                        font_size = 128;
                        font_family = font_family + " Extrabold";
                        position = "0, 50";
                        halign = "center";
                        valign = "center";
                    }

                    # BATTERY
                    {
                        text = "cmd[update:1000] ${lib.getExe battery-script}";
                        color = "rgba(255, 255, 255, 0.4)";
                        font_size = 18;
                        font_family = font_family + " ExtraBold";
                        position = "-10, 0";
                        halign = "right";
                        valign = "bottom";
                    }
                ];
            };
        };

        wayland.windowManager.niri.settings.binds."Mod+L" = {
            spawn-sh = "niri msg action do-screen-transition && ${lib.getExe pkgs.hyprlock} --immediate";
            _props.hotkey-overlay-title = "Lock screen";
        };
    };
}
