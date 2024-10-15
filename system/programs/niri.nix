{
    programs.niri.enable = true;
    niri-flake.cache.enable = true;
    environment = {
        sessionVariables = {
            # for electron apps
            NIXOS_OZONE_WL = "1";

            # ugly fix for flameshot
            QT_SCREEN_SCALE_FACTORS = "0.66666666667";
        };
    };
}
