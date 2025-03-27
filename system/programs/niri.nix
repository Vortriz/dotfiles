{
    programs.niri.enable = true;

    niri-flake.cache.enable = true;

    environment = {
        sessionVariables = {
            # for electron apps
            NIXOS_OZONE_WL = "1";

            # ugly fix for flameshot
            QT_SCREEN_SCALE_FACTORS = builtins.toString (2.0 / 3.0);
        };
    };
}
