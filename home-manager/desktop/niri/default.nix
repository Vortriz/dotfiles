{
    pkgs,
    lib,
    config,
    ...
}: {
    programs.niri = {
        settings = {
            hotkey-overlay.skip-at-startup = true;

            input = {
                touchpad = {
                    tap-button-map = "left-right-middle";
                };
            };

            outputs."eDP-1" = {
                mode = {
                    height = 1800;
                    width = 2880;
                };
                scale = 1.5;
            };

            layout = {
                always-center-single-column = true;
                default-column-width.proportion = 0.5;
                focus-ring.width = 2;
            };

            spawn-at-startup =
                map (s: { command = pkgs.lib.strings.splitString " " s; })
                    [
                        "${pkgs.waybar}/bin/waybar"
                    ];

            prefer-no-csd = true;

            screenshot-path = "~/Downloads/captures/screenshots/%Y-%m-%d %H-%M-%S.png";

            window-rules = [
                {
                    clip-to-geometry = true;
                    geometry-corner-radius = let
                        r = 12.0;
                    in {
                        top-left = r;
                        top-right = r;
                        bottom-left = r;
                        bottom-right = r;
                    };
                }
                {
                    matches = [
                        { app-id = "firefox"; }
                        { app-id = "code"; }
                        { title = ".*pdf"; }
                    ];
                    open-maximized = true;
                }
            ];

            binds = with config.lib.niri.actions; let
                vol = cmd: {
                    allow-when-locked = true;
                    action.spawn = [ "pactl" "set-sink-volume" "@DEFAULT_SINK@" ] ++ cmd;
                };

                mute = type: {
                    allow-when-locked = true;
                    action.spawn = [ "pactl" "set-${type}-mute" "@DEFAULT_${lib.toUpper type}@" "toggle"];
                };

                brightness = cmd: {
                    allow-when-locked = true;
                    action.spawn = [ "brightnessctl" "-d" "intel_backlight" "-e" "set" ] ++ cmd;
                };
            in {
                "Mod+Shift+Slash".action = show-hotkey-overlay;

                "Mod+T".action = spawn "kitty";
                "Alt+Space".action = spawn "fuzzel";
                "Mod+E".action = spawn "nautlius";  # TODO:fix

                "Mod+Q".action = close-window;

                "Alt+Shift+Tab".action = focus-column-left-or-last;
                "Alt+Tab".action = focus-column-right-or-first;

                "Mod+Down".action = focus-window-down;
                "Mod+Up".action = focus-window-up;

                "Mod+Ctrl+Left".action = move-column-left;
                "Mod+Ctrl+Down".action = move-window-down;
                "Mod+Ctrl+Up".action = move-window-up;
                "Mod+Ctrl+Right".action = move-column-right;

                "Mod+Home".action = focus-column-first;
                "Mod+End".action = focus-column-last;
                "Mod+Ctrl+Home".action = move-column-to-first;
                "Mod+Ctrl+End".action = move-column-to-last;

                "Mod+I".action = focus-workspace-down;
                "Mod+U".action = focus-workspace-up;
                "Mod+Ctrl+I".action = move-column-to-workspace-down;
                "Mod+Ctrl+U".action = move-column-to-workspace-up;

                "Mod+Shift+I".action = move-workspace-down;
                "Mod+Shift+U".action = move-workspace-up;

                "Mod+Tab".action = focus-workspace-previous;

                "Mod+Comma".action = consume-window-into-column;
                "Mod+Period".action = expel-window-from-column;

                "Mod+BracketLeft".action = consume-or-expel-window-left;
                "Mod+BracketRight".action = consume-or-expel-window-right;

                "Mod+R".action = switch-preset-column-width;
                "Mod+Shift+R".action = switch-preset-window-height;
                "Mod+F".action = maximize-column;
                "Mod+Shift+F".action = fullscreen-window;
                "Mod+C".action = center-column;

                "Mod+Minus".action = set-column-width "-10%";
                "Mod+Equal".action = set-column-width "+10%";

                "Mod+Shift+Minus".action = set-window-height "-10%";
                "Mod+Shift+Equal".action = set-window-height "+10%";

                "Print".action = screenshot;
                "Ctrl+Print".action = screenshot-screen;
                "Alt+Print".action = screenshot-window;

                "Mod+Shift+E".action = quit;

                "Mod+Shift+P".action = power-off-monitors;

                "XF86AudioRaiseVolume" = vol ["+2%"];
                "XF86AudioLowerVolume" = vol ["-2%"];

                "XF86AudioMute" = mute "sink";
                "XF86AudioMicMute" = mute "source";

                "XF86MonBrightnessUp" = brightness ["+2%"];
                "XF86MonBrightnessDown" = brightness ["2%-"];
            }
            // (lib.attrsets.mergeAttrsList (
                map (x: let
                    xStr = builtins.toString x;
                in {
                    "Mod+${xStr}".action = focus-workspace x;
                    "Mod+Shift+${xStr}".action = move-column-to-workspace x;
                })
                (builtins.genList (x: x + 1) 9)
            ));
        };
    };
}