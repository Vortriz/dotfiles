{ pkgs, ... }:

{
    programs.firefox = {
        enable = true;
        profiles.default.settings = {
            "mousewheel.default.delta_multiplier_x" = 10;
            "mousewheel.default.delta_multiplier_y" = 20;
        };
    };
}
