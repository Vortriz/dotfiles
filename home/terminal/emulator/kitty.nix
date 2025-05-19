{
    programs.kitty = {
        enable = true;

        shellIntegration.enableFishIntegration = true;

        settings = {
            window_padding_width = 8;
            "mouse_map left click" = "ungrabbed mouse_handle_click prompt";
            "mouse_map ctrl+left click" = "ungrabbed mouse_handle_click link";
        };
    };

    stylix.targets.kitty.enable = true;
}
