{pkgs, ...}: {
    programs.waybar = {
        enable = true;

        style = ./style.css;

        settings.mainBar = {
            layer = "top";
            position = "top";

            modules-left = [
                "custom/launcher"
                "niri/workspaces"
            ];

            modules-center = [
                "clock"
            ];

            modules-right = [
                "network"
                "cpu"
                "memory"
                "pulseaudio"
                "pulseaudio#microphone"
                "backlight"
                "battery"
                "custom/powermenu"
                "tray"
            ];

            "niri/workspaces" = {
            };

            "custom/launcher" = {
                "format" = " ";
                "on-click" = "ulauncher-toggle";
                "tooltip" = false;
            };

            "pulseaudio" = {
                "scroll-step" = 1;
                "reverse-scrolling" = true;
                "format" = "{icon} {volume}%";
                "format-muted" = "󰖁 Muted";
                "format-icons" = {
                    "default" = [
                        ""
                        ""
                        " "
                    ];
                };
                "on-click" = "pavucontrol";
                "on-click-right" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                "tooltip" = false;
            };

            "pulseaudio#microphone" = {
                "format" = "{format_source}";
                "format-source" = " {volume}%";
                "format-source-muted" = "  Muted";
                "on-click-right" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
                "on-scroll-up" = "pactl set-source-volume @DEFAULT_SOURCE@ +2%";
                "on-scroll-down" = "pactl set-source-volume @DEFAULT_SOURCE@ -2%";
            };

            "clock" = {
                "interval" = 1;
                "format" = " {:%H:%M     %d/%m}";
                "tooltip" = true;
                "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            };

            "memory" = {
                "interval" = 1;
                "format" = "󰻠 {percentage}%";
                "states" = {
                    "warning" = 85;
                };
            };

            "cpu" = {
                "interval" = 1;
                "format" = "󰍛 {usage}%";
            };

            "network" = let
                nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
            in {
                format-wifi = "󰖩 {essid} ";
                format-ethernet = "󰈀";
                format-alt = "󰤨    {bandwidthDownBytes}";
                format-disconnected = "󰤭";
                tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
                on-click-right = "${nm-editor}";
                interval = 1;
            };

            "custom/powermenu" = {
                "format" = "";
                "on-click" = "pidof hyprlock || hyprlock --immediate";
                "on-click-right" = "${pkgs.systemd}/bin/systemctl poweroff";
                "tooltip" = false;
            };

            "tray" = {
                "icon-size" = 15;
                "spacing" = 5;
            };

            "battery" = {
                "states" = {
                    "good" = 90;
                    "warning" = 20;
                    "critical" = 10;
                };
                "format" = "{icon} {capacity}%";
                "format-charging" = " {capacity}%";
                "format-plugged" = " {capacity}%";
                "format-alt" = "{time} {icon}";
                "format-icons" = [
                    ""
                    ""
                    ""
                    ""
                ];
            };

            "backlight" = {
                "reverse-scrolling" = true;
                "format" = "{icon} {percent}%";
                "format-icons" = ["" ""];
                "on-scroll-up" = "brightnessctl -d intel_backlight -e set +2%";
                "on-scroll-down" = "brightnessctl -d intel_backlight -e set 2%-";
                "tooltip" = false;
            };
        };
    };

    programs.waybar.systemd.enable = true;
}
