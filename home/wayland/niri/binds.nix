{
    config,
    lib,
    pkgs,
    ...
}:
with config.lib.niri.actions; let
    inherit (lib) getExe;
    inherit (config.niri-lib) run;
in {
    programs.niri.settings.binds =
        {
            "Mod+Shift+Slash".action = show-hotkey-overlay;

            "Ctrl+Print" = {
                action.screenshot-window = [];
                hotkey-overlay.title = "Take screenshot of focused window";
            };
            "Ctrl+Shift+Print" = {
                action.screenshot-screen = []; # [TODO] change after https://github.com/sodiboo/niri-flake/issues/944
                hotkey-overlay.title = "Take screenshot of focused display";
            };

            "Mod+C" = run {
                cmd = "${getExe pkgs.zenity} --color-selection --title 'Color picker' --color $(${getExe pkgs.hyprpicker} -an)";
                title = "Open color picker";
            };

            "Mod+Alt+W" = run {
                cmd = "toggle-warp";
            };

            "Ctrl+Shift+O".action = spawn-sh "oimg";

            "Mod+H" = run {
                cmd = "cycle-rr";
                title = "Toggle refresh rate";
            };
            "Mod+Z" = run {
                cmd = "cycle-scale";
                title = "Toggle display scale";
            };

            "Mod+Q".action = close-window;

            "Alt+Right".action = focus-window-down;
            "Alt+Left".action = focus-window-up;

            "Mod+Tab".action = focus-workspace-previous;
            "Mod+Shift+Tab".action = focus-column-right-or-first;

            "Mod+W".action = focus-workspace-up;
            "Mod+S".action = focus-workspace-down;
            "Mod+A".action = focus-column-left;
            "Mod+D".action = focus-column-right;

            "Mod+Ctrl+W".action = move-window-up-or-to-workspace-up;
            "Mod+Ctrl+S".action = move-window-down-or-to-workspace-down;
            "Mod+Ctrl+A".action = move-column-left;
            "Mod+Ctrl+D".action = move-column-right;

            "Mod+Shift+W".action = move-workspace-up;
            "Mod+Shift+S".action = move-workspace-down;

            "Mod+Up".action = toggle-window-floating;
            "Mod+Shift+T".action = toggle-column-tabbed-display;

            "Mod+BracketLeft".action = consume-or-expel-window-left;
            "Mod+BracketRight".action = consume-or-expel-window-right;

            "Mod+R".action = switch-preset-column-width;
            "Mod+Shift+R".action = switch-preset-window-height;
            "Mod+F".action = maximize-column;
            "Mod+Shift+F" = {
                action = fullscreen-window;
                hotkey-overlay.title = "Fullscreen Window";
            };

            "Mod+Minus".action = set-column-width "-10%";
            "Mod+Equal".action = set-column-width "+10%";

            "Mod+Shift+Minus".action = set-window-height "-10%";
            "Mod+Shift+Equal".action = set-window-height "+10%";

            "Mod+Shift+Q".action = spawn-sh "close-all";
            "Mod+Shift+P".action = power-off-monitors;
            "Mod+Shift+E".action = quit;
        }
        // (builtins.genList (x: x + 1) 9
        |> map (x: {
            "Mod+${toString x}".action = focus-workspace x;
            # "Mod+Ctrl+${toString x}".action = move-column-to-workspace x; # [TODO] niri-flake is borked atm
        })
        |> lib.attrsets.mergeAttrsList);
}
