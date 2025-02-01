{
    services.dunst = {
        enable = true;

        settings = {
            # fix for ugly flameshot warning
            ignore_flameshot_warning = {
                body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
                format = "";
            };
        };
    };
}