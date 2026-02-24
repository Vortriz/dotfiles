{inputs, ...}: {
    unify = {
        nixos = {
            nixpkgs.overlays = [
                inputs.quickshell.overlays.default
            ];

            services.displayManager.gdm.enable = true;
        };

        home = {
            lib,
            pkgs,
            ...
        }: {
            imports = [
                inputs.niri-shell.homeModules.dank-material-shell
            ];

            programs.dank-material-shell = {
                enable = true;
                systemd.enable = true;
            };

            wayland.windowManager.niri.settings = {
                include = [
                    "dms/wpblur.kdl"
                ];

                binds = {
                    "Mod+B" = {
                        spawn-sh = "dms ipc bar toggle index 0";
                        _props.hotkey-overlay-title = "Toggle Bar";
                    };
                    "Mod+N" = {
                        spawn-sh = "dms ipc notifications toggle";
                        _props.hotkey-overlay-title = "Toggle Notification Center";
                    };
                    "Mod+I" = {
                        spawn-sh = "dms ipc settings toggle";
                        _props.hotkey-overlay-title = "Toggle Settings";
                    };
                    "Mod+X" = {
                        spawn-sh = "dms ipc powermenu toggle";
                        _props.hotkey-overlay-title = "Toggle Power Menu";
                    };
                    "XF86AudioRaiseVolume" = {
                        spawn-sh = "dms ipc audio increment 3";
                        _props.allow-when-locked = true;
                    };
                    "XF86AudioLowerVolume" = {
                        spawn-sh = "dms ipc audio decrement 3";
                        _props.allow-when-locked = true;
                    };
                    "XF86AudioMute" = {
                        spawn-sh = "dms ipc audio mute";
                        _props.allow-when-locked = true;
                    };
                    "XF86AudioMicMute" = {
                        spawn-sh = "dms ipc audio micmute";
                        _props.allow-when-locked = true;
                    };
                    "XF86MonBrightnessUp" = {
                        spawn-sh = "dms ipc brightness increment 5 \"\"";
                        _props.allow-when-locked = true;
                    };
                    "XF86MonBrightnessDown" = {
                        spawn-sh = "dms ipc brightness decrement 5 \"\"";
                        _props.allow-when-locked = true;
                    };
                    "Mod+Alt+N" = {
                        spawn-sh = "dms ipc night toggle";
                        _props.hotkey-overlay-title = "Toggle Night Mode";
                    };
                    "Mod+V" = {
                        spawn-sh = "dms ipc clipboard toggle";
                        _props.hotkey-overlay-title = "Toggle Clipboard Manager";
                    };

                    "Mod+C" = {
                        spawn-sh = lib.getExe (
                            pkgs.writers.writeFishBin "pick-color"
                            {
                                makeWrapperArgs = [
                                    "--prefix"
                                    "PATH"
                                    ":"
                                    "${lib.makeBinPath [
                                        pkgs.jaq
                                        pkgs.zenity
                                        pkgs.wl-clipboard
                                    ]}"
                                ];
                            }
                            ''
                                set -l color $(dms color pick --json | jaq -r .hex)
                                wl-copy $color
                                zenity --color-selection --title 'Color picker' --color $color
                            ''
                        );
                        _props.hotkey-overlay-title = "Open color picker";
                    };

                    "Ctrl+Shift+Escape" = {
                        spawn-sh = "dms ipc processlist toggle";
                        _props.hotkey-overlay-title = "Toggle Process List";
                    };
                };
            };

            home.packages = with pkgs; [
                wl-mirror
            ];
        };
    };
}
