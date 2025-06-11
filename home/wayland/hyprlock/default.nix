{osConfig, ...}: let
    inherit (osConfig.var) dotfilesDir;
in {
    programs.hyprlock = {
        enable = true;

        settings = {
            auth.fingerprint.enabled = true;

            # BACKGROUND
            background = {
                path = "${dotfilesDir}/assets/wallpapers/19.png";
                blur_passes = 2;
                contrast = 1;
                brightness = 0.5;
                vibrancy = 0.2;
                vibrancy_darkness = 0.2;
            };

            # GENERAL
            general = {
                # no_fade_in = true;
                # no_fade_out = true;
                hide_cursor = false;
                grace = 5;
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
                    font_family = "JetBrainsMono NFM";
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
                    font_family = "JetBrainsMono NFM";
                    position = "0, 150";
                    halign = "center";
                    valign = "center";
                }

                # TIME
                {
                    text = ''cmd[update:1000] date +"%I:%M"'';
                    color = "rgba(242, 243, 244, 0.75)";
                    font_size = 128;
                    font_family = "JetBrainsMono NFM Extrabold";
                    position = "0, 50";
                    halign = "center";
                    valign = "center";
                }

                # BATTERY
                {
                    text = "cmd[update:1000] battery";
                    color = "rgba(255, 255, 255, 0.4)";
                    font_size = 18;
                    font_family = "JetBrainsMono NFM Extrabold";
                    position = "-10, 0";
                    halign = "right";
                    valign = "bottom";
                }
            ];
        };
    };
}
