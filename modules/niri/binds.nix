{
    unify.home = {
        lib,
        pkgs,
        ...
    }: let
        inherit (lib) getExe;

        scripts = lib.packagesFromDirectoryRecursive {
            inherit (pkgs) callPackage;
            directory = ../../scripts;
        };
    in {
        wayland.windowManager.niri.settings.binds =
            {
                "Mod+Shift+Slash".show-hotkey-overlay = [];

                "Mod+Alt+W" = {
                    spawn-sh = getExe scripts.toggle-warp;
                    _props.hotkey-overlay-title = "Toggle Cloudflare Warp";
                };

                "Mod+H" = {
                    spawn-sh = getExe scripts.cycle-rr;
                    _props.hotkey-overlay-title = "Toggle refresh rate";
                };
                "Mod+Z" = {
                    spawn-sh = getExe scripts.cycle-scale;
                    _props.hotkey-overlay-title = "Toggle display scale";
                };

                "Print" = {
                    screenshot = [];
                    _props.hotkey-overlay-title = "Take screenshot";
                };
                "Ctrl+Print" = {
                    screenshot-window = [];
                    _props.hotkey-overlay-title = "Take screenshot of focused window";
                };
                "Ctrl+Shift+Print" = {
                    screenshot-screen = [];
                    _props.hotkey-overlay-title = "Take screenshot of focused display";
                };
                "Ctrl+Shift+O".spawn-sh = getExe scripts.obsidian-image;

                "Mod+Q".close-window = [];
                "Mod+Shift+Q" = {
                    spawn-sh = getExe scripts.close-all;
                    _props.hotkey-overlay-title = "Close all windows";
                };

                "Alt+Right".focus-window-down = [];
                "Alt+Left".focus-window-up = [];

                "Mod+Tab".focus-workspace-previous = [];
                "Mod+Shift+Tab".focus-column-right-or-first = [];

                "Mod+W".focus-workspace-up = [];
                "Mod+S".focus-workspace-down = [];
                "Mod+A".focus-column-left = [];
                "Mod+D".focus-column-right = [];

                "Mod+Ctrl+W".move-window-up-or-to-workspace-up = [];
                "Mod+Ctrl+S".move-window-down-or-to-workspace-down = [];
                "Mod+Ctrl+A".move-column-left-or-to-monitor-left = [];
                "Mod+Ctrl+D".move-column-right-or-to-monitor-right = [];

                "Mod+Shift+W".move-workspace-up = [];
                "Mod+Shift+S".move-workspace-down = [];

                "Mod+Up".toggle-window-floating = [];
                "Mod+Shift+T".toggle-column-tabbed-display = [];

                "Mod+BracketLeft".consume-or-expel-window-left = [];
                "Mod+BracketRight".consume-or-expel-window-right = [];

                "Mod+R".switch-preset-column-width = [];
                "Mod+Shift+R".switch-preset-window-height = [];
                "Mod+F".maximize-column = [];
                "Mod+Shift+F" = {
                    fullscreen-window = [];
                    _props.hotkey-overlay-title = "Fullscreen Window";
                };

                "Mod+Minus".set-column-width = "-10%";
                "Mod+Equal".set-column-width = "+10%";

                "Mod+Shift+Minus".set-window-height = "-10%";
                "Mod+Shift+Equal".set-window-height = "+10%";

                "Mod+Shift+C" = {
                    spawn-sh = "niri msg action set-dynamic-cast-window --id $(niri msg --json pick-window | ${getExe pkgs.jaq} .id)";
                    _props.hotkey-overlay-title = "Select dynamic cast target";
                };

                "Mod+Shift+O".power-off-monitors = [];
                "Mod+Shift+E".quit = [];
            }
            // (builtins.genList (x: x + 1) 9
            |> map (x: {
                "Mod+${toString x}".focus-workspace = x;
                "Mod+Ctrl+${toString x}".move-column-to-workspace = x;
            })
            |> lib.attrsets.mergeAttrsList);
    };
}
