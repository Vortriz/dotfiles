{
    config,
    lib,
    pkgs,
    ...
}:
with config.lib.niri.actions; let
    vol = cmd: {
        allow-when-locked = true;
        action.spawn = lib.strings.splitString " " "${pkgs.avizo}/bin/volumectl -d -u ${cmd}";
    };

    mute = cmd: {
        allow-when-locked = true;
        action.spawn = lib.strings.splitString " " "${pkgs.avizo}/bin/volumectl -d ${cmd}";
    };

    brightness = cmd: {
        allow-when-locked = true;
        action.spawn = lib.strings.splitString " " "${pkgs.avizo}/bin/lightctl -d -e 4 ${cmd}";
    };

    execute = {
        cmd,
        notif ? null,
    }: {
        spawn =
            if notif == null
            then ["sh" "-c" cmd]
            else ["sh" "-c" ''${cmd} && ${pkgs.dunst}/bin/dunstify "${notif}"''];
    };
in
    {
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Alt+Space".action = spawn "sherlock";
        "Mod+T".action = spawn "${pkgs.kitty}/bin/kitty";
        "Mod+E".action = spawn ["${pkgs.kitty}/bin/kitty" "--app-id=yazi" "-o" "confirm_os_window_close=0" "yazi"];
        "Ctrl+Shift+Escape".action = spawn "${pkgs.mission-center}/bin/missioncenter";

        "Print".action = spawn ["${pkgs.flameshot}/bin/flameshot" "gui"];
        "Ctrl+Print".action = screenshot-window;
        "Ctrl+Shift+Print".action.screenshot-screen = []; #TODO: change after https://github.com/sodiboo/niri-flake/issues/944
        "Ctrl+Shift+O".action = spawn "oimg";
        "Mod+C".action = spawn ["${pkgs.hyprpicker}/bin/hyprpicker" "-andz"];

        "Mod+H".action = execute {
            cmd = "niri msg output eDP-1 mode 2880x1800@90.001";
            notif = "Set display mode to 90Hz";
        };
        "Mod+Shift+H".action = execute {
            cmd = "niri msg output eDP-1 mode 2880x1800@60.001";
            notif = "Set display mode to 60Hz";
        };
        "Mod+S".action = execute {
            cmd = "niri msg output eDP-1 scale 1";
            notif = "Set display scale to 1";
        };
        "Mod+Shift+S".action = execute {
            cmd = "niri msg output eDP-1 scale 1.5";
            notif = "Set display scale to 1.5";
        };
        "Mod+L".action = spawn ["${pkgs.hyprlock}/bin/hyprlock" "--immediate"];

        "Mod+Q".action = close-window;

        "Alt+Right".action = focus-window-down;
        "Alt+Left".action = focus-window-up;
        "Alt+Tab".action = focus-window-down-or-top;
        "Alt+Shift+Tab".action = focus-window-up-or-bottom;

        "Mod+Tab".action = focus-workspace-previous;

        "Mod+Up".action = focus-workspace-up;
        "Mod+Down".action = focus-workspace-down;
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;

        "Mod+Ctrl+Up".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Right".action = move-column-right;

        "Mod+Shift+Up".action = move-workspace-up;
        "Mod+Shift+Down".action = move-workspace-down;

        "Mod+V".action = toggle-window-floating;
        "Mod+W".action = toggle-column-tabbed-display;

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Shift+C".action = center-column;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "XF86AudioRaiseVolume" = vol "+";
        "XF86AudioLowerVolume" = vol "-";

        "XF86AudioMute" = mute "%";
        "XF86AudioMicMute" = mute "-m %";

        "XF86MonBrightnessUp" = brightness "+";
        "XF86MonBrightnessDown" = brightness "-";

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
    ))
