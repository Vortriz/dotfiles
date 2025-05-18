{
    config,
    lib,
    osConfig,
    pkgs,
    ...
}:
with config.lib.niri.actions; let
    inherit (lib) getExe getExe' getName;
    inherit (lib.strings) splitString;

    inherit (osConfig.defaults) file-manager launcher terminal;

    spawn' = cmd: spawn (splitString " " cmd);

    execute = {
        cmd,
        notif ? null,
    }: {
        spawn =
            if notif == null
            then ["sh" "-c" cmd]
            else ["sh" "-c" ''${cmd} && ${pkgs.dunst}/bin/dunstify "${notif}"''];
    };

    vol = cmd: {
        allow-when-locked = true;
        action = spawn' "${pkgs.avizo}/bin/volumectl -d -u ${cmd}";
    };

    mute = cmd: {
        allow-when-locked = true;
        action = spawn' "${pkgs.avizo}/bin/volumectl -d ${cmd}";
    };

    brightness = cmd: {
        allow-when-locked = true;
        action = spawn' "${pkgs.avizo}/bin/lightctl -d -e 4 ${cmd}";
    };
in
    {
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Alt+Space".action = spawn' (getExe' launcher "sherlock");
        "Mod+T".action = spawn' (getExe terminal);
        "Mod+E".action = spawn' "${getExe terminal} --app-id=${getName file-manager} -o confirm_os_window_close=0 ${getExe file-manager}";
        "Ctrl+Shift+Escape".action = spawn' (getExe pkgs.mission-center);

        "Print".action = spawn' "${getExe pkgs.flameshot} gui";
        "Ctrl+Print".action = screenshot-window;
        "Ctrl+Shift+Print".action.screenshot-screen = []; #TODO: change after https://github.com/sodiboo/niri-flake/issues/944
        "Ctrl+Shift+O".action = spawn' "oimg";
        "Mod+C".action = spawn' "${getExe pkgs.hyprpicker} -andz";

        "Mod+H".action = execute {
            cmd = "niri msg output eDP-1 mode 2880x1800@90.001";
            notif = "Set display mode to 90Hz";
        };
        "Mod+Shift+H".action = execute {
            cmd = "niri msg output eDP-1 mode 2880x1800@60.001";
            notif = "Set display mode to 60Hz";
        };
        "Mod+Z".action = execute {
            cmd = "niri msg output eDP-1 scale 1";
            notif = "Set display scale to 1";
        };
        "Mod+Shift+Z".action = execute {
            cmd = "niri msg output eDP-1 scale 1.5";
            notif = "Set display scale to 1.5";
        };

        "Mod+Q".action = close-window;
        "Mod+L".action = execute {cmd = "niri msg action do-screen-transition && ${getExe pkgs.hyprlock} --immediate";};

        "Alt+Right".action = focus-window-down;
        "Alt+Left".action = focus-window-up;
        "Alt+Tab".action = focus-window-down-or-top;
        "Alt+Shift+Tab".action = focus-window-up-or-bottom;

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
            # "Mod+Ctrl+${xStr}".action = move-column-to-workspace x; # TODO: niri-flake is borked atm
        })
        (builtins.genList (x: x + 1) 9)
    ))
