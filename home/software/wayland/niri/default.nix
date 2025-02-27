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

            spawn-at-startup =
                map (s: { command = pkgs.lib.strings.splitString " " s; })
                    [
                        "${pkgs.waybar}/bin/waybar"
                    ];

            prefer-no-csd = true;

            screenshot-path = "~/downloads/captures/screenshots/%Y-%m-%d %H-%M-%S.png";

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
                        { app-id = "obsidian"; }
                        { title = ".*pdf"; }
                    ];
                    open-maximized = true;
                }
                {
                    matches = [
                        { app-id = "io.missioncenter.MissionCenter"; }
                    ];
                    open-floating = true;
                    shadow.enable = true;
                    default-window-height.proportion = 0.6;
                    default-column-width.proportion = 0.75;
                    focus-ring = {
                        width = 4;
                        active.color = "#f38ba8";
                        inactive.color = "#ebebeb";
                    };
                }
                {
                    matches = [
                        { app-id = "org.gnome.Calculator"; }
                    ];
                    open-floating = true;
                    shadow.enable = true;
                }
                {
                    matches = [
                        { title = ".*pdf"; }
                        { app-id = "kitty"; }
                    ];
                    default-column-display = "tabbed";
                    # TODO: auto-tabbing
                }
                {
                    matches = [
                        { app-id = "obsidian"; }
                    ];
                    scroll-factor = 0.6;
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
                rr = cmd: {
                    spawn = [ "niri" "msg" "output" "eDP-1" "mode" ] ++ cmd;
                };
            in {
                "Mod+Shift+Slash".action = show-hotkey-overlay;

                "Mod+T".action = spawn "kitty";
                "Alt+Space".action = spawn "ulauncher";
                "Mod+E".action = spawn "nautilus";
                "Ctrl+Shift+Escape".action = spawn "missioncenter";

                "Ctrl+Shift+O".action = spawn "oimg";
                "Mod+H".action = rr [ "2880x1800@90.001" ];
                "Mod+Shift+H".action = rr [ "2880x1800@60.001" ];

                "Mod+Q".action = close-window;
                "Mod+L".action = spawn "lockoff";

                "Alt+Right".action = focus-window-up;
                "Alt+Left".action = focus-window-down;

                "Ctrl+Tab".action = focus-window-down-or-top;
                "Ctrl+Shift+Tab".action = focus-window-up-or-bottom;

                "Mod+Tab".action = focus-workspace-previous;

                "Mod+Home".action = focus-column-first;
                "Mod+End".action = focus-column-last;

                "Mod+Up".action = focus-workspace-up;
                "Mod+Down".action = focus-workspace-down;
                "Mod+Left".action = focus-column-left;
                "Mod+Right".action = focus-column-right;

                "Mod+Ctrl+Up".action = move-window-up-or-to-workspace-up;
                "Mod+Ctrl+Down".action = move-window-down-or-to-workspace-down;
                "Mod+Ctrl+Left".action = move-column-left;
                "Mod+Ctrl+Right".action = move-column-right;
                "Mod+Ctrl+Home".action = move-column-to-first;
                "Mod+Ctrl+End".action = move-column-to-last;

                "Mod+Shift+Up".action = move-workspace-up;
                "Mod+Shift+Down".action = move-workspace-down;

                "Mod+V".action = toggle-window-floating;

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

                "XF86AudioRaiseVolume" = vol ["+2%"];
                "XF86AudioLowerVolume" = vol ["-2%"];

                "XF86AudioMute" = mute "sink";
                "XF86AudioMicMute" = mute "source";

                "XF86MonBrightnessUp" = brightness ["+2%"];
                "XF86MonBrightnessDown" = brightness ["2%-"];

                "Print".action = screenshot;
                "Ctrl+Print".action = screenshot-screen;
                "Alt+Print".action = screenshot-window;

                "Mod+Shift+P".action = power-off-monitors;
                "Mod+Shift+E".action = quit;
            }
            // (lib.attrsets.mergeAttrsList (
                map (x: let
                    xStr = builtins.toString x;
                in {
                    "Mod+${xStr}".action = focus-workspace x;
                    "Mod+Ctrl+${xStr}".action = move-column-to-workspace x;
                })
                (builtins.genList (x: x + 1) 9)
            ));
        };
    };
}