{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
  	killall
    brightnessctl
    pavucontrol
    # wireplumber
  ];

  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = [
      {
        "layer" = "top";
        "position" = "top";

        modules-left = [
          "custom/launcher"
          "temperature"
          "niri/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "memory"
          "cpu"
          "pulseaudio"
          # "pulseaudio#microphone"
          "backlight"
          "battery"
          "custom/powermenu"
          "tray"
        ];
        "niri/workspaces" = {
        };

        "custom/launcher" = {
          "format" = " ";
          "on-click" = "pkill fuzzel || fuzzel";
          # "on-click-middle" = "exec default_wall";
          # "on-click-right" = "systemctl --user restart waybar.service";
          "tooltip" = false;
        };
        "custom/cava-internal" = {
          "exec" = "sleep 1s && cava-internal";
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
              ""
            ];
          };
          # "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "on-click" = "pavucontrol";
          "tooltip" = false;
        };
        "pulseaudio#microphone" = {
          "format" = "{format_source}";
          "format-source" = " {volume}%";
          "format-source-muted" = " Muted";
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "on-scroll-up" = "wpctl set-volume -l 1.3 @DEFAULT_AUDIO_SOURCE@ 1%+";
          "on-scroll-down" = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-";
        };

        "clock" = {
          "interval" = 1;
          "format" = " {:%H:%M   %d/%m}";
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
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'></span> {title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'></span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        network =
          let
            nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          in
          {
            # interface = "wlo1";
            format-wifi = "󰖩 {essid} ";
            format-ethernet = "󰈀";
            format-alt = "󰤨  {bandwidthDownBytes}";
            format-disconnected = "󰤭";
            tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
            on-click-right = "${nm-editor}";
            interval = 1;
          };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill wlogout || wlogout --protocol layer-shell";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
        "battery" = {
          "states" = {
            "good" = 95;
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
      }
    ];
  };
}
