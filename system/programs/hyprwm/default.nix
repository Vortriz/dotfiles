{
    lib,
    pkgs,
    inputs,
    ...
}: {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs = {
        hyprland = {
            enable = true;
        };
    };
}