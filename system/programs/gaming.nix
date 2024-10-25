{
    pkgs,
    ...
}: {
    programs.steam = {
        enable = true;
        # extraPackages = with pkgs; [
        #     gamescope
        # ];
        gamescopeSession.enable = true;
    };

    programs.gamescope = {
        enable = true;
    };
}