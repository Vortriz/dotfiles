{
    config,
    lib,
    osConfig,
    pkgs,
    ...
}:
with config.lib.niri.actions; let
    inherit (lib) getExe getName;
    inherit (lib.strings) splitString;

    inherit (osConfig.defaults) file-manager launcher terminal;

    spawn' = cmd: spawn (splitString " " cmd);

    open = {
        app,
        args ? "",
        title ? "Launch ${getName app}",
    }: {
        action = spawn' (lib.strings.trim "${getExe app} ${args}");
        hotkey-overlay = {inherit title;};
    };

    open-tui = {
        app,
        app-id,
    }: {
        action = spawn' "${getExe terminal} -o confirm_os_window_close=0 --app-id=${app-id} ${app}";
        hotkey-overlay.title = "Launch ${app-id}";
    };

    run = {
        cmd,
        notif ? null,
        title ? null,
    }: {
        action.spawn =
            if notif == null
            then ["sh" "-c" cmd]
            else ["sh" "-c" ''${cmd} && ${getExe pkgs.libnotify} "${notif}"''];
        hotkey-overlay =
            if title == null
            then {hidden = true;}
            else {inherit title;};
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

    niriswitcher-gdbus = cmd:
        "${pkgs.glib}/bin/gdbus call --session \
        --dest io.github.isaksamsten.Niriswitcher \
        --object-path /io/github/isaksamsten/Niriswitcher \
        --method io.github.isaksamsten.Niriswitcher."
        + cmd;
    niriswitcher-window = spawn' (niriswitcher-gdbus "application");
    niriswitcher-workspace = spawn' (niriswitcher-gdbus "workspace");
in
    {
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Alt+Space" = open {app = launcher;};
        "Mod+T" = open {app = terminal;};
        "Ctrl+Shift+Escape" = open {app = pkgs.mission-center;};

        "Mod+E" = open-tui {
            app = getExe file-manager;
            app-id = getName file-manager;
        };
        "Mod+P" = open-tui {
            app = "ns";
            app-id = getName config.programs.nix-search-tv.package;
        };

        "Print" = open {
            app = pkgs.flameshot;
            args = "gui";
            title = "Take screenshot with flameshot";
        };
        "Ctrl+Print".action = screenshot-window;
        "Ctrl+Shift+Print".action.screenshot-screen = []; # [TODO] change after https://github.com/sodiboo/niri-flake/issues/944

        "Mod+C" = run {
            cmd = "${getExe pkgs.zenity} --color-selection --title 'Color picker' --color $(${getExe pkgs.hyprpicker} -an)";
            title = "Open color picker";
        };
        "Mod+Period" = run {
            cmd = "${getExe launcher} --sub-menu emoji";
            title = "Open emoji picker";
        };
        "Ctrl+Shift+O".action = spawn' "oimg";

        "Mod+H" = run {
            cmd = "niri msg output eDP-1 mode 2880x1800@90.001";
            notif = "Set display mode to 90Hz";
        };
        "Mod+Shift+H" = run {
            cmd = "niri msg output eDP-1 mode 2880x1800@60.001";
            notif = "Set display mode to 60Hz";
        };
        "Mod+Z" = run {
            cmd = "niri msg output eDP-1 scale 1";
            notif = "Set display scale to 1";
        };
        "Mod+Shift+Z" = run {
            cmd = "niri msg output eDP-1 scale 1.5";
            notif = "Set display scale to 1.5";
        };

        "Mod+Q".action = close-window;
        "Mod+L" = run {
            cmd = "niri msg action do-screen-transition && ${getExe pkgs.hyprlock} --immediate";
            title = "Lock screen";
        };

        "Alt+Right".action = focus-window-down;
        "Alt+Left".action = focus-window-up;

        "Alt+Tab".action = niriswitcher-window;
        "Alt+Shift+Tab".action = niriswitcher-window;
        "Alt+grave".action = niriswitcher-workspace;
        "Alt+Shift+grave".action = niriswitcher-workspace;

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
        "Mod+Shift+C" = {
            action = center-column;
            hotkey-overlay.title = "Center Column";
        };

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
    // (builtins.genList (x: x + 1) 9
    |> map (x: {
        "Mod+${toString x}".action = focus-workspace x;
        # "Mod+Ctrl+${toString x}".action = move-column-to-workspace x; # [TODO] niri-flake is borked atm
    })
    |> lib.attrsets.mergeAttrsList)
