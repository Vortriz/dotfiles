{
    unify.home = {
        lib,
        pkgs,
        ...
    }: {
        programs.kitty = {
            enable = true;

            settings = {
                window_padding_width = 8;
                confirm_os_window_close = 0;
                "mouse_map left click" = "ungrabbed mouse_handle_click prompt";
                "mouse_map ctrl+left click" = "ungrabbed mouse_handle_click link";
                "map ctrl+shift+left" = "no_op";
                "map ctrl+shift+right" = "no_op";
                "map ctrl+t" = "new_tab";
                "map ctrl+w" = "close_tab";
            };
        };

        xdg.terminal-exec = {
            enable = true;
            settings.default = ["kitty.desktop"];
        };

        stylix.targets.kitty.enable = true;

        wayland.windowManager.niri.settings.binds = {
            "Mod+T" = {
                spawn-sh = "${lib.getExe pkgs.kitty}";
                _props.hotkey-overlay-title = "Open Kitty Terminal";
            };
        };
    };
}
