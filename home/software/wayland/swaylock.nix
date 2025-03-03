{
    pkgs,
    ...
}: {
    programs.swaylock = {
        enable = true;

        package = pkgs.swaylock-effects;
    };

    stylix.targets.swaylock.enable = true;

}